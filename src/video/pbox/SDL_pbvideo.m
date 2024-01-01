////
////  SDL_pboxvideo.c
////  SDLmain-iOS
////
////  Created by Huima on 2021/8/13.
////
//
//#include "../../SDL_internal.h"
//
//#ifdef SDL_VIDEO_DRIVER_PBOX
//#import <Foundation/Foundation.h>
//#include "SDL_video.h"
//#include "SDL_mouse.h"
//#include "SDL_hints.h"
//#include "../SDL_sysvideo.h"
//#include "../SDL_pixels_c.h"
//#include "../../events/SDL_events_c.h"
//
//#import <sys/utsname.h>
//
//#include "SDL_pbvideo.h"
//#include "SDL_pbwindow.h"
//#include "SDL_pbevents.h"
//#include "SDL_pbframebuffer.h"
//
//#define PBOXVID_DRIVER_NAME "pbox"
//
//
//@implementation SDL_VideoData
//
//@end
//
//
///* Initialization/Query functions */
//static int PB_VideoInit(_THIS);
//static void PB_VideoQuit(_THIS);
//
//
//static int PB_GetDisplayDPI(_THIS, SDL_VideoDisplay * display, float * ddpi, float * hdpi, float * vdpi);
//static int PB_GetDisplayUsableBounds(_THIS, SDL_VideoDisplay * display, SDL_Rect * rect);
//
//static void PB_DeleteDevice(SDL_VideoDevice * device)
//{
//    @autoreleasepool {
//        if (device->driverdata) CFRelease(device->driverdata);
//        SDL_free(device);
//    }
//}
//
//static SDL_VideoDevice *
//PB_CreateDevice(int devindex)
//{
//    @autoreleasepool {
//        SDL_VideoDevice *device;
////        SDL_VideoData *data;
//
//        /* Initialize all variables that we clean on shutdown */
//        device = (SDL_VideoDevice *) SDL_calloc(1, sizeof(SDL_VideoDevice));
//        if (device) {
////            data = [SDL_VideoData new];
//        } else {
//            SDL_free(device);
//            SDL_OutOfMemory();
//            return (0);
//        }
//
//        device->driverdata = nil;//(void *) CFBridgingRetain(data);
//
//        /* Set the function pointers */
//        device->VideoInit = PB_VideoInit;
//        device->VideoQuit = PB_VideoQuit;
////        device->GetDisplayModes = UIKit_GetDisplayModes;
////        device->SetDisplayMode = UIKit_SetDisplayMode;
//        device->PumpEvents = PB_PumpEvents;
////        device->SuspendScreenSaver = UIKit_SuspendScreenSaver;
//        device->CreateSDLWindow = PB_CreateWindow;
//        device->SetWindowTitle = PB_SetWindowTitle;
//        device->ShowWindow = PB_ShowWindow;
//        device->HideWindow = PB_HideWindow;
//        device->RaiseWindow = PB_RaiseWindow;
//        device->SetWindowBordered = PB_SetWindowBordered;
//        device->SetWindowFullscreen = PB_SetWindowFullscreen;
//        device->SetWindowMouseGrab = PB_SetWindowMouseGrab;
//        device->DestroyWindow = PB_DestroyWindow;
//        device->GetWindowWMInfo = PB_GetWindowWMInfo;
//        device->GetDisplayUsableBounds = PB_GetDisplayUsableBounds;
//        device->GetDisplayDPI = PB_GetDisplayDPI;
//
//        device->CreateWindowFramebuffer = SDL_PB_CreateWindowFramebuffer;
//        device->UpdateWindowFramebuffer = SDL_PB_UpdateWindowFramebuffer;
//        device->DestroyWindowFramebuffer = SDL_PB_DestroyWindowFramebuffer;
//
////#if SDL_IPHONE_KEYBOARD
////        device->HasScreenKeyboardSupport = UIKit_HasScreenKeyboardSupport;
////        device->ShowScreenKeyboard = UIKit_ShowScreenKeyboard;
////        device->HideScreenKeyboard = UIKit_HideScreenKeyboard;
////        device->IsScreenKeyboardShown = UIKit_IsScreenKeyboardShown;
////        device->SetTextInputRect = UIKit_SetTextInputRect;
////#endif
////
////        device->SetClipboardText = UIKit_SetClipboardText;
////        device->GetClipboardText = UIKit_GetClipboardText;
////        device->HasClipboardText = UIKit_HasClipboardText;
////
////        /* OpenGL (ES) functions */
////#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2
////        device->GL_MakeCurrent      = UIKit_GL_MakeCurrent;
////        device->GL_GetDrawableSize  = UIKit_GL_GetDrawableSize;
////        device->GL_SwapWindow       = UIKit_GL_SwapWindow;
////        device->GL_CreateContext    = UIKit_GL_CreateContext;
////        device->GL_DeleteContext    = UIKit_GL_DeleteContext;
////        device->GL_GetProcAddress   = UIKit_GL_GetProcAddress;
////        device->GL_LoadLibrary      = UIKit_GL_LoadLibrary;
////#endif
//        device->free = PB_DeleteDevice;
//
////#if SDL_VIDEO_VULKAN
////        device->Vulkan_LoadLibrary = UIKit_Vulkan_LoadLibrary;
////        device->Vulkan_UnloadLibrary = UIKit_Vulkan_UnloadLibrary;
////        device->Vulkan_GetInstanceExtensions
////                                     = UIKit_Vulkan_GetInstanceExtensions;
////        device->Vulkan_CreateSurface = UIKit_Vulkan_CreateSurface;
////        device->Vulkan_GetDrawableSize = UIKit_Vulkan_GetDrawableSize;
////#endif
////
////#if SDL_VIDEO_METAL
////        device->Metal_CreateView = UIKit_Metal_CreateView;
////        device->Metal_DestroyView = UIKit_Metal_DestroyView;
////        device->Metal_GetLayer = UIKit_Metal_GetLayer;
////        device->Metal_GetDrawableSize = UIKit_Metal_GetDrawableSize;
////#endif
//
//        device->gl_config.accelerated = 1;
//
//        return device;
//    }
//}
//
//VideoBootStrap PB_bootstrap = {
//    PBOXVID_DRIVER_NAME, "SDL PB video driver",
//    PB_CreateDevice
//};
//
//
//int
//PB_VideoInit(_THIS)
//{
//    _this->gl_config.driver_loaded = 1;
//
//
////    SDL_InitGCKeyboard();
////    SDL_InitGCMouse();
//
//    return 0;
//}
//
//void
//PB_VideoQuit(_THIS)
//{
////    SDL_QuitGCKeyboard();
////    SDL_QuitGCMouse();
//
////    UIKit_QuitModes(_this);
//}
//
//void
//PB_SuspendScreenSaver(_THIS)
//{
//    @autoreleasepool {
//        /* Ignore ScreenSaver API calls if the idle timer hint has been set. */
//        /* FIXME: The idle timer hint should be deprecated for SDL 2.1. */
//        if (!SDL_GetHintBoolean(SDL_HINT_IDLE_TIMER_DISABLED, SDL_FALSE)) {
//            UIApplication *app = [UIApplication sharedApplication];
//
//            /* Prevent the display from dimming and going to sleep. */
//            app.idleTimerDisabled = (_this->suspend_screensaver != SDL_FALSE);
//        }
//    }
//}
//
//SDL_bool
//PB_IsSystemVersionAtLeast(double version)
//{
//    return [[UIDevice currentDevice].systemVersion doubleValue] >= version;
//}
//
//CGRect
//PB_ComputeViewFrame(SDL_Window *window, UIScreen *screen)
//{
//    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
//    CGRect frame = screen.bounds;
//
//    /* Use the UIWindow bounds instead of the UIScreen bounds, when possible.
//     * The uiwindow bounds may be smaller than the screen bounds when Split View
//     * is used on an iPad. */
////    if (data != nil && data.uiwindow != nil) {
////        frame = data.uiwindow.bounds;
////    }
//
//
//    /* iOS 10 seems to have a bug where, in certain conditions, putting the
//     * device to sleep with the a landscape-only app open, re-orienting the
//     * device to portrait, and turning it back on will result in the screen
//     * bounds returning portrait orientation despite the app being in landscape.
//     * This is a workaround until a better solution can be found.
//     * https://bugzilla.libsdl.org/show_bug.cgi?id=3505
//     * https://bugzilla.libsdl.org/show_bug.cgi?id=3465
//     * https://forums.developer.apple.com/thread/65337 */
//    if (PB_IsSystemVersionAtLeast(8.0)) {
//        UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
//        BOOL landscape = UIInterfaceOrientationIsLandscape(orient);
//        BOOL fullscreen = CGRectEqualToRect(screen.bounds, frame);
//
//        /* The orientation flip doesn't make sense when the window is smaller
//         * than the screen (iPad Split View, for example). */
//        if (fullscreen && (landscape != (frame.size.width > frame.size.height))) {
//            float height = frame.size.width;
//            frame.size.width = frame.size.height;
//            frame.size.height = height;
//        }
//    }
//
//    return frame;
//}
//
//void
//PB_ForceUpdateHomeIndicator()
//{
////#if !TARGET_OS_TV
////    /* Force the main SDL window to re-evaluate home indicator state */
////    SDL_Window *focus = SDL_GetFocusWindow();
////    if (focus) {
////        SDL_WindowData *data = (__bridge SDL_WindowData *) focus->driverdata;
////        if (data != nil) {
////#pragma clang diagnostic push
////#pragma clang diagnostic ignored "-Wunguarded-availability-new"
////            if ([data.viewcontroller respondsToSelector:@selector(setNeedsUpdateOfHomeIndicatorAutoHidden)]) {
////                [data.viewcontroller performSelectorOnMainThread:@selector(setNeedsUpdateOfHomeIndicatorAutoHidden) withObject:nil waitUntilDone:NO];
////                [data.viewcontroller performSelectorOnMainThread:@selector(setNeedsUpdateOfScreenEdgesDeferringSystemGestures) withObject:nil waitUntilDone:NO];
////            }
////#pragma clang diagnostic pop
////        }
////    }
////#endif /* !TARGET_OS_TV */
//}
//
///*
// * iOS log support.
// *
// * This doesn't really have aything to do with the interfaces of the SDL video
// *  subsystem, but we need to stuff this into an Objective-C source code file.
// *
// * NOTE: This is copypasted from src/video/cocoa/SDL_cocoavideo.m! Thus, if
// *  Cocoa is supported, we use that one instead. Be sure both versions remain
// *  identical!
// */
//
//#if !defined(SDL_VIDEO_DRIVER_COCOA)
//void SDL_NSLog(const char *text)
//{
//    @autoreleasepool {
//        NSString *str = [NSString stringWithUTF8String:text];
//        NSLog(@"%@", str);
//    }
//}
//#endif /* SDL_VIDEO_DRIVER_COCOA */
//
///*
// * iOS Tablet detection
// *
// * This doesn't really have aything to do with the interfaces of the SDL video
// * subsystem, but we need to stuff this into an Objective-C source code file.
// */
//SDL_bool SDL_IsIPad(void)
//{
//    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
//}
//
//
//static int
//PB_GetDisplayUsableBounds(_THIS, SDL_VideoDisplay * display, SDL_Rect * rect)
//{
//    CGRect frame = [UIScreen mainScreen].bounds;
//
//
//
//    rect->x += frame.origin.x;
//    rect->y += frame.origin.y;
//    rect->w = frame.size.width;
//    rect->h = frame.size.height;
//
//    return 0;
//}
//
//
//static float _getDpi() {
//    NSDictionary* devices = @{
//        @"iPhone1,1": @163,
//        @"iPhone1,2": @163,
//        @"iPhone2,1": @163,
//        @"iPhone3,1": @326,
//        @"iPhone3,2": @326,
//        @"iPhone3,3": @326,
//        @"iPhone4,1": @326,
//        @"iPhone5,1": @326,
//        @"iPhone5,2": @326,
//        @"iPhone5,3": @326,
//        @"iPhone5,4": @326,
//        @"iPhone6,1": @326,
//        @"iPhone6,2": @326,
//        @"iPhone7,1": @401,
//        @"iPhone7,2": @326,
//        @"iPhone8,1": @326,
//        @"iPhone8,2": @401,
//        @"iPhone8,4": @326,
//        @"iPhone9,1": @326,
//        @"iPhone9,2": @401,
//        @"iPhone9,3": @326,
//        @"iPhone9,4": @401,
//        @"iPhone10,1": @326,
//        @"iPhone10,2": @401,
//        @"iPhone10,3": @458,
//        @"iPhone10,4": @326,
//        @"iPhone10,5": @401,
//        @"iPhone10,6": @458,
//        @"iPhone11,2": @458,
//        @"iPhone11,4": @458,
//        @"iPhone11,6": @458,
//        @"iPhone11,8": @326,
//        @"iPhone12,1": @326,
//        @"iPhone12,3": @458,
//        @"iPhone12,5": @458,
//        @"iPad1,1": @132,
//        @"iPad2,1": @132,
//        @"iPad2,2": @132,
//        @"iPad2,3": @132,
//        @"iPad2,4": @132,
//        @"iPad2,5": @163,
//        @"iPad2,6": @163,
//        @"iPad2,7": @163,
//        @"iPad3,1": @264,
//        @"iPad3,2": @264,
//        @"iPad3,3": @264,
//        @"iPad3,4": @264,
//        @"iPad3,5": @264,
//        @"iPad3,6": @264,
//        @"iPad4,1": @264,
//        @"iPad4,2": @264,
//        @"iPad4,3": @264,
//        @"iPad4,4": @326,
//        @"iPad4,5": @326,
//        @"iPad4,6": @326,
//        @"iPad4,7": @326,
//        @"iPad4,8": @326,
//        @"iPad4,9": @326,
//        @"iPad5,1": @326,
//        @"iPad5,2": @326,
//        @"iPad5,3": @264,
//        @"iPad5,4": @264,
//        @"iPad6,3": @264,
//        @"iPad6,4": @264,
//        @"iPad6,7": @264,
//        @"iPad6,8": @264,
//        @"iPad6,11": @264,
//        @"iPad6,12": @264,
//        @"iPad7,1": @264,
//        @"iPad7,2": @264,
//        @"iPad7,3": @264,
//        @"iPad7,4": @264,
//        @"iPad7,5": @264,
//        @"iPad7,6": @264,
//        @"iPad7,11": @264,
//        @"iPad7,12": @264,
//        @"iPad8,1": @264,
//        @"iPad8,2": @264,
//        @"iPad8,3": @264,
//        @"iPad8,4": @264,
//        @"iPad8,5": @264,
//        @"iPad8,6": @264,
//        @"iPad8,7": @264,
//        @"iPad8,8": @264,
//        @"iPad11,1": @326,
//        @"iPad11,2": @326,
//        @"iPad11,3": @326,
//        @"iPad11,4": @326,
//        @"iPod1,1": @163,
//        @"iPod2,1": @163,
//        @"iPod3,1": @163,
//        @"iPod4,1": @326,
//        @"iPod5,1": @326,
//        @"iPod7,1": @326,
//        @"iPod9,1": @326,
//    };
//
//    UIScreen* screen = UIScreen.mainScreen;
//    float screenDPI = 1;
//
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    NSString* deviceName =
//        [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    id foundDPI = devices[deviceName];
//    if (foundDPI) {
//        screenDPI = (float)[foundDPI integerValue];
//    } else {
//        /*
//         * Estimate the DPI based on the screen scale multiplied by the base DPI for the device
//         * type (e.g. based on iPhone 1 and iPad 1)
//         */
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
//        float scale = (float)screen.nativeScale;
//#else
//        float scale = (float)screen.scale;
//#endif
//        float defaultDPI;
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            defaultDPI = 132.0f;
//        } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//            defaultDPI = 163.0f;
//        } else {
//            defaultDPI = 160.0f;
//        }
//        screenDPI = scale * defaultDPI;
//    }
//    return screenDPI;
//}
//
//static int
//PB_GetDisplayDPI(_THIS, SDL_VideoDisplay * display, float * ddpi, float * hdpi, float * vdpi)
//{
//    @autoreleasepool {
//        float dpi = _getDpi();
//
//        if (ddpi) {
//            *ddpi = dpi * (float)SDL_sqrt(2.0);
//        }
//        if (hdpi) {
//            *hdpi = dpi;
//        }
//        if (vdpi) {
//            *vdpi = dpi;
//        }
//    }
//
//    return 0;
//}
//
//
//#endif




