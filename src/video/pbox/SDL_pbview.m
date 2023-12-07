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



@interface SDL_pbuiglview : SDL_pbuiview

@property(nonatomic, weak) UIButton* exitButton;

@end

@implementation SDL_pbuiglview

//- (instancetype) initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    
//    UIButton* exitBtn = [UIButton buttonWithType:UIButtonTypeClose];
//    exitBtn.userInteractionEnabled = YES;
//    [exitBtn addTarget:self action:@selector(handleExit) forControlEvents:UIControlEventTouchDown];
//    [self addSubview:exitBtn];
//    self.exitButton = exitBtn;
//    
//    return  self;
//}
//
//- (void) handleExit {
//    if ([self.nextResponder isKindOfClass:[SDL_pbuicontroller class]]) {
//        [(SDL_pbuicontroller*)self.nextResponder dismissViewControllerAnimated:YES completion:nil];
//    }
//}
//
//- (void) layoutSubviews {
//    [super layoutSubviews];
//    
//    UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
//    CGFloat statusBarHeight = statusBarManager.statusBarFrame.size.height;
//    self.exitButton.frame = CGRectMake(self.frame.size.width - 50, statusBarHeight + 5, 30, 30);
//}



+ (Class) layerClass {
    return [CAEAGLLayer class];
}

@end


@implementation SDL_pblayer

//- (instancetype) init {
//    self = [super init];
//    self.rawPixels = NULL;
//    return self;
//}

- (BOOL) contentsAreFlipped {
    return YES;
}

- (nullable id<CAAction>)actionForKey:(NSString *)event {
    return nil;
}

//- (void)removeFromSuperlayer {
//    [super removeFromSuperlayer];
//
////    if (self.rawPixels != NULL) {
////        free(self.rawPixels);
////        self.rawPixels = NULL;
////    }
//}
//
//- (void) dealloc {
////    if (self.rawPixels != NULL) {
////        free(self.rawPixels);
////        self.rawPixels = NULL;
////    }
//}

@end

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
//        self.layer = [[CALayer alloc] init];
////        self.layer.anchorPoint = CGPointZero;
//        self.layer.frame = frame;
//        self.layer.opaque = YES;
//        self.layer.backgroundColor = UIColor.blackColor.CGColor;
//        self.layer.transform = CATransform3DMakeScale(1, -1, 1);
////        self.layer.geometryFlipped = YES;
//
        
        void (^handler)(void) = ^{
            self.view = [[SDL_pbuiglview alloc] initWithFrame:frame];
//            self.view.transform = CGAffineTransformMakeScale(1.0, -1.0);
            self.view.opaque = YES;
            self.view.backgroundColor = UIColor.blackColor;
            self.view.userInteractionEnabled = NO;
            self.eaglLayer = (CAEAGLLayer*)self.view.layer;
        };
        if (NSThread.isMainThread) {
            handler();
        }
        else {
            dispatch_sync(dispatch_get_main_queue(), handler);
        }
//#if TARGET_OS_TV
//        /* Apple TV Remote touchpad swipe gestures. */
//        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//        [self addGestureRecognizer:swipeUp];
//
//        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//        [self addGestureRecognizer:swipeDown];
//
//        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//        [self addGestureRecognizer:swipeLeft];
//
//        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//        [self addGestureRecognizer:swipeRight];
//#elif defined(__IPHONE_13_4)
//        if (@available(iOS 13.4, *)) {
//            UIPanGestureRecognizer *mouseWheelRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mouseWheelGesture:)];
//            mouseWheelRecognizer.allowedScrollTypesMask = UIScrollTypeMaskDiscrete;
//            mouseWheelRecognizer.allowedTouchTypes = @[ @(UITouchTypeIndirectPointer) ];
//            mouseWheelRecognizer.cancelsTouchesInView = NO;
//            mouseWheelRecognizer.delaysTouchesBegan = NO;
//            mouseWheelRecognizer.delaysTouchesEnded = NO;
//            [self addGestureRecognizer:mouseWheelRecognizer];
//        }
//#endif

//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        self.autoresizesSubviews = YES;

        directTouchId = 1;
        indirectTouchId = 2;

