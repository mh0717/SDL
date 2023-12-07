//
//  SDL_pbopenglview.h
//  SDL
//
//  Created by Huima on 2021/8/28.
//

#ifndef SDL_pbopenglview_h
#define SDL_pbopenglview_h


#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/gl.h>

#import "SDL_pbview.h"
#include "SDL_pbvideo.h"

@interface SDL_pbopenglview : SDL_pbview

- (instancetype)initWithFrame:(CGRect)frame
                        scale:(CGFloat)scale
                retainBacking:(BOOL)retained
                        rBits:(int)rBits
                        gBits:(int)gBits
                        bBits:(int)bBits
                        aBits:(int)aBits
                    depthBits:(int)depthBits
                  stencilBits:(int)stencilBits
                         sRGB:(BOOL)sRGB
                 multisamples:(int)multisamples
                      context:(EAGLContext *)glcontext;

@property (nonatomic, readonly, weak) EAGLContext *context;

/* The width and height of the drawable in pixels (as opposed to points.) */
@property (nonatomic, readonly) int backingWidth;
@property (nonatomic, readonly) int backingHeight;

@property (nonatomic, readonly) GLuint drawableRenderbuffer;
@property (nonatomic, readonly) GLuint drawableFramebuffer;
@property (nonatomic, readonly) GLuint msaaResolveFramebuffer;

- (void)swapBuffers;

- (void)updateFrame;


@end

#endif // SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2


#endif /* SDL_pbopenglview_h */




#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES3/gl.h>

#import "SDL_pbview.h"

@interface SDL_pbuikitopenglview : SDL_pbuiview

- (instancetype)initWithFrame:(CGRect)frame
                        scale:(CGFloat)scale
                retainBacking:(BOOL)retained
                        rBits:(int)rBits
                        gBits:(int)gBits
                        bBits:(int)bBits
                        aBits:(int)aBits
                    depthBits:(int)depthBits
                  stencilBits:(int)stencilBits
                         sRGB:(BOOL)sRGB
                 multisamples:(int)multisamples
                      context:(EAGLContext *)glcontext;

@property (nonatomic, readonly, weak) EAGLContext *context;

/* The width and height of the drawable in pixels (as opposed to points.) */
@property (nonatomic, readonly) int backingWidth;
@property (nonatomic, readonly) int backingHeight;

@property (nonatomic, readonly) GLuint drawableRenderbuffer;
@property (nonatomic, readonly) GLuint drawableFramebuffer;
@property (nonatomic, readonly) GLuint msaaResolveFramebuffer;

- (void)swapBuffers;

- (void)updateFrame;

@end

#endif
