//
//  SDL_pbopengles.h
//  SDL
//
//  Created by Huima on 2021/8/28.
//

#ifndef SDL_pbopengles_h
#define SDL_pbopengles_h

#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2

#include "../SDL_sysvideo.h"

extern int PB_GL_MakeCurrent(_THIS, SDL_Window * window,
                                SDL_GLContext context);
extern void PB_GL_GetDrawableSize(_THIS, SDL_Window * window,
                                     int * w, int * h);
extern int PB_GL_SwapWindow(_THIS, SDL_Window * window);
extern SDL_GLContext PB_GL_CreateContext(_THIS, SDL_Window * window);
extern void PB_GL_DeleteContext(_THIS, SDL_GLContext context);
extern void *PB_GL_GetProcAddress(_THIS, const char *proc);
extern int PB_GL_LoadLibrary(_THIS, const char *path);

extern void PB_GL_RestoreCurrentContext(void);

#endif // SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2


#endif /* SDL_pbopengles_h */
