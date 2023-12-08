//
//  SDL_pbevents.c
//  SDL
//
//  Created by Huima on 2021/8/27.
//

//#include "../../SDL_internal.h"
//
//#if SDL_VIDEO_DRIVER_PBOX
//
///* Being a null driver, there's no event stream. We just define stubs for
//   most of the API. */
//
//#include "../../events/SDL_events_c.h"
//
//#include "SDL_pbvideo.h"
//#include "SDL_pbevents.h"
//
//void
//PB_PumpEvents(_THIS)
//{
//    /* do nothing. */
//}
//
//#endif /* SDL_VIDEO_DRIVER_DUMMY */



#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_PBOX

#include "../../events/SDL_events_c.h"
#import <UIKit/UIKit.h>

#include "SDL_pbvideo.h"
#include "SDL_pbevents.h"
#include "SDL_pbopengles.h"
#include "SDL_pbwindow.h"
//#include "SDL_pbvideo.h"

#import <Foundation/Foundation.h>

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 140000) || (__APPLETV_OS_VERSION_MAX_ALLOWED >= 140000) || (__MAC_OS_VERSION_MAX_ALLOWED > 1500000)
#import <GameController/GameController.h>

#define ENABLE_GCKEYBOARD
#define ENABLE_GCMOUSE
#endif

extern BOOL UIKit_EventPumpEnabled;

//void
//SDL_iPhoneSetEventPump(SDL_bool enabled)
//{
//    UIKit_EventPumpEnabled = enabled;
//}

void
PB_PumpEvents(_THIS)
{
//    if (!UIKit_EventPumpEnabled) {
//        return;
//    }
    
    SDL_Window *window;
    for (window = _this->windows; window; window = window->next) {
        SDL_PBWindowData* wdata = (__bridge SDL_PBWindowData*)window->driverdata;
        NSArray* queue = [NSArray arrayWithArray:wdata.uiqueue];
        [wdata.uiqueue removeAllObjects];
        
        for (PBTask task in queue) {
            task();
        }
    }
    
    
    
    if (NSThread.isMainThread) {
        /* Let the run loop run for a short amount of time: long enough for
         touch events to get processed (which is important to get certain
         elements of Game Center's GKLeaderboardViewController to respond
         to touch input), but not long enough to introduce a significant
         delay in the rest of the app.
         */
        const CFTimeInterval seconds = 0.000002;
        
        /* Pump most event types. */
        SInt32 result;
        do {
            result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, seconds, TRUE);
        } while (result == kCFRunLoopRunHandledSource);
        
        /* Make sure UIScrollView objects scroll properly. */
        do {
            result = CFRunLoopRunInMode((CFStringRef)UITrackingRunLoopMode, seconds, TRUE);
        } while(result == kCFRunLoopRunHandledSource);
    }

    /* See the comment in the function definition. */
#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2
    PB_GL_RestoreCurrentContext();
#endif
}

#ifdef ENABLE_GCKEYBOARD

static SDL_bool keyboard_connected = SDL_FALSE;
static id keyboard_connect_observer = nil;
static id keyboard_disconnect_observer = nil;

static void OnGCKeyboardConnected(GCKeyboard *keyboard) API_AVAILABLE(macos(11.0), ios(14.0), tvos(14.0))
{
    keyboard_connected = SDL_TRUE;
    keyboard.keyboardInput.keyChangedHandler = ^(GCKeyboardInput *keyboard, GCControllerButtonInput *key, GCKeyCode keyCode, BOOL pressed)
    {
        SDL_SendKeyboardKey(pressed ? SDL_PRESSED : SDL_RELEASED, (SDL_Scancode)keyCode);
        
    };

    dispatch_queue_t queue = dispatch_queue_create( "org.libsdl.input.keyboard", DISPATCH_QUEUE_SERIAL );
    dispatch_set_target_queue( queue, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0 ) );
    keyboard.handlerQueue = queue;
}

static void OnGCKeyboardDisconnected(GCKeyboard *keyboard) API_AVAILABLE(macos(11.0), ios(14.0), tvos(14.0))
{
    keyboard.keyboardInput.keyChangedHandler = nil;
    keyboard_connected = SDL_FALSE;
}