#if !TARGET_OS_TV
        self.multipleTouchEnabled = YES;
        SDL_AddTouch(directTouchId, SDL_TOUCH_DEVICE_DIRECT, "");
#endif

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
//        if (@available(iOS 13.4, *)) {
//            [self addInteraction:[[UIPointerInteraction alloc] initWithDelegate:self]];
//        }
#endif
    }

    return self;
}

- (CGRect) bounds {
//    return self.layer.bounds;
    return self.view.bounds;
}

- (void) setBounds:(CGRect)bounds {
//    self.layer.bounds = bounds;
    if (NSThread.isMainThread) {
        self.view.bounds = bounds;
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.bounds = bounds;
        });
    }
    
}

- (CGRect) frame {
//    return self.layer.frame;
    return self.view.frame;
}

- (void) setFrame:(CGRect)frame {
//    self.layer.frame = frame;
    if (NSThread.isMainThread) {
        self.view.frame = frame;
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.frame = frame;
        });
    }
    
}

- (CGFloat) contentScaleFactor {
//    return  self.layer.contentsScale;
    return self.view.contentScaleFactor;
}

- (void) setContentScaleFactor:(CGFloat)contentScaleFactor {
//    self.layer.contentsScale = contentScaleFactor;
    if (NSThread.isMainThread) {
        self.view.contentScaleFactor = contentScaleFactor;
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.contentScaleFactor = contentScaleFactor;
        });
    }
    
}

- (void)layoutSubviews {
    SDL_SendWindowEvent(self.window, SDL_WINDOWEVENT_RESIZED, self.bounds.size.width, self.bounds.size.height);
}

- (void) setNeedsLayout {
//    if (self.uiview) {
//        UIView* uview = self.uiview;
//        [NSOperationQueue.mainQueue addOperationWithBlock:^{
//            [uview setNeedsLayout];
//        }];
//    }
}

- (void) layoutIfNeeded {
//    if (self.uiview) {
//        UIView* uview = self.uiview;
//        [NSOperationQueue.mainQueue addOperationWithBlock:^{
//            [uview layoutIfNeeded];
//        }];
//    }
}

- (void) removeFromSuperview {
//    [self.layer removeFromSuperlayer];
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

        data.uiwindow.rootViewController = nil;
        data.uiwindow.rootViewController = data.viewcontroller;

        [data.uiwindow layoutIfNeeded];
        
        if (data.uvcontroller) {
            data.uvcontroller.swindow = NULL;
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
    UIView* view = ((__bridge SDL_PBWindowData*)self.window->driverdata).uvcontroller.view;
    CGPoint point = [touch locationInView:view];

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
                            SDL_SendMouseButton(sdlwindow, 0, SDL_PRESSED, button);
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

            if (SDL_AddTouch(touchId, touchType, "") < 0) {
                continue;
            }

            /* FIXME, need to send: int clicks = (int) touch.tapCount; ? */

            CGPoint locationInView = [self touchLocation:touch shouldNormalize:YES];
            SDL_SendTouch(touchId, (SDL_FingerID)((size_t)touch), sdlwindow,
                          SDL_TRUE, locationInView.x, locationInView.y, pressure);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
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
                            SDL_SendMouseButton(sdlwindow, 0, SDL_RELEASED, button);
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

            if (SDL_AddTouch(touchId, touchType, "") < 0) {
                continue;
            }

            /* FIXME, need to send: int clicks = (int) touch.tapCount; ? */

            CGPoint locationInView = [self touchLocation:touch shouldNormalize:YES];
            SDL_SendTouch(touchId, (SDL_FingerID)((size_t)touch), sdlwindow,
                          SDL_FALSE, locationInView.x, locationInView.y, pressure);
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
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

            if (SDL_AddTouch(touchId, touchType, "") < 0) {
                continue;
            }

            CGPoint locationInView = [self touchLocation:touch shouldNormalize:YES];
            SDL_SendTouchMotion(touchId, (SDL_FingerID)((size_t)touch), sdlwindow,
                                locationInView.x, locationInView.y, pressure);
        }
    }
}

