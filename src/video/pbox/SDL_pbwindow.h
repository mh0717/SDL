//
//  SDL_pbwindow.h
//  SDL
//
//  Created by Huima on 2021/8/26.
//

#ifndef SDL_pbwindow_h
#define SDL_pbwindow_h

//#include "../SDL_sysvideo.h"
//#import "SDL_pbvideo.h"
//#import <Foundation/Foundation.h>
////#import "SDL_uikitview.h"
////#import "SDL_uikitviewcontroller.h"
//
//extern int PB__CreateWindow(_THIS, SDL_Window * window);
//extern void PB__SetWindowTitle(_THIS, SDL_Window * window);
//extern void PB__ShowWindow(_THIS, SDL_Window * window);
//extern void PB__HideWindow(_THIS, SDL_Window * window);
//extern void PB__RaiseWindow(_THIS, SDL_Window * window);
//extern void PB__SetWindowBordered(_THIS, SDL_Window * window, SDL_bool bordered);
//extern void PB__SetWindowFullscreen(_THIS, SDL_Window * window, SDL_VideoDisplay * display, SDL_bool fullscreen);
//extern void PB__SetWindowMouseGrab(_THIS, SDL_Window * window, SDL_bool grabbed);
//extern void PB__DestroyWindow(_THIS, SDL_Window * window);
//extern SDL_bool PB__GetWindowWMInfo(_THIS, SDL_Window * window,
//                                      struct SDL_SysWMinfo * info);
//
//extern NSUInteger PB__GetSupportedOrientations(SDL_Window * window);
//
////@class UIWindow;
//
//@interface SDL_PBWindowData : NSObject
//
////@property (nonatomic, strong) UIWindow *uiwindow;
////@property (nonatomic, strong) SDL_uikitviewcontroller *viewcontroller;
////
/////* Array of SDL_uikitviews owned by this window. */
////@property (nonatomic, copy) NSMutableArray *views;
//
//@end



#include "../SDL_sysvideo.h"
#import "SDL_pbvideo.h"
#import "SDL_pbview.h"
#import "SDL_pbviewcontroller.h"
#import "PBSafeArray.h"
#import <UIKit/UIKit.h>

extern int PB_CreateWindow(_THIS, SDL_Window * window);
extern void PB_SetWindowTitle(_THIS, SDL_Window * window);
extern void PB_ShowWindow(_THIS, SDL_Window * window);
extern void PB_HideWindow(_THIS, SDL_Window * window);
extern void PB_RaiseWindow(_THIS, SDL_Window * window);
extern void PB_SetWindowBordered(_THIS, SDL_Window * window, SDL_bool bordered);
extern void PB_SetWindowFullscreen(_THIS, SDL_Window * window, SDL_VideoDisplay * display, SDL_bool fullscreen);
extern void PB_SetWindowMouseGrab(_THIS, SDL_Window * window, SDL_bool grabbed);
extern void PB_DestroyWindow(_THIS, SDL_Window * window);
extern SDL_bool PB_GetWindowWMInfo(_THIS, SDL_Window * window,
                                      struct SDL_SysWMinfo * info);

extern NSUInteger PB_GetSupportedOrientations(SDL_Window * window);
extern int PB_SetWindowOpacity(_THIS, SDL_Window * window, float opacity);

//@class UIWindow;

@interface SDL_pbwindow : NSObject

- (instancetype) initWithFrame:(CGRect)frame;

@property(nonatomic,strong) UIScreen *screen;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, assign) BOOL hidden;
@property(nonatomic, strong) SDL_pbviewcontroller *rootViewController;
- (void)setScreen:(UIScreen *)screen;
- (void) makeKeyAndVisible;

- (void) layoutIfNeeded;


@end

typedef void (^PBTask)(void);

@interface SDL_PBWindowData : NSObject

@property (nonatomic, strong) SDL_pbwindow *uiwindow;
@property (nonatomic, strong) SDL_pbviewcontroller *viewcontroller;

@property (nonatomic, strong) SDL_pbuicontroller* uvcontroller;

/* Array of SDL_uikitviews owned by this window. */
@property (nonatomic, copy) NSMutableArray *views;

@property (nonatomic, strong) NSThread* thread;
@property (nonatomic, strong) PBSafeArray* uiqueue;

@end

#endif /* SDL_pbwindow_h */