void SDL_PBInitGCKeyboard(void)
{
    @autoreleasepool {
        if (@available(iOS 14.0, tvOS 14.0, *)) {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

            keyboard_connect_observer = [center addObserverForName:GCKeyboardDidConnectNotification
                                                            object:nil
                                                             queue:nil
                                                        usingBlock:^(NSNotification *note) {
                                                            GCKeyboard *keyboard = note.object;
                                                            OnGCKeyboardConnected(keyboard);
                                                        }];

            keyboard_disconnect_observer = [center addObserverForName:GCKeyboardDidDisconnectNotification
                                                               object:nil
                                                                queue:nil
                                                           usingBlock:^(NSNotification *note) {
                                                                GCKeyboard *keyboard = note.object;
                                                                OnGCKeyboardDisconnected(keyboard);
                                                           }];

            if (GCKeyboard.coalescedKeyboard != nil) {
                OnGCKeyboardConnected(GCKeyboard.coalescedKeyboard);
            }
        }
    }
}

SDL_bool SDL_PBHasGCKeyboard(void)
{
    return keyboard_connected;
}

void SDL_PBQuitGCKeyboard(void)
{
    @autoreleasepool {
        if (@available(iOS 14.0, tvOS 14.0, *)) {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

            if (keyboard_connect_observer) {
                [center removeObserver:keyboard_connect_observer name:GCKeyboardDidConnectNotification object:nil];
                keyboard_connect_observer = nil;
            }

            if (keyboard_disconnect_observer) {
                [center removeObserver:keyboard_disconnect_observer name:GCKeyboardDidDisconnectNotification object:nil];
                keyboard_disconnect_observer = nil;
            }

            if (GCKeyboard.coalescedKeyboard != nil) {
                OnGCKeyboardDisconnected(GCKeyboard.coalescedKeyboard);
            }
        }
    }
}

#else

void SDL_PBInitGCKeyboard(void)
{
}

SDL_bool SDL_PBHasGCKeyboard(void)
{
    return SDL_FALSE;
}

void SDL_PBQuitGCKeyboard(void)
{
}

#endif /* ENABLE_GCKEYBOARD */


#ifdef ENABLE_GCMOUSE

static int mice_connected = 0;
static id mouse_connect_observer = nil;
static id mouse_disconnect_observer = nil;
static bool mouse_relative_mode = SDL_FALSE;

static void UpdateMouseGrab()
{
    SDL_VideoDevice *_this = SDL_GetVideoDevice();
    SDL_Window *window;

    for (window = _this->windows; window != NULL; window = window->next) {
        SDL_UpdateWindowGrab(window);
    }
}

static int SetGCMouseRelativeMode(SDL_bool enabled)
{
    mouse_relative_mode = enabled;
    UpdateMouseGrab();
    return 0;
}

static void OnGCMouseButtonChanged(SDL_MouseID mouseID, Uint8 button, BOOL pressed)
{
    SDL_SendMouseButton(SDL_GetMouseFocus(), mouseID, pressed ? SDL_PRESSED : SDL_RELEASED, button);
}

static void OnGCMouseConnected(GCMouse *mouse) API_AVAILABLE(macos(11.0), ios(14.0), tvos(14.0))
{
    SDL_MouseID mouseID = mice_connected;

//    mouse.mouseInput.leftButton.pressedChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
//    {
//        OnGCMouseButtonChanged(mouseID, SDL_BUTTON_LEFT, pressed);
//    };
//    mouse.mouseInput.middleButton.pressedChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
//    {
//        OnGCMouseButtonChanged(mouseID, SDL_BUTTON_MIDDLE, pressed);
//    };
//    mouse.mouseInput.rightButton.pressedChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
//    {
//        OnGCMouseButtonChanged(mouseID, SDL_BUTTON_RIGHT, pressed);
//    };
//
//    int auxiliary_button = SDL_BUTTON_X1;
//    for (GCControllerButtonInput *button in mouse.mouseInput.auxiliaryButtons) {
//        button.pressedChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
//        {
//            OnGCMouseButtonChanged(mouseID, auxiliary_button, pressed);
//        };
//        ++auxiliary_button;
//    }
//
//    mouse.mouseInput.mouseMovedHandler = ^(GCMouseInput *mouse, float deltaX, float deltaY)
//    {
//        SDL_SendMouseMotion(SDL_GetMouseFocus(), mouseID, SDL_TRUE, (int)deltaX, -(int)deltaY);
//    };
    
    mouse.mouseInput.scroll.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
    {
        SDL_SendMouseWheel(SDL_GetMouseFocus(), 0, xValue, yValue, SDL_MOUSEWHEEL_NORMAL);
    };

    dispatch_queue_t queue = dispatch_queue_create( "org.libsdl.input.mouse", DISPATCH_QUEUE_SERIAL );
    dispatch_set_target_queue( queue, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0 ) );
    mouse.handlerQueue = queue;

    ++mice_connected;

    UpdateMouseGrab();
}

