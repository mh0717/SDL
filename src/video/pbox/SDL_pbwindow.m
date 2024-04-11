//
//  SDL_pbwindow.c
//  SDL
//
//  Created by Huima on 2021/8/26.
//


//#include "../../SDL_internal.h"
//
//#if SDL_VIDEO_DRIVER_PBOX
//
//#include "SDL_syswm.h"
//#include "SDL_video.h"
//#include "SDL_mouse.h"
//#include "SDL_hints.h"
//#include "../SDL_sysvideo.h"
//#include "../SDL_pixels_c.h"
//#include "../../events/SDL_events_c.h"
//
//#include "SDL_pbvideo.h"
////#include "SDL_uikitevents.h"
////#include "SDL_uikitmodes.h"
//#include "SDL_pbwindow.h"
////#import "SDL_uikitappdelegate.h"
//
////#import "SDL_uikitview.h"
////#import "SDL_uikitopenglview.h"
//
//#include <Foundation/Foundation.h>
//#include <UIKit/UIKit.h>
//
//@implementation SDL_PBWindowData
//
////@synthesize uiwindow;
////@synthesize viewcontroller;
////@synthesize views;
////
////- (instancetype)init
////{
////    if ((self = [super init])) {
////        views = [NSMutableArray new];
////    }
////
////    return self;
////}
//
//@end
//
//@interface SDL_pbwindow: NSObject
//
//
//@end
//
//@implementation SDL_pbwindow
//
//
//@end
//
//
//static int
//SetupWindowData(_THIS, SDL_Window *window, SDL_pbwindow *uiwindow, SDL_bool created)
//{
////    SDL_uikitview *view;
//
//    CGRect frame = [UIScreen mainScreen].bounds;
//    int width  = (int) frame.size.width;
//    int height = (int) frame.size.height;
//
//    SDL_PBWindowData *data = [[SDL_PBWindowData alloc] init];
//    if (!data) {
//        return SDL_OutOfMemory();
//    }
//
//    window->driverdata = (void *) CFBridgingRetain(data);
//
////    data.uiwindow = uiwindow;
//
//    /* only one window on iOS, always shown */
//    window->flags &= ~SDL_WINDOW_HIDDEN;
//
//
//    window->x = 0;
//    window->y = 0;
//    window->w = width;
//    window->h = height;
//
//    /* The View Controller will handle rotating the view when the device
//     * orientation changes. This will trigger resize events, if appropriate. */
////    data.viewcontroller = [[SDL_uikitviewcontroller alloc] initWithSDLWindow:window];
//
//    /* The window will initially contain a generic view so resizes, touch events,
//     * etc. can be handled without an active OpenGL view/context. */
////    view = [[SDL_uikitview alloc] initWithFrame:frame];
//
//    /* Sets this view as the controller's view, and adds the view to the window
//     * heirarchy. */
////    [view setSDLWindow:window];
//
//    return 0;
//}
//
//int
//PB_CreateWindow(_THIS, SDL_Window *window)
//{
//    @autoreleasepool {
//        SDL_VideoDisplay *display = SDL_GetDisplayForWindow(window);
//        SDL_Window *other;
//
//        /* We currently only handle a single window per display on iOS */
//        for (other = _this->windows; other; other = other->next) {
//            if (other != window && SDL_GetDisplayForWindow(other) == display) {
//                return SDL_SetError("Only one window allowed per display.");
//            }
//        }
//
//
//        /* ignore the size user requested, and make a fullscreen window */
//        /* !!! FIXME: can we have a smaller view? */
////        UIWindow *uiwindow = [[SDL_uikitwindow alloc] initWithFrame:data.uiscreen.bounds];
//        SDL_pbwindow *uiwindow = [[SDL_pbwindow alloc] init];
//
//        if (SetupWindowData(_this, window, uiwindow, SDL_TRUE) < 0) {
//            return -1;
//        }
//    }
//
//    return 1;
//}
//
//void
//PB_SetWindowTitle(_THIS, SDL_Window * window)
//{
//
//}
//
//void
//PB_ShowWindow(_THIS, SDL_Window * window)
//{
//    @autoreleasepool {
//        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
////        [data.uiwindow makeKeyAndVisible];
//
//    }
//}
//
//void
//PB_HideWindow(_THIS, SDL_Window * window)
//{
//    @autoreleasepool {
//        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
////        data.uiwindow.hidden = YES;
//    }
//}
//
//void
//PB_RaiseWindow(_THIS, SDL_Window * window)
//{
//    /* We don't currently offer a concept of "raising" the SDL window, since
//     * we only allow one per display, in the iOS fashion.
//     * However, we use this entry point to rebind the context to the view
//     * during OnWindowRestored processing. */
//    _this->GL_MakeCurrent(_this, _this->current_glwin, _this->current_glctx);
//}
//
//static void
//PB_UpdateWindowBorder(_THIS, SDL_Window * window)
//{
//    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
////    SDL_uikitviewcontroller *viewcontroller = data.viewcontroller;
////
////
////#ifdef SDL_IPHONE_KEYBOARD
////    /* Make sure the view is offset correctly when the keyboard is visible. */
////    [viewcontroller updateKeyboard];
////#endif
////
////    [viewcontroller.view setNeedsLayout];
////    [viewcontroller.view layoutIfNeeded];
//}
//
//void
//PB_SetWindowBordered(_THIS, SDL_Window * window, SDL_bool bordered)
//{
//    @autoreleasepool {
//        PB_UpdateWindowBorder(_this, window);
//    }
//}
//
//void
//PB_SetWindowFullscreen(_THIS, SDL_Window * window, SDL_VideoDisplay * display, SDL_bool fullscreen)
//{
//    @autoreleasepool {
//        PB_UpdateWindowBorder(_this, window);
//    }
//}
//
//void
//PB_SetWindowMouseGrab(_THIS, SDL_Window * window, SDL_bool grabbed)
//{
////#if !TARGET_OS_TV
////    @autoreleasepool {
////        SDL_WindowData *data = (__bridge SDL_WindowData *) window->driverdata;
////        SDL_uikitviewcontroller *viewcontroller = data.viewcontroller;
////        if (@available(iOS 14.0, *)) {
////            [viewcontroller setNeedsUpdateOfPrefersPointerLocked];
////        }
////    }
////#endif /* !TARGET_OS_TV */
//}
//
//void
//PB_DestroyWindow(_THIS, SDL_Window * window)
//{
//    @autoreleasepool {
//        if (window->driverdata != NULL) {
//            SDL_PBWindowData *data = (SDL_PBWindowData *) CFBridgingRelease(window->driverdata);
////            NSArray *views = nil;
////
////            [data.viewcontroller stopAnimation];
////
////            /* Detach all views from this window. We use a copy of the array
////             * because setSDLWindow will remove the object from the original
////             * array, which would be undesirable if we were iterating over it. */
////            views = [data.views copy];
////            for (SDL_uikitview *view in views) {
////                [view setSDLWindow:NULL];
////            }
////
////            /* iOS may still hold a reference to the window after we release it.
////             * We want to make sure the SDL view controller isn't accessed in
////             * that case, because it would contain an invalid pointer to the old
////             * SDL window. */
////            data.uiwindow.rootViewController = nil;
////            data.uiwindow.hidden = YES;
//        }
//    }
//    window->driverdata = NULL;
//}
//
//SDL_bool
//PB_GetWindowWMInfo(_THIS, SDL_Window * window, SDL_SysWMinfo * info)
//{
//    @autoreleasepool {
//        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
//
//        if (info->version.major <= SDL_MAJOR_VERSION) {
//            int versionnum = SDL_VERSIONNUM(info->version.major, info->version.minor, info->version.patch);
//
//            info->subsystem = SDL_SYSWM_UIKIT;
////            info->info.uikit.window = data.uiwindow;
////
////            /* These struct members were added in SDL 2.0.4. */
////            if (versionnum >= SDL_VERSIONNUM(2,0,4)) {
////#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2
////                if ([data.viewcontroller.view isKindOfClass:[SDL_uikitopenglview class]]) {
////                    SDL_uikitopenglview *glview = (SDL_uikitopenglview *)data.viewcontroller.view;
////                    info->info.uikit.framebuffer = glview.drawableFramebuffer;
////                    info->info.uikit.colorbuffer = glview.drawableRenderbuffer;
////                    info->info.uikit.resolveFramebuffer = glview.msaaResolveFramebuffer;
////                } else {
////#else
////                {
////#endif
////                    info->info.uikit.framebuffer = 0;
////                    info->info.uikit.colorbuffer = 0;
////                    info->info.uikit.resolveFramebuffer = 0;
////                }
////            }
//
//            return SDL_TRUE;
//        } else {
//            SDL_SetError("Application not compiled with SDL %d.%d",
//                         SDL_MAJOR_VERSION, SDL_MINOR_VERSION);
//            return SDL_FALSE;
//        }
//    }
//}
//
//#if !TARGET_OS_TV
//NSUInteger
//PB_GetSupportedOrientations(SDL_Window * window)
//{
//    const char *hint = SDL_GetHint(SDL_HINT_ORIENTATIONS);
//    NSUInteger validOrientations = UIInterfaceOrientationMaskAll;
//    NSUInteger orientationMask = 0;
//
////    @autoreleasepool {
////        SDL_WindowData *data = (__bridge SDL_WindowData *) window->driverdata;
////        UIApplication *app = [UIApplication sharedApplication];
////
////        /* Get all possible valid orientations. If the app delegate doesn't tell
////         * us, we get the orientations from Info.plist via UIApplication. */
////        if ([app.delegate respondsToSelector:@selector(application:supportedInterfaceOrientationsForWindow:)]) {
////            validOrientations = [app.delegate application:app supportedInterfaceOrientationsForWindow:data.uiwindow];
////        } else if ([app respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)]) {
////            validOrientations = [app supportedInterfaceOrientationsForWindow:data.uiwindow];
////        }
////
////        if (hint != NULL) {
////            NSArray *orientations = [@(hint) componentsSeparatedByString:@" "];
////
////            if ([orientations containsObject:@"LandscapeLeft"]) {
////                orientationMask |= UIInterfaceOrientationMaskLandscapeLeft;
////            }
////            if ([orientations containsObject:@"LandscapeRight"]) {
////                orientationMask |= UIInterfaceOrientationMaskLandscapeRight;
////            }
////            if ([orientations containsObject:@"Portrait"]) {
////                orientationMask |= UIInterfaceOrientationMaskPortrait;
////            }
////            if ([orientations containsObject:@"PortraitUpsideDown"]) {
////                orientationMask |= UIInterfaceOrientationMaskPortraitUpsideDown;
////            }
////        }
////
////        if (orientationMask == 0 && (window->flags & SDL_WINDOW_RESIZABLE)) {
////            /* any orientation is okay. */
////            orientationMask = UIInterfaceOrientationMaskAll;
////        }
////
////        if (orientationMask == 0) {
////            if (window->w >= window->h) {
////                orientationMask |= UIInterfaceOrientationMaskLandscape;
////            }
////            if (window->h >= window->w) {
////                orientationMask |= (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
////            }
////        }
////
////        /* Don't allow upside-down orientation on phones, so answering calls is in the natural orientation */
////        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
////            orientationMask &= ~UIInterfaceOrientationMaskPortraitUpsideDown;
////        }
////
////        /* If none of the specified orientations are actually supported by the
////         * app, we'll revert to what the app supports. An exception would be
////         * thrown by the system otherwise. */
////        if ((validOrientations & orientationMask) == 0) {
////            orientationMask = validOrientations;
////        }
////    }
//
//    return orientationMask;
//}
//#endif /* !TARGET_OS_TV */
//
//int
//SDL_iPhoneSetAnimationCallback(SDL_Window * window, int interval, void (*callback)(void*), void *callbackParam)
//{
//    if (!window || !window->driverdata) {
//        return SDL_SetError("Invalid window");
//    }
//
////    @autoreleasepool {
////        SDL_WindowData *data = (__bridge SDL_WindowData *)window->driverdata;
////        [data.viewcontroller setAnimationCallback:interval
////                                         callback:callback
////                                    callbackParam:callbackParam];
////    }
//
//    return 0;
//}
//
//#endif /* SDL_VIDEO_DRIVER_UIKIT */





