//
//  SDL_pbmessagebox.h
//  SDL
//
//  Created by Huima on 2021/8/28.
//

#ifndef SDL_pbmessagebox_h
#define SDL_pbmessagebox_h

#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_PBOX

extern SDL_bool PB_ShowingMessageBox(void);

extern int PB_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonid);

#endif /* SDL_VIDEO_DRIVER_UIKIT */


#endif /* SDL_pbmessagebox_h */