#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_PBOX

#import <UIKit/UIKit.h>

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
#include "SDL_pbframebuffer.h"
#include "SDL_pbopengles.h"
#include "SDL_pbclipboard.h"
#include "SDL_pbviewcontroller.h"
//#include "SDL_uikitvulkan.h"
//#include "SDL_uikitmetalview.h"

#define PBVID_DRIVER_NAME "pbox"

@implementation SDL_PBVideoData

@end

/* Initialization/Query functions */
static int PB_VideoInit(_THIS);
static void PB_VideoQuit(_THIS);

/* DUMMY driver bootstrap functions */

static void PB_DeleteDevice(SDL_VideoDevice * device)
{
    @autoreleasepool {
        CFRelease(device->driverdata);
        SDL_free(device);
    }
}

static SDL_VideoDevice *
PB_CreateDevice(int devindex)
{
    @autoreleasepool {
        SDL_VideoDevice *device;
        SDL_PBVideoData *data;

        /* Initialize all variables that we clean on shutdown */
        device = (SDL_VideoDevice *) SDL_calloc(1, sizeof(SDL_VideoDevice));
        if (device) {
            data = [SDL_PBVideoData new];
        } else {
            SDL_free(device);
            SDL_OutOfMemory();
            return (0);
        }

        device->driverdata = (void *) CFBridgingRetain(data);
        

        /* Set the function pointers */
        device->VideoInit = PB_VideoInit;
        device->VideoQuit = PB_VideoQuit;
        device->GetDisplayModes = PB_GetDisplayModes;
        device->SetDisplayMode = PB_SetDisplayMode;
        device->PumpEvents = PB_PumpEvents;
        device->SuspendScreenSaver = PB_SuspendScreenSaver;
        device->CreateSDLWindow = PB_CreateWindow;
        device->SetWindowTitle = PB_SetWindowTitle;
        device->ShowWindow = PB_ShowWindow;
        device->HideWindow = PB_HideWindow;
        device->RaiseWindow = PB_RaiseWindow;
        device->SetWindowBordered = PB_SetWindowBordered;
        device->SetWindowFullscreen = PB_SetWindowFullscreen;
//        device->SetWindowMouseGrab = UIKit_SetWindowMouseGrab;
        device->DestroyWindow = PB_DestroyWindow;
        device->GetWindowWMInfo = PB_GetWindowWMInfo;
        device->GetDisplayUsableBounds = PB_GetDisplayUsableBounds;
        device->GetDisplayDPI = PB_GetDisplayDPI;
        device->SetWindowOpacity = PB_SetWindowOpacity;
        
        
        
//        device->CreateWindowFramebuffer = SDL_PB_CreateWindowFramebuffer;
//        device->UpdateWindowFramebuffer = SDL_PB_UpdateWindowFramebuffer;
//        device->DestroyWindowFramebuffer = SDL_PB_DestroyWindowFramebuffer;

//#if SDL_IPHONE_KEYBOARD
        device->HasScreenKeyboardSupport = PB_HasScreenKeyboardSupport;
        device->ShowScreenKeyboard = PB_ShowScreenKeyboard;
        device->HideScreenKeyboard = PB_HideScreenKeyboard;
        device->IsScreenKeyboardShown = PB_IsScreenKeyboardShown;
        device->SetTextInputRect = PB_SetTextInputRect;
//#endif

        device->SetClipboardText = PB_SetClipboardText;
        device->GetClipboardText = PB_GetClipboardText;
        device->HasClipboardText = PB_HasClipboardText;

        /* OpenGL (ES) functions */
#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2
        device->GL_MakeCurrent      = PB_GL_MakeCurrent;
        device->GL_GetDrawableSize  = PB_GL_GetDrawableSize;
        device->GL_SwapWindow       = PB_GL_SwapWindow;
        device->GL_CreateContext    = PB_GL_CreateContext;
        device->GL_DeleteContext    = PB_GL_DeleteContext;
        device->GL_GetProcAddress   = PB_GL_GetProcAddress;
        device->GL_LoadLibrary      = PB_GL_LoadLibrary;
#endif
        device->free = PB_DeleteDevice;

#if SDL_VIDEO_VULKAN
        device->Vulkan_LoadLibrary = SDL_Vulkan_LoadLibrary;
        device->Vulkan_UnloadLibrary = SDL_Vulkan_UnloadLibrary;
        device->Vulkan_GetInstanceExtensions
                                     = SDL_Vulkan_GetInstanceExtensions;
        device->Vulkan_CreateSurface = SDL_Vulkan_CreateSurface;
        device->Vulkan_GetDrawableSize = SDL_Vulkan_GetDrawableSize;
#endif

#if SDL_VIDEO_METAL
        device->Metal_CreateView = SDL_Metal_CreateView;
        device->Metal_DestroyView = SDL_Metal_DestroyView;
        device->Metal_GetLayer = SDL_Metal_GetLayer;
        device->Metal_GetDrawableSize = SDL_Metal_GetDrawableSize;
#endif

        device->gl_config.accelerated = 1;

        return device;
    }
}