#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_PBOX

#include "SDL_syswm.h"
#include "SDL_video.h"
#include "SDL_mouse.h"
#include "SDL_hints.h"
#include "../SDL_sysvideo.h"
#include "../SDL_pixels_c.h"
#include "../../events/SDL_events_c.h"

#include "SDL_pbvideo.h"
#include "SDL_pbevents.h"
#include "SDL_pbmodes.h"
#include "SDL_pbwindow.h"
//#import "SDL_uikitappdelegate.h"

#import "SDL_pbview.h"
//#import "SDL_uikitopenglview.h"

#include <Foundation/Foundation.h>

@implementation SDL_PBWindowData

@synthesize uiwindow;
@synthesize viewcontroller;
@synthesize views;
@synthesize uiqueue;
@synthesize thread;

- (instancetype)init
{
    if ((self = [super init])) {
        views = [NSMutableArray new];
        thread = [NSThread currentThread];
        uiqueue = [[PBSafeArray alloc] init];
    }

    return self;
}

@end



@implementation SDL_pbwindow

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.screen = [UIScreen mainScreen];
    }
    return self;
}

- (void) setRootViewController:(SDL_pbviewcontroller *)rootViewController {
    if (_rootViewController == rootViewController) return;
    _rootViewController = rootViewController;
    if (_rootViewController) {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) _rootViewController.window->driverdata;
        if (NSThread.isMainThread) {
            data.uvcontroller.contentView = _rootViewController.view.view;
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                data.uvcontroller.contentView = _rootViewController.view.view;
            });
        }
    }
}