static void OnGCMouseDisconnected(GCMouse *mouse) API_AVAILABLE(macos(11.0), ios(14.0), tvos(14.0))
{
    --mice_connected;

    mouse.mouseInput.mouseMovedHandler = nil;

    mouse.mouseInput.leftButton.pressedChangedHandler = nil;
    mouse.mouseInput.middleButton.pressedChangedHandler = nil;
    mouse.mouseInput.rightButton.pressedChangedHandler = nil;

    for (GCControllerButtonInput *button in mouse.mouseInput.auxiliaryButtons) {
        button.pressedChangedHandler = nil;
    }

    UpdateMouseGrab();
}

void SDL_PBInitGCMouse(void)
{
    @autoreleasepool {
        /* There is a bug where mouse accumulates duplicate deltas over time in iOS 14.0 */
        if (@available(iOS 14.1, tvOS 14.1, *)) {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

            mouse_connect_observer = [center addObserverForName:GCMouseDidConnectNotification
                                                         object:nil
                                                          queue:nil
                                                     usingBlock:^(NSNotification *note) {
                                                         GCMouse *mouse = note.object;
                                                         OnGCMouseConnected(mouse);
                                                     }];

            mouse_disconnect_observer = [center addObserverForName:GCMouseDidDisconnectNotification
                                                            object:nil
                                                             queue:nil
                                                        usingBlock:^(NSNotification *note) {
                                                            GCMouse *mouse = note.object;
                                                            OnGCMouseDisconnected(mouse);
                                                       }];

            for (GCMouse *mouse in [GCMouse mice]) {
                OnGCMouseConnected(mouse);
            }

            SDL_GetMouse()->SetRelativeMouseMode = SetGCMouseRelativeMode;
        }
    }
}

SDL_bool SDL_PBHasGCMouse(void)
{
//    return (mice_connected > 0);
    return 0;
}

SDL_bool SDL_PBGCMouseRelativeMode(void)
{
    return mouse_relative_mode;
}

void SDL_PBQuitGCMouse(void)
{
    @autoreleasepool {
        if (@available(iOS 14.1, tvOS 14.1, *)) {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

            if (mouse_connect_observer) {
                [center removeObserver:mouse_connect_observer name:GCMouseDidConnectNotification object:nil];
                mouse_connect_observer = nil;
            }

            if (mouse_disconnect_observer) {
                [center removeObserver:mouse_disconnect_observer name:GCMouseDidDisconnectNotification object:nil];
                mouse_disconnect_observer = nil;
            }

            for (GCMouse *mouse in [GCMouse mice]) {
                OnGCMouseDisconnected(mouse);
            }

            SDL_GetMouse()->SetRelativeMouseMode = NULL;
        }
    }
}

#else

void SDL_PBInitGCMouse(void)
{
}

SDL_bool SDL_PBHasGCMouse(void)
{
    return SDL_FALSE;
}

SDL_bool SDL_PBGCMouseRelativeMode(void)
{
    return SDL_FALSE;
}

void SDL_PBQuitGCMouse(void)
{
}

#endif /* ENABLE_GCMOUSE */

#endif /* SDL_VIDEO_DRIVER_UIKIT */
