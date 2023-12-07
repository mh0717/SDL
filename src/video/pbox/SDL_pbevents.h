//
//  SDL_pbevents.h
//  SDL
//
//  Created by Huima on 2021/8/27.
//

#ifndef SDL_pbevents_h
#define SDL_pbevents_h

#include "../../SDL_internal.h"

#include "SDL_pbvideo.h"

extern void PB_PumpEvents(_THIS);

extern void SDL_PBInitGCKeyboard(void);
extern SDL_bool SDL_PBHasGCKeyboard(void);
extern void SDLPB_QuitGCKeyboard(void);

extern void SDL_PBInitGCMouse(void);
extern SDL_bool SDL_PBHasGCMouse(void);
extern SDL_bool SDL_PBGCMouseRelativeMode(void);
extern void SDL_PBQuitGCMouse(void);

#endif /* SDL_pbevents_h */