//- (void)setScreen:(UIScreen *)screen {
//    self.screen = screen;
//}

- (void) makeKeyAndVisible {
    self.hidden = NO;
//    NSMutableDictionary *outDic = [NSMutableDictionary dictionary];
//   NSString *strPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
//
//   NSData *fileData= [NSData dataWithContentsOfFile:strPath];
//   
//   NSString *rawDataString = [[NSString alloc] initWithData:fileData encoding:NSASCIIStringEncoding];
//   NSRange plistStartRange = [rawDataString rangeOfString:@"<plist"];
//   NSRange plistEndRange = [rawDataString rangeOfString:@"</plist>"];
//   
//   if (plistStartRange.location != NSNotFound && plistEndRange.location != NSNotFound) {
//       
//       NSString *tempPlistString = [rawDataString substringWithRange:NSMakeRange(plistStartRange.location, NSMaxRange(plistEndRange))];
//       NSData *tempPlistData = [tempPlistString dataUsingEncoding:NSUTF8StringEncoding];
//       NSDictionary *plistDic = [NSPropertyListSerialization propertyListWithData:tempPlistData options:NSPropertyListImmutable format:nil error:nil];
//       
//       NSArray *applicationIdentifierPrefix = [plistDic objectForKey:@"ApplicationIdentifierPrefix"];
//       NSDictionary *entitlementsDic = [plistDic objectForKey:@"Entitlements"];
//       NSString *mobileBundleID = [entitlementsDic objectForKey:@"application-identifier"];
//       
//       NSString *tempMobilID = [applicationIdentifierPrefix firstObject];
//       
//       [outDic setValue:tempMobilID forKey:@"Eid"];
//       [outDic setValue:mobileBundleID forKey:@"Bid"];
//       NSLog(@"%@", tempMobilID);
//       NSLog(@"%@", mobileBundleID);
//       char bid[] = {'b','a','o','b','a','o','w','a','n','g','.','P','y','t','h','o','n','3','I','D','E', '\0'};
//       NSString* bstr = [NSString stringWithUTF8String:bid];
//       if (![mobileBundleID hasSuffix:bstr]) return;
//   }
    
    
    
    if (self.rootViewController == nil || self.rootViewController.window == NULL) return;
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) _rootViewController.window->driverdata;
    
    
    SDL_pbviewcontroller* pbvc = _rootViewController;
    __block SDL_pbuicontroller* vc = nil;
    void(^handler)(void) = ^{
        data.uvcontroller.modalPresentationStyle = UIModalPresentationOverFullScreen;
        UIViewController* presentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (presentVC.presentedViewController) {
            presentVC = presentVC.presentedViewController;
        }
        [presentVC presentViewController:data.uvcontroller animated:YES completion:nil];
    };