#if TARGET_OS_TV || defined(__IPHONE_9_1)
- (SDL_Scancode)scancodeFromPress:(UIPress*)press
{
#ifdef __IPHONE_13_4
    if ([press respondsToSelector:@selector((key))]) {
        if (press.key != nil) {
            return (SDL_Scancode)press.key.keyCode;
        }
    }
#endif

#if !SDL_JOYSTICK_DISABLED
    /* Presses from Apple TV remote */
    if (!SDL_AppleTVRemoteOpenedAsJoystick) {
        switch (press.type) {
        case UIPressTypeUpArrow:
            return SDL_SCANCODE_UP;
        case UIPressTypeDownArrow:
            return SDL_SCANCODE_DOWN;
        case UIPressTypeLeftArrow:
            return SDL_SCANCODE_LEFT;
        case UIPressTypeRightArrow:
            return SDL_SCANCODE_RIGHT;
        case UIPressTypeSelect:
            /* HIG says: "primary button behavior" */
            return SDL_SCANCODE_RETURN;
        case UIPressTypeMenu:
            /* HIG says: "returns to previous screen" */
            return SDL_SCANCODE_ESCAPE;
        case UIPressTypePlayPause:
            /* HIG says: "secondary button behavior" */
            return SDL_SCANCODE_PAUSE;
        default:
            break;
        }
    }
#endif /* !SDL_JOYSTICK_DISABLED */

    return SDL_SCANCODE_UNKNOWN;
}

- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    if (!SDL_PBHasGCKeyboard()) {
        for (UIPress *press in presses) {
            SDL_Scancode scancode = [self scancodeFromPress:press];
            SDL_SendKeyboardKey(SDL_PRESSED, scancode);
        }
    }
//    [super pressesBegan:presses withEvent:event];
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    if (!SDL_PBHasGCKeyboard()) {
        for (UIPress *press in presses) {
            SDL_Scancode scancode = [self scancodeFromPress:press];
            SDL_SendKeyboardKey(SDL_RELEASED, scancode);
        }
    }
//    [super pressesEnded:presses withEvent:event];
}

- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    if (!SDL_PBHasGCKeyboard()) {
        for (UIPress *press in presses) {
            SDL_Scancode scancode = [self scancodeFromPress:press];
            SDL_SendKeyboardKey(SDL_RELEASED, scancode);
        }
    }
//    [super pressesCancelled:presses withEvent:event];
}

- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    /* This is only called when the force of a press changes. */
//    [super pressesChanged:presses withEvent:event];
}

#endif /* TARGET_OS_TV || defined(__IPHONE_9_1) */

-(void)mouseWheelGesture:(UIPanGestureRecognizer *)gesture
{
    UIView* view = ((__bridge SDL_PBWindowData*)self.window->driverdata).uvcontroller.view;
    
    if (gesture.state == UIGestureRecognizerStateBegan ||
        gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [gesture velocityInView:view];

        if (velocity.x > 0.0f) {
            velocity.x = -1.0;
        } else if (velocity.x < 0.0f) {
            velocity.x = 1.0f;
        }
        if (velocity.y > 0.0f) {
            velocity.y = -1.0;
        } else if (velocity.y < 0.0f) {
            velocity.y = 1.0f;
        }
        if (velocity.x != 0.0f || velocity.y != 0.0f) {
            SDL_SendMouseWheel(sdlwindow, 0, velocity.x, velocity.y, SDL_MOUSEWHEEL_NORMAL);
        }
    }
}

#if TARGET_OS_TV
-(void)swipeGesture:(UISwipeGestureRecognizer *)gesture
{
    /* Swipe gestures don't trigger begin states. */
    if (gesture.state == UIGestureRecognizerStateEnded) {
#if !SDL_JOYSTICK_DISABLED
        if (!SDL_AppleTVRemoteOpenedAsJoystick) {
            /* Send arrow key presses for now, as we don't have an external API
             * which better maps to swipe gestures. */
            switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionUp:
                SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_UP);
                break;
            case UISwipeGestureRecognizerDirectionDown:
                SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_DOWN);
                break;
            case UISwipeGestureRecognizerDirectionLeft:
                SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_LEFT);
                break;
            case UISwipeGestureRecognizerDirectionRight:
                SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_RIGHT);
                break;
            }
        }