VideoBootStrap PB_bootstrap = {
    PBVID_DRIVER_NAME, "SDL PB video driver",
    PB_CreateDevice
};


int
PB_VideoInit(_THIS)
{
    _this->gl_config.driver_loaded = 1;

    if (PB_InitModes(_this) < 0) {
        return -1;
    }

    SDL_PBInitGCKeyboard();
    SDL_PBInitGCMouse();

    return 0;
}

extern void SDL_PBQuitGCKeyboard(void);
extern void SDL_PBQuitGCMouse(void);

void
PB_VideoQuit(_THIS)
{
    SDL_PBQuitGCKeyboard();
    SDL_PBQuitGCMouse();

    PB_QuitModes(_this);
}

void
PB_SuspendScreenSaver(_THIS)
{
    @autoreleasepool {
        /* Ignore ScreenSaver API calls if the idle timer hint has been set. */
        /* FIXME: The idle timer hint should be deprecated for SDL 2.1. */
        
        if (!SDL_GetHintBoolean(SDL_HINT_IDLE_TIMER_DISABLED, SDL_FALSE)) {
            BOOL flag = _this->suspend_screensaver != SDL_FALSE;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             UIApplication *app = [UIApplication sharedApplication];
             app.idleTimerDisabled = flag;
            }];
            
        }
    }
}