//    if (NSThread.isMainThread) {
//        handler();
//    }
//    else {
//        dispatch_sync(dispatch_get_main_queue(), handler);
//    }
}

- (void) layoutIfNeeded {
    
}

- (void) setHidden:(BOOL)hidden {
    _hidden = hidden;
    
    if (_rootViewController == nil || _rootViewController.window == NULL) {
        return;
    }
    
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) _rootViewController.window->driverdata;
    if (data.uvcontroller == nil) {
        return;
    }
    
    NSString* notiName = !_hidden ? @"UI_SHOW_VC_IN_TAB" : @"UI_HIDE_VC_IN_TAB";
    NSNotification* noti = [[NSNotification alloc] initWithName:notiName object:nil userInfo:@{@"vc": data.uvcontroller}];
//    [self performSelector:@selector(sendNoti:) withObject:noti afterDelay:0];
    [self sendNoti:noti];
}

- (void) sendNoti:(NSNotification*)noti {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotification:noti];
    });
    
}


@end


static int
SetupWindowData(_THIS, SDL_Window *window, SDL_pbwindow *uiwindow, SDL_bool created)
{
    SDL_VideoDisplay *display = SDL_GetDisplayForWindow(window);
    SDL_PBDisplayData *displaydata = (__bridge SDL_PBDisplayData *) display->driverdata;
    SDL_pbview *view;

    CGRect frame = PB_ComputeViewFrame(window, displaydata.uiscreen);
    int width  = (int) frame.size.width;
    int height = (int) frame.size.height;

    SDL_PBWindowData *data = [[SDL_PBWindowData alloc] init];
    if (!data) {
        return SDL_OutOfMemory();
    }

    window->driverdata = (void *) CFBridgingRetain(data);

    data.uiwindow = uiwindow;

    /* only one window on iOS, always shown */
    window->flags &= ~SDL_WINDOW_HIDDEN;

    if (displaydata.uiscreen != [UIScreen mainScreen]) {
        window->flags &= ~SDL_WINDOW_RESIZABLE;  /* window is NEVER resizable */
        window->flags &= ~SDL_WINDOW_INPUT_FOCUS;  /* never has input focus */
        window->flags |= SDL_WINDOW_BORDERLESS;  /* never has a status bar. */
    }

#if !TARGET_OS_TV
    if (displaydata.uiscreen == [UIScreen mainScreen]) {
        /* SDL_CreateWindow sets the window w&h to the display's bounds if the
         * fullscreen flag is set. But the display bounds orientation might not
         * match what we want, and GetSupportedOrientations call below uses the
         * window w&h. They're overridden below anyway, so we'll just set them
         * to the requested size for the purposes of determining orientation. */
        window->w = window->windowed.w;
        window->h = window->windowed.h;

        NSUInteger orients = PB_GetSupportedOrientations(window);
        BOOL supportsLandscape = (orients & UIInterfaceOrientationMaskLandscape) != 0;
        BOOL supportsPortrait = (orients & (UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown)) != 0;

        /* Make sure the width/height are oriented correctly */
#warning PBOX
//        if ((width > height && !supportsLandscape) || (height > width && !supportsPortrait)) {
//            int temp = width;
//            width = height;
//            height = temp;
//        }
    }
#endif /* !TARGET_OS_TV */

    window->x = 0;
    window->y = 0;
    window->w = width;
    window->h = height;

    /* The View Controller will handle rotating the view when the device
     * orientation changes. This will trigger resize events, if appropriate. */

    data.viewcontroller = [[SDL_pbviewcontroller alloc] initWithSDLWindow:window];
    if (NSThread.isMainThread) {
        data.uvcontroller = [[SDL_pbuicontroller alloc] initWithNibName:nil bundle:nil];
        data.uvcontroller.swindow = window;
        data.uvcontroller.preferredContentSize = CGSizeMake(width, height);
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            data.uvcontroller = [[SDL_pbuicontroller alloc] initWithNibName:nil bundle:nil];
            data.uvcontroller.swindow = window;
            data.uvcontroller.preferredContentSize = CGSizeMake(width, height);
        });
    }
    

    /* The window will initially contain a generic view so resizes, touch events,
     * etc. can be handled without an active OpenGL view/context. */
    view = [[SDL_pbview alloc] initWithFrame:frame];

    /* Sets this view as the controller's view, and adds the view to the window
     * heirarchy. */
    [view setSDLWindow:window];

    return 0;
}

