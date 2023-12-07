//
//  SDL_pbframebuffer.c
//  SDL
//
//  Created by Huima on 2021/8/27.
//

#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_PBOX
#import <UIKit/UIKit.h>

#include "../SDL_sysvideo.h"
#include "SDL_pbframebuffer.h"
#include "SDL_pbwindow.h"
#include "SDL_pbview.h"


#define DUMMY_SURFACE   "_SDL_DummySurface"

int SDL_PB_CreateWindowFramebuffer(_THIS, SDL_Window * window, Uint32 * format, void ** pixels, int *pitch)
{
    SDL_Surface *surface;
    const Uint32 surface_format = SDL_PIXELFORMAT_RGB888;
    int w, h;
    int bpp;
    Uint32 Rmask, Gmask, Bmask, Amask;

    /* Free the old framebuffer surface */
    surface = (SDL_Surface *) SDL_GetWindowData(window, DUMMY_SURFACE);
    SDL_FreeSurface(surface);

    /* Create a new one */
    SDL_PixelFormatEnumToMasks(surface_format, &bpp, &Rmask, &Gmask, &Bmask, &Amask);
    SDL_GetWindowSize(window, &w, &h);
    surface = SDL_CreateRGBSurface(0, w, h, bpp, Rmask, Gmask, Bmask, Amask);
    if (!surface) {
        return -1;
    }

    /* Save the info and return! */
    SDL_SetWindowData(window, DUMMY_SURFACE, surface);
    *format = surface_format;
    *pixels = surface->pixels;
    *pitch = surface->pitch;
    return 0;
}

int SDL_PB_UpdateWindowFramebuffer(_THIS, SDL_Window * window, const SDL_Rect * rects, int numrects)
{
    static int frame_number;
    SDL_Surface *surface;

    surface = (SDL_Surface *) SDL_GetWindowData(window, DUMMY_SURFACE);
    if (!surface) {
        return SDL_SetError("Couldn't find dummy surface for window");
    }

//    /* Send the data to the display */
//    if (SDL_getenv("SDL_VIDEO_DUMMY_SAVE_FRAMES")) {
//        char file[128];
//        SDL_snprintf(file, sizeof(file), "SDL_window%" SDL_PRIu32 "-%8.8d.bmp",
//                     SDL_GetWindowID(window), ++frame_number);
//        SDL_SaveBMP(surface, file);
//    }
    NSInteger WIDTH_IN_PIXEL = surface->w;
    NSInteger HEIGHT_IN_PIXEL = surface->h;
    NSInteger x = 0, y = 0;
    NSInteger dataLength = WIDTH_IN_PIXEL * HEIGHT_IN_PIXEL * 4;
    GLubyte *data = (GLubyte*)malloc(dataLength * sizeof(GLubyte));
    
    Uint32 src_format;
    void *src_pixels;
    src_format = surface->format->format;
//    src_pixels = (void*)((Uint8 *) surface->pixels +
//                    rect->y * surface->pitch +
//                    rect->x * surface->format->BytesPerPixel);
    src_pixels = (Uint8 *) surface->pixels;

    SDL_ConvertPixels(WIDTH_IN_PIXEL, HEIGHT_IN_PIXEL,
                             src_format, src_pixels, surface->pitch,
                      SDL_PIXELFORMAT_RGBA32, data, WIDTH_IN_PIXEL * 4);
    
//    memcpy(data, surface->pixels, dataLength);
//    memset(data, 0xFF, WIDTH_IN_PIXEL * 4 * 50);
//    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, surface->pixels, dataLength, NULL);
    
    
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef iref = CGImageCreate(WIDTH_IN_PIXEL, HEIGHT_IN_PIXEL, 8, 32, WIDTH_IN_PIXEL * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                    ref, NULL, true, kCGRenderingIntentDefault);


    UIGraphicsBeginImageContext(CGSizeMake(WIDTH_IN_PIXEL, HEIGHT_IN_PIXEL));
    CGContextRef cgcontext = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, WIDTH_IN_PIXEL, HEIGHT_IN_PIXEL), iref);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
//        NSData *d = UIImageJPEGRepresentation(image, 1);
//        NSString *documentDirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//        static NSInteger imageNO = 1;
//        imageNO++;
////        NSString *savingPath = [documentDirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.jpg",imageNO]];
//        NSString *savingPath = @"/Users/huima/Downloads/gl.jpeg";
//        NSLog(@"%@", savingPath);
//        BOOL succ = [d writeToFile:savingPath atomically:NO];   //is succeeded
    
    SDL_PBWindowData* wdata = (__bridge SDL_PBWindowData*)window->driverdata;
    CALayer* _layer = wdata.viewcontroller.view.view.layer;
    
    [NSOperationQueue.mainQueue addOperationWithBlock:^{
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [CATransaction setAnimationDuration:0];
        _layer.contents = (__bridge id) image.CGImage;
        [CATransaction commit];
    }];

    free(data);
    CFRelease(ref);
    CFRelease(colorspace);
    CGImageRelease(iref);
    
    return 0;
}

void SDL_PB_DestroyWindowFramebuffer(_THIS, SDL_Window * window)
{
    SDL_Surface *surface;

    surface = (SDL_Surface *) SDL_SetWindowData(window, DUMMY_SURFACE, NULL);
    SDL_FreeSurface(surface);
}

#endif /* SDL_VIDEO_DRIVER_DUMMY */
