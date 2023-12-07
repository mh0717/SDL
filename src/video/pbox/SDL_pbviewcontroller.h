//
//  SDL_pbviewcontroller.h
//  SDL
//
//  Created by Huima on 2021/8/28.
//

#ifndef SDL_pbviewcontroller_h
#define SDL_pbviewcontroller_h


#include "../../SDL_internal.h"

#import <UIKit/UIKit.h>

#include "../SDL_sysvideo.h"

#include "SDL_touch.h"

#if TARGET_OS_TV
#import <GameController/GameController.h>
#define SDLRootViewController GCEventViewController
#else
#define SDLRootViewController UIViewController
#endif

#include "SDL_pbview.h"

#if SDL_IPHONE_KEYBOARD
@interface SDL_pbviewcontroller : NSObject <UITextFieldDelegate>
#else
@interface SDL_pbviewcontroller : NSObject
#endif



@property(nonatomic, strong) SDL_pbview* view;

@property (nonatomic, assign) SDL_Window *window;

@property (nonatomic, readonly) UIViewController* controller;


- (instancetype)initWithSDLWindow:(SDL_Window *)_window;

- (void)setAnimationCallback:(int)interval
                    callback:(void (*)(void*))callback
               callbackParam:(void*)callbackParam;

- (void)startAnimation;
- (void)stopAnimation;

- (void)doLoop:(CADisplayLink*)sender;

- (void)loadView;
- (void)viewDidLayoutSubviews;
- (void) setNeedsUpdateOfPrefersPointerLocked;


#if !TARGET_OS_TV
- (NSUInteger)supportedInterfaceOrientations;
- (BOOL)prefersStatusBarHidden;
- (BOOL)prefersHomeIndicatorAutoHidden;
- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures;

@property (nonatomic, assign) int homeIndicatorHidden;
#endif

#if SDL_IPHONE_KEYBOARD
- (void)showKeyboard;
- (void)hideKeyboard;
- (void)initKeyboard;
- (void)deinitKeyboard;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

- (void)updateKeyboard;

@property (nonatomic, assign, getter=isKeyboardVisible) BOOL keyboardVisible;
@property (nonatomic, assign) SDL_Rect textInputRect;
@property (nonatomic, assign) int keyboardHeight;
#endif

@end

#if SDL_IPHONE_KEYBOARD
SDL_bool PB_HasScreenKeyboardSupport(_THIS);
void PB_ShowScreenKeyboard(_THIS, SDL_Window *window);
void PB_HideScreenKeyboard(_THIS, SDL_Window *window);
SDL_bool PB_IsScreenKeyboardShown(_THIS, SDL_Window *window);
void PB_SetTextInputRect(_THIS, const SDL_Rect *rect);
#endif


@interface SDL_pbuicontroller : UIViewController<UIViewControllerTransitioningDelegate>

@property(nonatomic, assign) SDL_Window* swindow;

@property(nonatomic, assign) UIView* contentView;

@end

#endif /* SDL_pbviewcontroller_h */
