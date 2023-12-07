//
//  SDL_uikitclipboard.h
//  SDL
//
//  Created by Huima on 2021/9/20.
//

#ifndef SDL_pbclipboard_h
#define SDL_pbclipboard_h


#include "../SDL_sysvideo.h"

extern int PB_SetClipboardText(_THIS, const char *text);
extern char *PB_GetClipboardText(_THIS);
extern SDL_bool PB_HasClipboardText(_THIS);

extern void PB_InitClipboard(_THIS);
extern void PB_QuitClipboard(_THIS);



#endif /* SDL_uikitclipboard_h */
