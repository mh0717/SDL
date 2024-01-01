//
//  SDL_pbview.c
//  SDL
//
//  Created by Huima on 2021/8/27.
//

//#include "SDL_pbview.h"
//
//
//@implementation SDL_pbview
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super init];
//    if (self) {
//        self.layer = [[CAEAGLLayer alloc] init];
//        self.layer.frame = frame;
//    }
//
//    return self;
//}
//
//- (CGRect) bounds {
//    return self.layer.bounds;
//}
//
//- (void) setBounds:(CGRect)bounds {
//    self.layer.bounds = bounds;
//}
//
//- (CGRect) frame {
//    return self.layer.frame;
//}
//
//- (void) setFrame:(CGRect)frame {
//    self.layer.frame = frame;
//}
//
//- (CGFloat) contentScaleFactor {
//    return  self.layer.contentsScale;
//}
//
//- (void) setContentScaleFactor:(CGFloat)contentScaleFactor {
//    self.layer.contentsScale = contentScaleFactor;
//}
//
//- (void)setSDLWindow:(SDL_Window *)window {
//
//}
//
//- (void)layoutSubviews {
//
//}
//
//- (void) setNeedsLayout {
//
//}
//
//- (void) layoutIfNeeded {
//
//}
//
////#if !TARGET_OS_TV && defined(__IPHONE_13_4)
////- (UIPointerRegion *)pointerInteraction:(UIPointerInteraction *)interaction regionForRequest:(UIPointerRegionRequest *)request defaultRegion:(UIPointerRegion *)defaultRegion API_AVAILABLE(ios(13.4));
////- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction styleForRegion:(UIPointerRegion *)region  API_AVAILABLE(ios(13.4));
////#endif
////
////- (CGPoint)touchLocation:(UITouch *)touch shouldNormalize:(BOOL)normalize;
////- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
////- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
////- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//
//@end




#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_PBOX

#include "SDL_pbview.h"

#include "SDL_hints.h"
#include "../../events/SDL_mouse_c.h"
#include "../../events/SDL_touch_c.h"
#include "../../events/SDL_events_c.h"

//#include "SDL_uikitappdelegate.h"
#include "SDL_pbevents.h"
#include "SDL_pbmodes.h"
#include "SDL_pbwindow.h"

/* The maximum number of mouse buttons we support */
#define MAX_MOUSE_BUTTONS    5

/* This is defined in SDL_sysjoystick.m */
#if !SDL_JOYSTICK_DISABLED
extern int SDL_AppleTVRemoteOpenedAsJoystick;
#endif


@implementation SDL_pbview {
    SDL_Window *sdlwindow;

    SDL_TouchID directTouchId;
    SDL_TouchID indirectTouchId;
}

- (SDL_Window*) window {
    return sdlwindow;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super init])) {
        
        void (^handler)(void) = ^{
            self.view = [[SDL_pbuiview alloc] initWithFrame:frame];
            self.view.opaque = YES;
            self.view.backgroundColor = UIColor.blackColor;
            self.view.userInteractionEnabled = NO;
            self.contentScaleFactor = self.view.contentScaleFactor;
        };
        if (NSThread.isMainThread) {
            handler();
        }
        else {
            dispatch_sync(dispatch_get_main_queue(), handler);
        }
    }

    return self;
}

- (CGRect) bounds {
    return CGRectMake(0, 0, _frame.size.width, _frame.size.height);
}

- (void)layoutSubviews {
    
}

- (void) setNeedsLayout {
}

- (void) layoutIfNeeded {
}

- (void) removeFromSuperview {
    if (NSThread.isMainThread) {
        [self.view removeFromSuperview];
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.view removeFromSuperview];
        });
    }
}

- (void)setSDLWindow:(SDL_Window *)window
{
    SDL_PBWindowData *data = nil;

    if (window == sdlwindow) {
        return;
    }

    /* Remove ourself from the old window. */
    if (sdlwindow) {
        SDL_pbview *view = nil;
        data = (__bridge SDL_PBWindowData *) sdlwindow->driverdata;

        [data.views removeObject:self];

        [self removeFromSuperview];

        /* Restore the next-oldest view in the old window. */
        view = data.views.lastObject;

        data.viewcontroller.view = view;

//        data.uiwindow.rootViewController = nil;
//        data.uiwindow.rootViewController = data.viewcontroller;

        [data.uiwindow layoutIfNeeded];
        
        if (data.uvcontroller) {
            data.uvcontroller.swindow = NULL;
        }
        
        if (data.viewcontroller) {
            data.viewcontroller.window = NULL;
        }
    }

    /* Add ourself to the new window. */
    if (window) {
        data = (__bridge SDL_PBWindowData *) window->driverdata;

        /* Make sure the SDL window has a strong reference to this view. */
        [data.views addObject:self];

        /* Replace the view controller's old view with this one. */
        [data.viewcontroller.view removeFromSuperview];
        data.viewcontroller.view = self;

        /* The root view controller handles rotation and the status bar.
         * Assigning it also adds the controller's view to the window. We
         * explicitly re-set it to make sure the view is properly attached to
         * the window. Just adding the sub-view if the root view controller is
         * already correct causes orientation issues on iOS 7 and below. */
        data.uiwindow.rootViewController = nil;
        data.uiwindow.rootViewController = data.viewcontroller;
        
        if (data.uvcontroller) {
            data.uvcontroller.swindow = window;
        }
        
        if (data.viewcontroller) {
            data.viewcontroller.window = window;
        }

        /* The view's bounds may not be correct until the next event cycle. That
         * might happen after the current dimensions are queried, so we force a
         * layout now to immediately update the bounds. */
        [data.uiwindow layoutIfNeeded];
    }

    sdlwindow = window;
}

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
- (UIPointerRegion *)pointerInteraction:(UIPointerInteraction *)interaction regionForRequest:(UIPointerRegionRequest *)request defaultRegion:(UIPointerRegion *)defaultRegion API_AVAILABLE(ios(13.4)){
    if (request != nil && !SDL_PBHasGCMouse()) {
        CGPoint origin = self.bounds.origin;
        CGPoint point = request.location;

        point.x -= origin.x;
        point.y -= origin.y;

        SDL_SendMouseMotion(sdlwindow, 0, 0, (int)point.x, (int)point.y);
    }
    return [UIPointerRegion regionWithRect:self.bounds identifier:nil];
}

- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction styleForRegion:(UIPointerRegion *)region  API_AVAILABLE(ios(13.4)){
    if (SDL_ShowCursor(-1)) {
        return nil;
    } else {
        return [UIPointerStyle hiddenPointerStyle];
    }
}
#endif /* !TARGET_OS_TV && __IPHONE_13_4 */


@end



@interface SDL_pbuiview()


@end

@implementation SDL_pbuiview {
    SDL_TouchID directTouchId;
    SDL_TouchID indirectTouchId;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame: frame])) {

        directTouchId = 1;
        indirectTouchId = 2;

#if !TARGET_OS_TV
        self.multipleTouchEnabled = YES;
        SDL_AddTouch(directTouchId, SDL_TOUCH_DEVICE_DIRECT, "");
#endif

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
        if (@available(iOS 13.4, *)) {
            [self addInteraction:[[UIPointerInteraction alloc] initWithDelegate:self]];
        }
#endif
    }

    return self;
}

- (SDL_Window*) swindow {
    if ([self.nextResponder.nextResponder isKindOfClass:[SDL_pbuicontroller class]]) {
        return ((SDL_pbuicontroller*) self.nextResponder.nextResponder).swindow;
    }
    return NULL;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (self.swindow == NULL) {
        return;
    }
    
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) self.swindow->driverdata;
    SDL_pbview* view = data.viewcontroller.view;
    CGRect sframe = self.bounds;
    CGFloat scale = self.contentScaleFactor;
    [data.uiqueue addObject:^{
        view.frame = sframe;
        view.contentScaleFactor = scale;
        [view layoutSubviews];
    }];
}

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
- (UIPointerRegion *)pointerInteraction:(UIPointerInteraction *)interaction regionForRequest:(UIPointerRegionRequest *)request defaultRegion:(UIPointerRegion *)defaultRegion API_AVAILABLE(ios(13.4)){
    if (request != nil && !SDL_PBHasGCMouse()) {
        CGPoint origin = self.bounds.origin;
        CGPoint point = request.location;

        point.x -= origin.x;
        point.y -= origin.y;
        int px = point.x;
        int py = point.y;
        
        if (self.swindow) {
            SDL_Window* wd = self.swindow;
            SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
            [wddata.uiqueue addObject:^{
                SDL_SendMouseMotion(wd, 0, 0, (int)px, (int)py);
            }];
        }

    }
    
    return [UIPointerRegion regionWithRect:self.bounds identifier:nil];
}

- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction styleForRegion:(UIPointerRegion *)region  API_AVAILABLE(ios(13.4)){
    if (SDL_ShowCursor(-1)) {
        return nil;
    } else {
        return [UIPointerStyle hiddenPointerStyle];
    }
}


#endif /* !TARGET_OS_TV && __IPHONE_13_4 */

- (SDL_TouchDeviceType)touchTypeForTouch:(UITouch *)touch
{
#ifdef __IPHONE_9_0
    if ([touch respondsToSelector:@selector((type))]) {
        if (touch.type == UITouchTypeIndirect) {
            return SDL_TOUCH_DEVICE_INDIRECT_RELATIVE;
        }
    }
#endif

    return SDL_TOUCH_DEVICE_DIRECT;
}

- (SDL_TouchID)touchIdForType:(SDL_TouchDeviceType)type
{
    switch (type) {
        case SDL_TOUCH_DEVICE_DIRECT:
        default:
            return directTouchId;
        case SDL_TOUCH_DEVICE_INDIRECT_RELATIVE:
            return indirectTouchId;
    }
}

- (CGPoint)touchLocation:(UITouch *)touch shouldNormalize:(BOOL)normalize
{
    CGPoint point = [touch locationInView:self];

    if (normalize) {
        CGRect bounds = self.bounds;
        point.x /= bounds.size.width;
        point.y /= bounds.size.height;
    }

    return point;
}