SDL_bool
PB_IsSystemVersionAtLeast(double version)
{
    return [[UIDevice currentDevice].systemVersion doubleValue] >= version;
}

CGRect
PB_ComputeViewFrame(SDL_Window *window, UIScreen *screen)
{
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;
    __block CGRect frame = screen.bounds;

    /* Use the UIWindow bounds instead of the UIScreen bounds, when possible.
     * The uiwindow bounds may be smaller than the screen bounds when Split View
     * is used on an iPad. */
//    if (data != nil && data.uiwindow != nil && data.uvcontroller && data.uvcontroller.view.window) {
//        return data.uvcontroller.view.bounds;
//    }
    
    extern CGSize SDL_SCREEN_SIZE(void);
    CGSize size = SDL_SCREEN_SIZE();
    return CGRectMake(0, 0, size.width, size.height);
}

void
PB_ForceUpdateHomeIndicator(void)
{
#if !TARGET_OS_TV
    /* Force the main SDL window to re-evaluate home indicator state */
    SDL_Window *focus = SDL_GetFocusWindow();
    if (focus) {
        SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) focus->driverdata;
        if (data != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"
//            if ([data.viewcontroller respondsToSelector:@selector(setNeedsUpdateOfHomeIndicatorAutoHidden)]) {
//                [data.viewcontroller performSelectorOnMainThread:@selector(setNeedsUpdateOfHomeIndicatorAutoHidden) withObject:nil waitUntilDone:NO];
//                [data.viewcontroller performSelectorOnMainThread:@selector(setNeedsUpdateOfScreenEdgesDeferringSystemGestures) withObject:nil waitUntilDone:NO];
//            }
#pragma clang diagnostic pop
        }
    }
#endif /* !TARGET_OS_TV */
}

/*
 * iOS log support.
 *
 * This doesn't really have aything to do with the interfaces of the SDL video
 *  subsystem, but we need to stuff this into an Objective-C source code file.
 *
 * NOTE: This is copypasted from src/video/cocoa/SDL_cocoavideo.m! Thus, if
 *  Cocoa is supported, we use that one instead. Be sure both versions remain
 *  identical!
 */

#if !defined(SDL_VIDEO_DRIVER_COCOA)
void SDL_PBNSLog(const char *text)
{
    @autoreleasepool {
        NSString *str = [NSString stringWithUTF8String:text];
        NSLog(@"%@", str);
    }
}
#endif /* SDL_VIDEO_DRIVER_COCOA */

/*
 * iOS Tablet detection
 *
 * This doesn't really have aything to do with the interfaces of the SDL video
 * subsystem, but we need to stuff this into an Objective-C source code file.
 */
SDL_bool SDL_PBIsIPad(void)
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

#endif /* SDL_VIDEO_DRIVER_UIKIT */


BOOL isMainThread(void) {
    return [NSThread isMainThread];
}
