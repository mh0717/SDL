//
//  SDL_pbmodes.h
//  SDL
//
//  Created by Huima on 2021/8/27.
//

#include "../../SDL_internal.h"

#ifndef SDL_pbmodes_h
#define SDL_pbmodes_h




#include "SDL_pbvideo.h"

@interface SDL_PBDisplayData : NSObject

- (instancetype)initWithScreen:(UIScreen*)screen;

@property (nonatomic, strong) UIScreen *uiscreen;
@property (nonatomic) float screenDPI;

@end

@interface SDL_PBDisplayModeData : NSObject

@property (nonatomic, strong) UIScreenMode *uiscreenmode;

@end

extern SDL_bool PB_IsDisplayLandscape(UIScreen *uiscreen);

extern int PB_InitModes(_THIS);
extern int PB_AddDisplay(UIScreen *uiscreen, SDL_bool send_event);
extern void PB_DelDisplay(UIScreen *uiscreen);
extern void PB_GetDisplayModes(_THIS, SDL_VideoDisplay * display);
extern int PB_GetDisplayDPI(_THIS, SDL_VideoDisplay * display, float * ddpi, float * hdpi, float * vdpi);
extern int PB_SetDisplayMode(_THIS, SDL_VideoDisplay * display, SDL_DisplayMode * mode);
extern void PB_QuitModes(_THIS);
extern int PB_GetDisplayUsableBounds(_THIS, SDL_VideoDisplay * display, SDL_Rect * rect);

#endif /* SDL_pbmodes_h */
