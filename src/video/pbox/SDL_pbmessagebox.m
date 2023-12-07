//
//  SDL_pbmessagebox.m
//  SDL
//
//  Created by Huima on 2021/8/28.
//

#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_UIKIT

#include "SDL.h"
#include "SDL_pbvideo.h"
#include "SDL_pbwindow.h"

/* Display a UIKit message box */

static SDL_bool s_showingMessageBox = SDL_FALSE;

SDL_bool
PB_ShowingMessageBox(void)
{
    return s_showingMessageBox;
}

static void
PB_WaitUntilMessageBoxClosed(const SDL_MessageBoxData *messageboxdata, int *clickedindex)
{
    *clickedindex = messageboxdata->numbuttons;

    @autoreleasepool {
        /* Run the main event loop until the alert has finished */
        /* Note that this needs to be done on the main thread */
        s_showingMessageBox = SDL_TRUE;
        while ((*clickedindex) == messageboxdata->numbuttons) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        s_showingMessageBox = SDL_FALSE;
    }
}

static BOOL
PB_ShowMessageBoxAlertController(const SDL_MessageBoxData *messageboxdata, int *buttonid)
{
    
    int __block clickedindex = messageboxdata->numbuttons;
    
    
    void (^handler)(void) = ^{
        UIAlertController *alert;
        alert = [UIAlertController alertControllerWithTitle:@(messageboxdata->title)
                                                    message:@(messageboxdata->message)
                                             preferredStyle:UIAlertControllerStyleAlert];
        int i;
        for (i = 0; i < messageboxdata->numbuttons; i++) {
            UIAlertAction *action;
            UIAlertActionStyle style = UIAlertActionStyleDefault;
            const SDL_MessageBoxButtonData *sdlButton;

            if (messageboxdata->flags & SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT) {
                sdlButton = &messageboxdata->buttons[messageboxdata->numbuttons - 1 - i];
            } else {
                sdlButton = &messageboxdata->buttons[i];
            }

            if (sdlButton->flags & SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT) {
                style = UIAlertActionStyleCancel;
            }

            action = [UIAlertAction actionWithTitle:@(sdlButton->text)
                                    style:style
                                    handler:^(UIAlertAction *action) {
                                        clickedindex = (int)(sdlButton - messageboxdata->buttons);
                                    }];
            [alert addAction:action];

            if (sdlButton->flags & SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT) {
                alert.preferredAction = action;
            }
        }

        UIViewController* presentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (presentVC.presentedViewController) {
            presentVC = presentVC.presentedViewController;
        }
        [presentVC presentViewController:alert animated:YES completion:nil];
    };
    if (NSThread.isMainThread) {
        handler();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), handler);
    }
    
    PB_WaitUntilMessageBoxClosed(messageboxdata, &clickedindex);

//    UIKit_ForceUpdateHomeIndicator();

    *buttonid = messageboxdata->buttons[clickedindex].buttonid;
    return YES;
}

/* UIAlertView is deprecated in iOS 8+ in favor of UIAlertController. */
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
@interface SDLAlertViewDelegate : NSObject <UIAlertViewDelegate>

@property (nonatomic, assign) int *clickedIndex;

@end

@implementation SDLAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_clickedIndex != NULL) {
        *_clickedIndex = (int) buttonIndex;
    }
}

@end
#endif /* __IPHONE_OS_VERSION_MIN_REQUIRED < 80000 */

static BOOL
PB_ShowMessageBoxAlertView(const SDL_MessageBoxData *messageboxdata, int *buttonid)
{
    /* UIAlertView is deprecated in iOS 8+ in favor of UIAlertController. */
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    int i;
    int clickedindex = messageboxdata->numbuttons;
    UIAlertView *alert = [[UIAlertView alloc] init];
    SDLAlertViewDelegate *delegate = [[SDLAlertViewDelegate alloc] init];

    alert.delegate = delegate;
    alert.title = @(messageboxdata->title);
    alert.message = @(messageboxdata->message);

    for (i = 0; i < messageboxdata->numbuttons; i++) {
        const SDL_MessageBoxButtonData *sdlButton;
        if (messageboxdata->flags & SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT) {
            sdlButton = &messageboxdata->buttons[messageboxdata->numbuttons - 1 - i];
        } else {
            sdlButton = &messageboxdata->buttons[i];
        }
        [alert addButtonWithTitle:@(sdlButton->text)];
    }

    delegate.clickedIndex = &clickedindex;

    [alert show];

    UIKit_WaitUntilMessageBoxClosed(messageboxdata, &clickedindex);

    alert.delegate = nil;

    if (messageboxdata->flags & SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT) {
        clickedindex = messageboxdata->numbuttons - 1 - clickedindex;
    }
    *buttonid = messageboxdata->buttons[clickedindex].buttonid;
    return YES;
#else
    return NO;
#endif /* __IPHONE_OS_VERSION_MIN_REQUIRED < 80000 */
}

int
PB_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonid)
{
    BOOL success = NO;

    @autoreleasepool {
        success = PB_ShowMessageBoxAlertController(messageboxdata, buttonid);
        if (!success) {
            success = PB_ShowMessageBoxAlertView(messageboxdata, buttonid);
        }
    }

    if (!success) {
        return SDL_SetError("Could not show message box.");
    }

    return 0;
}

#endif /* SDL_VIDEO_DRIVER_UIKIT */

