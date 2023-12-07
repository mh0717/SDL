//
//  SDL_pboxvideo.h
//  SDLmain-iOS
//
//  Created by Huima on 2021/8/13.
//

#include "../../SDL_internal.h"

#ifndef SDL_pboxvideo_h
#define SDL_pboxvideo_h

//#include "../SDL_sysvideo.h"
//
//#ifdef __OBJC__
//
//#include <UIKit/UIKit.h>
//
//@interface SDL_VideoData : NSObject
//
//@property (nonatomic, assign) id pasteboardObserver;
//
//@end
//
//CGRect PB_ComputeViewFrame(SDL_Window *window, UIScreen *screen);
//
//#endif /* __OBJC__ */
//
//void PB_SuspendScreenSaver(_THIS);
//
//void PB_ForceUpdateHomeIndicator(void);
//
//SDL_bool PB_IsSystemVersionAtLeast(double version);



#include "../SDL_sysvideo.h"

#ifdef __OBJC__

#include <UIKit/UIKit.h>

@interface SDL_PBVideoData : NSObject

@property (nonatomic, assign) id pasteboardObserver;

@end

CGRect PB_ComputeViewFrame(SDL_Window *window, UIScreen *screen);

#endif /* __OBJC__ */

void PB_SuspendScreenSaver(_THIS);

void PB_ForceUpdateHomeIndicator(void);

SDL_bool PB_IsSystemVersionAtLeast(double version);

#endif /* SDL_pboxvideo_h */