int
PB_CreateWindow(_THIS, SDL_Window *window)
{
    @autoreleasepool {
        SDL_VideoDisplay *display = SDL_GetDisplayForWindow(window);
        SDL_PBDisplayData *data = (__bridge SDL_PBDisplayData *) display->driverdata;
        SDL_Window *other;

        /* We currently only handle a single window per display on iOS */
//        for (other = _this->windows; other; other = other->next) {
//            if (other != window && SDL_GetDisplayForWindow(other) == display) {
//                return SDL_SetError("Only one window allowed per display.");
//            }
//        }

        /* If monitor has a resolution of 0x0 (hasn't been explicitly set by the
         * user, so it's in standby), try to force the display to a resolution
         * that most closely matches the desired window size. */
#if !TARGET_OS_TV
        const CGSize origsize = data.uiscreen.currentMode.size;
        if ((origsize.width == 0.0f) && (origsize.height == 0.0f)) {
            if (display->num_display_modes == 0) {
                _this->GetDisplayModes(_this, display);
            }

            int i;
            const SDL_DisplayMode *bestmode = NULL;
            for (i = display->num_display_modes; i >= 0; i--) {
                const SDL_DisplayMode *mode = &display->display_modes[i];
                if ((mode->w >= window->w) && (mode->h >= window->h)) {
                    bestmode = mode;
                }
            }

            if (bestmode) {
                SDL_PBDisplayModeData *modedata = (__bridge SDL_PBDisplayModeData *)bestmode->driverdata;
                [data.uiscreen setCurrentMode:modedata.uiscreenmode];

                /* desktop_mode doesn't change here (the higher level will
                 * use it to set all the screens back to their defaults
                 * upon window destruction, SDL_Quit(), etc. */
                display->current_mode = *bestmode;
            }
        }

        if (data.uiscreen == [UIScreen mainScreen]) {
#warning PYBOX
//            if (window->flags & (SDL_WINDOW_FULLSCREEN|SDL_WINDOW_BORDERLESS)) {
//                [UIApplication sharedApplication].statusBarHidden = YES;
//            } else {
//                [UIApplication sharedApplication].statusBarHidden = NO;
//            }
        }
#endif /* !TARGET_OS_TV */

        /* ignore the size user requested, and make a fullscreen window */
        /* !!! FIXME: can we have a smaller view? */
        SDL_pbwindow *uiwindow = [[SDL_pbwindow alloc] initWithFrame:data.uiscreen.bounds];

        /* put the window on an external display if appropriate. */
        if (data.uiscreen != [UIScreen mainScreen]) {
            [uiwindow setScreen:data.uiscreen];
        }

        if (SetupWindowData(_this, window, uiwindow, SDL_TRUE) < 0) {
            return -1;
        }
    }

    return 1;
}