#endif /* !SDL_JOYSTICK_DISABLED */
    }
}
#endif /* TARGET_OS_TV */

@end



@interface SDL_pbuiview()

@property(nonatomic, weak) UIButton* exitButton;

@end

@implementation SDL_pbuiview {
    SDL_TouchID directTouchId;
    SDL_TouchID indirectTouchId;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame: frame])) {
        
//#if TARGET_OS_TV
//        /* Apple TV Remote touchpad swipe gestures. */
        
        
        
//        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//        [self addGestureRecognizer:swipeUp];
//
//        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//        [self addGestureRecognizer:swipeDown];
//
//        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//        [self addGestureRecognizer:swipeLeft];
//
//        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//        [self addGestureRecognizer:swipeRight];
        
        
        
        
        
//#elif defined(__IPHONE_13_4)
//        if (@available(iOS 13.4, *)) {
//            UIPanGestureRecognizer *mouseWheelRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mouseWheelGesture:)];
//            mouseWheelRecognizer.allowedScrollTypesMask = UIScrollTypeMaskDiscrete;
//            mouseWheelRecognizer.allowedTouchTypes = @[ @(UITouchTypeIndirectPointer) ];
//            mouseWheelRecognizer.cancelsTouchesInView = NO;
//            mouseWheelRecognizer.delaysTouchesBegan = NO;
//            mouseWheelRecognizer.delaysTouchesEnded = NO;
//            [self addGestureRecognizer:mouseWheelRecognizer];
//        }
//#endif

//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        self.autoresizesSubviews = YES;

        directTouchId = 1;
        indirectTouchId = 2;

#if !TARGET_OS_TV
        self.multipleTouchEnabled = YES;
//        SDL_AddTouch(directTouchId, SDL_TOUCH_DEVICE_DIRECT, "");
#endif

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
        if (@available(iOS 13.4, *)) {
            [self addInteraction:[[UIPointerInteraction alloc] initWithDelegate:self]];
        }
#endif
    }
    
    
    UIButton* exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 30, 30)];
    [exitBtn addTarget:self action:@selector(handleExit) forControlEvents:UIControlEventTouchDown];
    [self addSubview:exitBtn];
    self.exitButton = exitBtn;

    return self;
}

- (void) handleExit {
    if ([self.nextResponder isKindOfClass:[SDL_pbuicontroller class]]) {
        [(SDL_pbuicontroller*)self.nextResponder dismissViewControllerAnimated:YES completion:nil];
    }
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
    [data.uiqueue addObject:^{
        view.frame = sframe;
        [view layoutSubviews];
    }];
    
    UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
    CGFloat statusBarHeight = statusBarManager.statusBarFrame.size.height;
    self.exitButton.frame = CGRectMake(self.frame.size.width - 45, statusBarHeight + 5, 30, 30);
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

-(void)swipeGesture:(UISwipeGestureRecognizer *)gesture
{
    SDL_Window* wd = self.swindow;
    if (wd == NULL) return;
    SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
    
    /* Swipe gestures don't trigger begin states. */
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (!SDL_AppleTVRemoteOpenedAsJoystick) {
            /* Send arrow key presses for now, as we don't have an external API
             * which better maps to swipe gestures. */
            switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionUp:
                [wddata.uiqueue addObject:^{
                    SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_UP);
                }];
                break;
            case UISwipeGestureRecognizerDirectionDown:
                [wddata.uiqueue addObject:^{
                    SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_DOWN);
                }];
                break;
            case UISwipeGestureRecognizerDirectionLeft:
                [wddata.uiqueue addObject:^{
                    SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_LEFT);
                }];
                break;
            case UISwipeGestureRecognizerDirectionRight:
                [wddata.uiqueue addObject:^{
                    SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_RIGHT);
                }];
                break;
            }
        }
    }
}

@end

#endif /* SDL_VIDEO_DRIVER_UIKIT */