- (float)pressureForTouch:(UITouch *)touch
{
#ifdef __IPHONE_9_0
    if ([touch respondsToSelector:@selector(force)]) {
        return (float) touch.force;
    }
#endif

    return 1.0f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SDL_Window* wd = self.swindow;
    if (wd == NULL) return;
    SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
    
    for (UITouch *touch in touches) {
        BOOL handled = NO;

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
        if (@available(iOS 13.4, *)) {
            if (touch.type == UITouchTypeIndirectPointer) {
                if (!SDL_PBHasGCMouse()) {
                    int i;

                    for (i = 1; i <= MAX_MOUSE_BUTTONS; ++i) {
                        if ((event.buttonMask & SDL_BUTTON(i)) != 0) {
                            Uint8 button;

                            switch (i) {
                            case 1:
                                button = SDL_BUTTON_LEFT;
                                break;
                            case 2:
                                button = SDL_BUTTON_RIGHT;
                                break;
                            case 3:
                                button = SDL_BUTTON_MIDDLE;
                                break;
                            default:
                                button = (Uint8)i;
                                break;
                            }
                            
                            
                            [wddata.uiqueue addObject:^{
                                SDL_SendMouseButton(wd, 0, SDL_PRESSED, button);
                            }];
                            
                        }
                    }
                }
                handled = YES;
            }
        }
#endif
        if (!handled) {
            SDL_TouchDeviceType touchType = [self touchTypeForTouch:touch];
            SDL_TouchID touchId = [self touchIdForType:touchType];
            float pressure = [self pressureForTouch:touch];
            CGPoint locationInView = [self touchLocation:touch shouldNormalize:YES];
            CGFloat lx = locationInView.x;
            CGFloat ly = locationInView.y;
            
            [wddata.uiqueue addObject:^{
                if (SDL_AddTouch(touchId, touchType, "") < 0) {
                    return;
                }
                SDL_SendTouch(touchId, (SDL_FingerID)((size_t)touch), wd, SDL_TRUE, lx, ly, pressure);
            }];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    SDL_Window* wd = self.swindow;
    if (wd == NULL) return;
    SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
    
    for (UITouch *touch in touches) {
        BOOL handled = NO;

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
        if (@available(iOS 13.4, *)) {
            if (touch.type == UITouchTypeIndirectPointer) {
                if (!SDL_PBHasGCMouse()) {
                    int i;

                    for (i = 1; i <= MAX_MOUSE_BUTTONS; ++i) {
                        if ((event.buttonMask & SDL_BUTTON(i)) != 0) {
                            Uint8 button;

                            switch (i) {
                            case 1:
                                button = SDL_BUTTON_LEFT;
                                break;
                            case 2:
                                button = SDL_BUTTON_RIGHT;
                                break;
                            case 3:
                                button = SDL_BUTTON_MIDDLE;
                                break;
                            default:
                                button = (Uint8)i;
                                break;
                            }
                            [wddata.uiqueue addObject:^{
                                SDL_SendMouseButton(wd, 0, SDL_RELEASED, button);
                            }];
                            
                        }
                    }
                }
                handled = YES;
            }
        }
#endif
        if (!handled) {
            SDL_TouchDeviceType touchType = [self touchTypeForTouch:touch];
            SDL_TouchID touchId = [self touchIdForType:touchType];
            float pressure = [self pressureForTouch:touch];
            CGPoint locationInView = [self touchLocation:touch shouldNormalize:YES];
            CGFloat lx = locationInView.x;
            CGFloat ly = locationInView.y;
            
            [wddata.uiqueue addObject:^{
                if (SDL_AddTouch(touchId, touchType, "") < 0) {
                    return;
                }
                SDL_SendTouch(touchId, (SDL_FingerID)((size_t)touch), wd, SDL_FALSE, lx, ly, pressure);
            }];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    SDL_Window* wd = self.swindow;
    if (wd == NULL) return;
    SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
    
    for (UITouch *touch in touches) {
        BOOL handled = NO;

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
        if (@available(iOS 13.4, *)) {
            if (touch.type == UITouchTypeIndirectPointer) {
                /* Already handled in pointerInteraction callback */
                handled = YES;
            }
        }
#endif
        if (!handled) {
            SDL_TouchDeviceType touchType = [self touchTypeForTouch:touch];
            SDL_TouchID touchId = [self touchIdForType:touchType];
            float pressure = [self pressureForTouch:touch];
            CGPoint locationInView = [self touchLocation:touch shouldNormalize:YES];
            CGFloat lx = locationInView.x;
            CGFloat ly = locationInView.y;
            
            [wddata.uiqueue addObject:^{
                if (SDL_AddTouch(touchId, touchType, "") < 0) {
                    return;
                }
                SDL_SendTouchMotion(touchId, (SDL_FingerID)((size_t)touch), wd, lx, ly, pressure);
            }];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

@end

#endif /* SDL_VIDEO_DRIVER_UIKIT */