void
PB_SetWindowTitle(_THIS, SDL_Window * window)
{
    @autoreleasepool {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
        data.uiwindow.title = @(window->title);
        if (NSThread.isMainThread) {
            data.uvcontroller.title = @(window->title);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                data.uvcontroller.title = @(window->title);
            });
        }
    }
}

void
PB_ShowWindow(_THIS, SDL_Window * window)
{
    @autoreleasepool {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
        [data.uiwindow makeKeyAndVisible];

        /* Make this window the current mouse focus for touch input */
        SDL_VideoDisplay *display = SDL_GetDisplayForWindow(window);
        SDL_PBDisplayData *displaydata = (__bridge SDL_PBDisplayData *) display->driverdata;
        if (displaydata.uiscreen == [UIScreen mainScreen]) {
            SDL_SetMouseFocus(window);
            SDL_SetKeyboardFocus(window);
        }
    }
}

void
PB_HideWindow(_THIS, SDL_Window * window)
{
    @autoreleasepool {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
        data.uiwindow.hidden = YES;
    }
}

void
PB_RaiseWindow(_THIS, SDL_Window * window)
{
    /* We don't currently offer a concept of "raising" the SDL window, since
     * we only allow one per display, in the iOS fashion.
     * However, we use this entry point to rebind the context to the view
     * during OnWindowRestored processing. */
    _this->GL_MakeCurrent(_this, _this->current_glwin, _this->current_glctx);
}

