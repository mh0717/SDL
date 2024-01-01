//
//  SDL_pbview.h
//  SDL
//
//  Created by Huima on 2021/8/27.
//

#ifndef SDL_pbview_h
#define SDL_pbview_h

#import <UIKit/UIKit.h>

#include "../SDL_sysvideo.h"

#include "SDL_touch.h"

@interface SDL_pblayer : CALayer

@property(nonatomic, assign) void* _Nullable rawPixels;

- (BOOL) contentsAreFlipped;

- (void)removeFromSuperlayer;
- (nullable id<CAAction>)actionForKey:(NSString *_Nullable)event;

@end

//#if !TARGET_OS_TV && defined(__IPHONE_13_4)
//@interface SDL_pbview : UIView <UIPointerInteractionDelegate>
//#else
//@interface SDL_pbview : UIView
//#endif
@interface SDL_pbview : NSObject

@property(nonatomic, readonly) CGRect bounds;
@property(nonatomic, readwrite) CGRect frame;

//@property(nonatomic, strong) CALayer* layer;
@property(nonatomic, assign) CGFloat contentScaleFactor;
@property(nonatomic, assign) BOOL multipleTouchEnabled;

@property(nonatomic, strong) UIView* _Nullable view;

- (instancetype _Nullable )initWithFrame:(CGRect)frame;

- (SDL_Window*_Nullable) window;
- (void)setSDLWindow:(SDL_Window *_Nullable)window;

- (void)layoutSubviews;
- (void) setNeedsLayout;
- (void) layoutIfNeeded;
- (void) removeFromSuperview;


//#if !TARGET_OS_TV && defined(__IPHONE_13_4)
//- (UIPointerRegion *)pointerInteraction:(UIPointerInteraction *)interaction regionForRequest:(UIPointerRegionRequest *)request defaultRegion:(UIPointerRegion *)defaultRegion API_AVAILABLE(ios(13.4));
//- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction styleForRegion:(UIPointerRegion *)region  API_AVAILABLE(ios(13.4));
//#endif
//
//- (CGPoint)touchLocation:(UITouch *)touch shouldNormalize:(BOOL)normalize;
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end





@interface SDL_pbuiview: UIView<UIPointerInteractionDelegate>

@property(nonatomic, readonly) SDL_Window* _Nullable swindow;

#if !TARGET_OS_TV && defined(__IPHONE_13_4)
- (UIPointerRegion *)pointerInteraction:(UIPointerInteraction *)interaction regionForRequest:(UIPointerRegionRequest *)request defaultRegion:(UIPointerRegion *)defaultRegion API_AVAILABLE(ios(13.4));
- (UIPointerStyle *)pointerInteraction:(UIPointerInteraction *)interaction styleForRegion:(UIPointerRegion *)region  API_AVAILABLE(ios(13.4));
#endif

- (CGPoint)touchLocation:(UITouch *)touch shouldNormalize:(BOOL)normalize;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

@end




#endif /* SDL_pbview_h */
