//
//  SDL_pbframebuffer.h
//  SDL
//
//  Created by Huima on 2021/8/27.
//

#ifndef SDL_pbframebuffer_h
#define SDL_pbframebuffer_h

#include "../../SDL_internal.h"

extern int SDL_PB_CreateWindowFramebuffer(_THIS, SDL_Window * window, Uint32 * format, void ** pixels, int *pitch);
extern int SDL_PB_UpdateWindowFramebuffer(_THIS, SDL_Window * window, const SDL_Rect * rects, int numrects);
extern void SDL_PB_DestroyWindowFramebuffer(_THIS, SDL_Window * window);

#endif /* SDL_pbframebuffer_h */