static void
PB_UpdateWindowBorder(_THIS, SDL_Window * window)
{
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
    SDL_pbviewcontroller *viewcontroller = data.viewcontroller;

#if !TARGET_OS_TV
    
    void (^handler)(void) = ^{
    if (data.uiwindow.screen == [UIScreen mainScreen]) {
        
//        if (window->flags & (SDL_WINDOW_FULLSCREEN | SDL_WINDOW_BORDERLESS)) {
//            [UIApplication sharedApplication].statusBarHidden = YES;
//        } else {
//            [UIApplication sharedApplication].statusBarHidden = NO;
//        }
//
//        /* iOS 7+ won't update the status bar until we tell it to. */
//        if ([viewcontroller respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
////            [viewcontroller setNeedsStatusBarAppearanceUpdate];
//        }
    }

    /* Update the view's frame to account for the status bar change. */
    viewcontroller.view.frame = PB_ComputeViewFrame(window, data.uiwindow.screen);
    };
    if (NSThread.isMainThread) {
        handler();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), handler);
    }
#endif /* !TARGET_OS_TV */

#ifdef SDL_IPHONE_KEYBOARD
    /* Make sure the view is offset correctly when the keyboard is visible. */
    [viewcontroller updateKeyboard];
#endif

    [viewcontroller.view setNeedsLayout];
    [viewcontroller.view layoutIfNeeded];
}

void
PB_SetWindowBordered(_THIS, SDL_Window * window, SDL_bool bordered)
{
    @autoreleasepool {
        PB_UpdateWindowBorder(_this, window);
    }
}

void
PB_SetWindowFullscreen(_THIS, SDL_Window * window, SDL_VideoDisplay * display, SDL_bool fullscreen)
{
    @autoreleasepool {
        PB_UpdateWindowBorder(_this, window);
    }
}

void
PB_SetWindowMouseGrab(_THIS, SDL_Window * window, SDL_bool grabbed)
{
#if !TARGET_OS_TV
    @autoreleasepool {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
        SDL_pbviewcontroller *viewcontroller = data.viewcontroller;
        if (@available(iOS 14.0, *)) {
            [viewcontroller setNeedsUpdateOfPrefersPointerLocked];
        }
    }
#endif /* !TARGET_OS_TV */
}

void
PB_DestroyWindow(_THIS, SDL_Window * window)
{
    @autoreleasepool {
        if (window->driverdata != NULL) {
            SDL_PBWindowData *data = (SDL_PBWindowData *) CFBridgingRelease(window->driverdata);
            NSArray *views = nil;

            [data.viewcontroller stopAnimation];

            /* Detach all views from this window. We use a copy of the array
             * because setSDLWindow will remove the object from the original
             * array, which would be undesirable if we were iterating over it. */
            views = [data.views copy];
            for (SDL_pbview *view in views) {
                [view setSDLWindow:NULL];
            }

            /* iOS may still hold a reference to the window after we release it.
             * We want to make sure the SDL view controller isn't accessed in
             * that case, because it would contain an invalid pointer to the old
             * SDL window. */
//            data.uiwindow.rootViewController = nil;
            data.uiwindow.hidden = YES;
            data.uiwindow.rootViewController = nil;
        }
    }
    window->driverdata = NULL;
}

SDL_bool
PB_GetWindowWMInfo(_THIS, SDL_Window * window, SDL_SysWMinfo * info)
{
    @autoreleasepool {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;

        if (info->version.major <= SDL_MAJOR_VERSION) {
            int versionnum = SDL_VERSIONNUM(info->version.major, info->version.minor, info->version.patch);

            info->subsystem = SDL_SYSWM_UIKIT;
//            info->info.uikit.window = data.uiwindow;
#warning PBOX
            /* These struct members were added in SDL 2.0.4. */
            if (versionnum >= SDL_VERSIONNUM(2,0,4)) {
//#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2
//                if ([data.viewcontroller.view isKindOfClass:[SDL_uikitopenglview class]]) {
//                    SDL_uikitopenglview *glview = (SDL_uikitopenglview *)data.viewcontroller.view;
//                    info->info.uikit.framebuffer = glview.drawableFramebuffer;
//                    info->info.uikit.colorbuffer = glview.drawableRenderbuffer;
//                    info->info.uikit.resolveFramebuffer = glview.msaaResolveFramebuffer;
//                } else {
//#else
//                {
//#endif
                    info->info.uikit.framebuffer = 0;
                    info->info.uikit.colorbuffer = 0;
                    info->info.uikit.resolveFramebuffer = 0;
//                }
            }

            return SDL_TRUE;
        } else {
            SDL_SetError("Application not compiled with SDL %d.%d",
                         SDL_MAJOR_VERSION, SDL_MINOR_VERSION);
            return SDL_FALSE;
        }
    }
}

#if !TARGET_OS_TV
NSUInteger
PB_GetSupportedOrientations(SDL_Window * window)
{
    const char *hint = SDL_GetHint(SDL_HINT_ORIENTATIONS);
    NSUInteger validOrientations = UIInterfaceOrientationMaskAll;
    NSUInteger orientationMask = 0;
    
#warning PBOX
    return 0;

//    @autoreleasepool {
//        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
//        UIApplication *app = [UIApplication sharedApplication];
//
//        /* Get all possible valid orientations. If the app delegate doesn't tell
//         * us, we get the orientations from Info.plist via UIApplication. */
//        if ([app.delegate respondsToSelector:@selector(application:supportedInterfaceOrientationsForWindow:)]) {
//            validOrientations = [app.delegate application:app supportedInterfaceOrientationsForWindow:data.uiwindow];
//        } else if ([app respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)]) {
//            validOrientations = [app supportedInterfaceOrientationsForWindow:data.uiwindow];
//        }
//
//        if (hint != NULL) {
//            NSArray *orientations = [@(hint) componentsSeparatedByString:@" "];
//
//            if ([orientations containsObject:@"LandscapeLeft"]) {
//                orientationMask |= UIInterfaceOrientationMaskLandscapeLeft;
//            }
//            if ([orientations containsObject:@"LandscapeRight"]) {
//                orientationMask |= UIInterfaceOrientationMaskLandscapeRight;
//            }
//            if ([orientations containsObject:@"Portrait"]) {
//                orientationMask |= UIInterfaceOrientationMaskPortrait;
//            }
//            if ([orientations containsObject:@"PortraitUpsideDown"]) {
//                orientationMask |= UIInterfaceOrientationMaskPortraitUpsideDown;
//            }
//        }
//
//        if (orientationMask == 0 && (window->flags & SDL_WINDOW_RESIZABLE)) {
//            /* any orientation is okay. */
//            orientationMask = UIInterfaceOrientationMaskAll;
//        }
//
//        if (orientationMask == 0) {
//            if (window->w >= window->h) {
//                orientationMask |= UIInterfaceOrientationMaskLandscape;
//            }
//            if (window->h >= window->w) {
//                orientationMask |= (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
//            }
//        }
//
//        /* Don't allow upside-down orientation on phones, so answering calls is in the natural orientation */
//        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
//            orientationMask &= ~UIInterfaceOrientationMaskPortraitUpsideDown;
//        }
//
//        /* If none of the specified orientations are actually supported by the
//         * app, we'll revert to what the app supports. An exception would be
//         * thrown by the system otherwise. */
//        if ((validOrientations & orientationMask) == 0) {
//            orientationMask = validOrientations;
//        }
//    }

    return orientationMask;
}
#endif /* !TARGET_OS_TV */

int
PB_iPhoneSetAnimationCallback(SDL_Window * window, int interval, void (*callback)(void*), void *callbackParam)
{
    if (!window || !window->driverdata) {
        return SDL_SetError("Invalid window");
    }

    @autoreleasepool {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *)window->driverdata;
        [data.viewcontroller setAnimationCallback:interval
                                         callback:callback
                                    callbackParam:callbackParam];
    }

    return 0;
}

int
PB_SetWindowOpacity(_THIS, SDL_Window * window, float opacity)
{
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
    if (data.uvcontroller) {
        if (NSThread.isMainThread) {
            data.uvcontroller.view.alpha = opacity;
        }
        else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                data.uvcontroller.view.alpha = opacity;
            });
        }
    }
    
    return 0;
}

void PB_SetWindowSize(_THIS, SDL_Window * window)
{
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
    if (data.uvcontroller) {
        if (NSThread.isMainThread) {
            data.uvcontroller.preferredContentSize = CGSizeMake(window->w, window->h);
        }
        else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                data.uvcontroller.preferredContentSize = CGSizeMake(window->w, window->h);
            });
        }
    }
}

#endif /* SDL_VIDEO_DRIVER_UIKIT */
