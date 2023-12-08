//
//  SDL_pbviewcontroller.m
//  SDL
//
//  Created by Huima on 2021/8/28.
//

#include "../../SDL_internal.h"

#if SDL_VIDEO_DRIVER_PBOX

#include "SDL_video.h"
#include "SDL_hints.h"
#include "../SDL_sysvideo.h"
#include "../../events/SDL_events_c.h"
#include "../../events/SDL_windowevents_c.h"

#include "SDL_pbviewcontroller.h"
#include "SDL_pbmessagebox.h"
#include "SDL_pbevents.h"
#include "SDL_pbvideo.h"
#include "SDL_pbmodes.h"
#include "SDL_pbwindow.h"
#include "SDL_pbopengles.h"

#if SDL_IPHONE_KEYBOARD
#ifndef _UIKIT_KeyInfo
#define _UIKIT_KeyInfo

#include "SDL_scancode.h"

/*
    This file is used by the keyboard code in SDL_uikitview.m to convert between characters
    passed in from the iPhone's virtual keyboard, and tuples of SDL_Scancode and SDL_keymods.
    For example unicharToUIKeyInfoTable['a'] would give you the scan code and keymod for lower
    case a.
*/

typedef struct
{
    SDL_Scancode code;
    Uint16 mod;
} UIKitKeyInfo;

/* So far only ASCII characters here */
static UIKitKeyInfo unicharToUIKeyInfoTable[] = {
/*  0 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  1 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  2 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  3 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  4 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  5 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  6 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  7 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  8 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  9 */  {  SDL_SCANCODE_UNKNOWN, 0 },
/*  10 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  11 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  12 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  13 */ {   SDL_SCANCODE_RETURN, 0 },
/*  14 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  15 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  16 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  17 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  18 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  19 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  20 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  21 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  22 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  23 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  24 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  25 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  26 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  27 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  28 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  29 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  30 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  31 */ {   SDL_SCANCODE_UNKNOWN, 0 },
/*  32 */ {   SDL_SCANCODE_SPACE, 0 },
/*  33 */ {   SDL_SCANCODE_1,    KMOD_SHIFT },        /* plus shift modifier '!' */
/*  34 */ {   SDL_SCANCODE_APOSTROPHE, KMOD_SHIFT },    /* plus shift modifier '"' */
/*  35 */ {   SDL_SCANCODE_3, KMOD_SHIFT },            /* plus shift modifier '#' */
/*  36 */ {   SDL_SCANCODE_4, KMOD_SHIFT },            /* plus shift modifier '$' */
/*  37 */ {   SDL_SCANCODE_5, KMOD_SHIFT },            /* plus shift modifier '%' */
/*  38 */ {   SDL_SCANCODE_7, KMOD_SHIFT },            /* plus shift modifier '&' */
/*  39 */ {   SDL_SCANCODE_APOSTROPHE, 0 },    /* '''                       */
/*  40 */ {   SDL_SCANCODE_9, KMOD_SHIFT },             /* plus shift modifier '(' */
/*  41 */ {   SDL_SCANCODE_0, KMOD_SHIFT },            /* plus shift modifier ')' */
/*  42 */ {   SDL_SCANCODE_8, KMOD_SHIFT },            /* '*' */
/*  43 */ {   SDL_SCANCODE_EQUALS, KMOD_SHIFT },    /* plus shift modifier '+' */
/*  44 */ {   SDL_SCANCODE_COMMA, 0 },        /* ','                       */
/*  45 */ {   SDL_SCANCODE_MINUS, 0 },        /* '-'                       */
/*  46 */ {   SDL_SCANCODE_PERIOD, 0 },        /* '.'                       */
/*  47 */ {   SDL_SCANCODE_SLASH, 0 },        /* '/'                       */
/*  48 */ {   SDL_SCANCODE_0, 0    },
/*  49 */ {   SDL_SCANCODE_1, 0 },
/*  50 */ {   SDL_SCANCODE_2, 0 },
/*  51 */ {   SDL_SCANCODE_3, 0 },
/*  52 */ {   SDL_SCANCODE_4, 0 },
/*  53 */ {   SDL_SCANCODE_5, 0 },
/*  54 */ {   SDL_SCANCODE_6, 0 },
/*  55 */ {   SDL_SCANCODE_7, 0 },
/*  56 */ {   SDL_SCANCODE_8, 0 },
/*  57 */ {   SDL_SCANCODE_9, 0 },
/*  58 */ {   SDL_SCANCODE_SEMICOLON,  KMOD_SHIFT },    /* plus shift modifier ';' */
/*  59 */ {   SDL_SCANCODE_SEMICOLON, 0 },
/*  60 */ {   SDL_SCANCODE_COMMA,  KMOD_SHIFT },         /* plus shift modifier '<' */
/*  61 */ {   SDL_SCANCODE_EQUALS, 0 },
/*  62 */ {   SDL_SCANCODE_PERIOD,  KMOD_SHIFT },        /* plus shift modifier '>' */
/*  63 */ {   SDL_SCANCODE_SLASH,  KMOD_SHIFT },        /* plus shift modifier '?' */
/*  64 */ {   SDL_SCANCODE_2,  KMOD_SHIFT },            /* plus shift modifier '@' */
/*  65 */ {   SDL_SCANCODE_A,  KMOD_SHIFT },            /* all the following need shift modifiers */
/*  66 */ {   SDL_SCANCODE_B,  KMOD_SHIFT },
/*  67 */ {   SDL_SCANCODE_C,  KMOD_SHIFT },
/*  68 */ {   SDL_SCANCODE_D,  KMOD_SHIFT },
/*  69 */ {   SDL_SCANCODE_E,  KMOD_SHIFT },
/*  70 */ {   SDL_SCANCODE_F,  KMOD_SHIFT },
/*  71 */ {   SDL_SCANCODE_G,  KMOD_SHIFT },
/*  72 */ {   SDL_SCANCODE_H,  KMOD_SHIFT },
/*  73 */ {   SDL_SCANCODE_I,  KMOD_SHIFT },
/*  74 */ {   SDL_SCANCODE_J,  KMOD_SHIFT },
/*  75 */ {   SDL_SCANCODE_K,  KMOD_SHIFT },
/*  76 */ {   SDL_SCANCODE_L,  KMOD_SHIFT },
/*  77 */ {   SDL_SCANCODE_M,  KMOD_SHIFT },
/*  78 */ {   SDL_SCANCODE_N,  KMOD_SHIFT },
/*  79 */ {   SDL_SCANCODE_O,  KMOD_SHIFT },
/*  80 */ {   SDL_SCANCODE_P,  KMOD_SHIFT },
/*  81 */ {   SDL_SCANCODE_Q,  KMOD_SHIFT },
/*  82 */ {   SDL_SCANCODE_R,  KMOD_SHIFT },
/*  83 */ {   SDL_SCANCODE_S,  KMOD_SHIFT },
/*  84 */ {   SDL_SCANCODE_T,  KMOD_SHIFT },
/*  85 */ {   SDL_SCANCODE_U,  KMOD_SHIFT },
/*  86 */ {   SDL_SCANCODE_V,  KMOD_SHIFT },
/*  87 */ {   SDL_SCANCODE_W,  KMOD_SHIFT },
/*  88 */ {   SDL_SCANCODE_X,  KMOD_SHIFT },
/*  89 */ {   SDL_SCANCODE_Y,  KMOD_SHIFT },
/*  90 */ {   SDL_SCANCODE_Z,  KMOD_SHIFT },
/*  91 */ {   SDL_SCANCODE_LEFTBRACKET, 0 },
/*  92 */ {   SDL_SCANCODE_BACKSLASH, 0 },
/*  93 */ {   SDL_SCANCODE_RIGHTBRACKET, 0 },
/*  94 */ {   SDL_SCANCODE_6,  KMOD_SHIFT },            /* plus shift modifier '^' */
/*  95 */ {   SDL_SCANCODE_MINUS,  KMOD_SHIFT },        /* plus shift modifier '_' */
/*  96 */ {   SDL_SCANCODE_GRAVE,  KMOD_SHIFT },        /* '`' */
/*  97 */ {   SDL_SCANCODE_A, 0    },
/*  98 */ {   SDL_SCANCODE_B, 0 },
/*  99 */ {   SDL_SCANCODE_C, 0 },
/*  100 */{    SDL_SCANCODE_D, 0 },
/*  101 */{    SDL_SCANCODE_E, 0 },
/*  102 */{    SDL_SCANCODE_F, 0 },
/*  103 */{    SDL_SCANCODE_G, 0 },
/*  104 */{    SDL_SCANCODE_H, 0 },
/*  105 */{    SDL_SCANCODE_I, 0 },
/*  106 */{    SDL_SCANCODE_J, 0 },
/*  107 */{    SDL_SCANCODE_K, 0 },
/*  108 */{    SDL_SCANCODE_L, 0 },
/*  109 */{    SDL_SCANCODE_M, 0 },
/*  110 */{    SDL_SCANCODE_N, 0 },
/*  111 */{    SDL_SCANCODE_O, 0 },
/*  112 */{    SDL_SCANCODE_P, 0 },
/*  113 */{    SDL_SCANCODE_Q, 0 },
/*  114 */{    SDL_SCANCODE_R, 0 },
/*  115 */{    SDL_SCANCODE_S, 0 },
/*  116 */{    SDL_SCANCODE_T, 0 },
/*  117 */{    SDL_SCANCODE_U, 0 },
/*  118 */{    SDL_SCANCODE_V, 0 },
/*  119 */{    SDL_SCANCODE_W, 0 },
/*  120 */{    SDL_SCANCODE_X, 0 },
/*  121 */{    SDL_SCANCODE_Y, 0 },
/*  122 */{    SDL_SCANCODE_Z, 0 },
/*  123 */{    SDL_SCANCODE_LEFTBRACKET, KMOD_SHIFT },    /* plus shift modifier '{' */
/*  124 */{    SDL_SCANCODE_BACKSLASH, KMOD_SHIFT },    /* plus shift modifier '|' */
/*  125 */{    SDL_SCANCODE_RIGHTBRACKET, KMOD_SHIFT },    /* plus shift modifier '}' */
/*  126 */{    SDL_SCANCODE_GRAVE, KMOD_SHIFT },         /* plus shift modifier '~' */
/*  127 */{    SDL_SCANCODE_BACKSPACE, KMOD_SHIFT }
};

#endif /* _UIKIT_KeyInfo */
#endif

#import "YQPresentTransitionAnimated.h"
#import "YQDismissTransitionAnimated.h"

#if TARGET_OS_TV
static void SDLCALL
SDL_AppleTVControllerUIHintChanged(void *userdata, const char *name, const char *oldValue, const char *hint)
{
    @autoreleasepool {
        SDL_uikitviewcontroller *viewcontroller = (__bridge SDL_uikitviewcontroller *) userdata;
        viewcontroller.controllerUserInteractionEnabled = hint && (*hint != '0');
    }
}
#endif

#if !TARGET_OS_TV
static void SDLCALL
SDL_HideHomeIndicatorHintChanged(void *userdata, const char *name, const char *oldValue, const char *hint)
{
    @autoreleasepool {
        SDL_pbviewcontroller *viewcontroller = (__bridge SDL_pbviewcontroller *) userdata;
        viewcontroller.homeIndicatorHidden = (hint && *hint) ? SDL_atoi(hint) : -1;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"
        UIViewController* vc = viewcontroller.controller;
        if (vc) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            if ([vc respondsToSelector:@selector(setNeedsUpdateOfHomeIndicatorAutoHidden)]) {
                                [vc setNeedsUpdateOfHomeIndicatorAutoHidden];
                                [vc setNeedsUpdateOfScreenEdgesDeferringSystemGestures];
                            }
            }];
        }
        
#pragma clang diagnostic pop
    }
}
#endif

@implementation SDL_pbviewcontroller {
    CADisplayLink *displayLink;
    int animationInterval;
    void (*animationCallback)(void*);
    void *animationCallbackParam;

#if SDL_IPHONE_KEYBOARD
    UITextField *textField;
    BOOL hardwareKeyboard;
    BOOL showingKeyboard;
    BOOL rotatingOrientation;
    NSString *changeText;
    NSString *obligateForBackspace;
#endif
}

@synthesize window;


- (UITextField*) utextField {
    return textField;
}

- (UIViewController*) controller {
    if (self.window == NULL) return nil;
    SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
    return data.uvcontroller;
}

- (instancetype)initWithSDLWindow:(SDL_Window *)_window
{
    if (self = [super init]) {
        self.window = _window;

#if SDL_IPHONE_KEYBOARD
        [self initKeyboard];
        hardwareKeyboard = NO;
        showingKeyboard = NO;
        rotatingOrientation = NO;
#endif

#if TARGET_OS_TV
        SDL_AddHintCallback(SDL_HINT_APPLE_TV_CONTROLLER_UI_EVENTS,
                            SDL_AppleTVControllerUIHintChanged,
                            (__bridge void *) self);
#endif

#if !TARGET_OS_TV
        SDL_AddHintCallback(SDL_HINT_IOS_HIDE_HOME_INDICATOR,
                            SDL_HideHomeIndicatorHintChanged,
                            (__bridge void *) self);
#endif
    }
    return self;
}

- (void)dealloc
{
#if SDL_IPHONE_KEYBOARD
    [self deinitKeyboard];
#endif

#if TARGET_OS_TV
    SDL_DelHintCallback(SDL_HINT_APPLE_TV_CONTROLLER_UI_EVENTS,
                        SDL_AppleTVControllerUIHintChanged,
                        (__bridge void *) self);
#endif

#if !TARGET_OS_TV
    SDL_DelHintCallback(SDL_HINT_IOS_HIDE_HOME_INDICATOR,
                        SDL_HideHomeIndicatorHintChanged,
                        (__bridge void *) self);
#endif
}


- (void)setAnimationCallback:(int)interval
                    callback:(void (*)(void*))callback
               callbackParam:(void*)callbackParam
{
    [self stopAnimation];

    animationInterval = interval;
    animationCallback = callback;
    animationCallbackParam = callbackParam;

    if (animationCallback) {
        [self startAnimation];
    }
}

- (void)startAnimation
{
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(doLoop:)];

#ifdef __IPHONE_10_3
    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *) window->driverdata;

    if ([displayLink respondsToSelector:@selector(preferredFramesPerSecond)]
        && data != nil && data.uiwindow != nil
        && [data.uiwindow.screen respondsToSelector:@selector(maximumFramesPerSecond)]) {
        displayLink.preferredFramesPerSecond = data.uiwindow.screen.maximumFramesPerSecond / animationInterval;
    } else
#endif
    {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 100300
        [displayLink setFrameInterval:animationInterval];
#endif
    }

    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopAnimation
{
    [displayLink invalidate];
    displayLink = nil;
}

- (void)doLoop:(CADisplayLink*)sender
{
    /* Don't run the game loop while a messagebox is up */
    if (!PB_ShowingMessageBox()) {
        /* See the comment in the function definition. */
#if SDL_VIDEO_OPENGL_ES || SDL_VIDEO_OPENGL_ES2
        PB_GL_RestoreCurrentContext();
#endif

        animationCallback(animationCallbackParam);
    }
}

- (void)loadView
{
    /* Do nothing. */
}

- (void)viewDidLayoutSubviews
{
    
}

- (void) setNeedsUpdateOfPrefersPointerLocked {
    if (self.controller) {
        UIViewController* vc = self.controller;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (@available(iOS 14.0, *)) {
                [vc setNeedsUpdateOfPrefersPointerLocked];
            }
        }];
    }
}


#if !TARGET_OS_TV
- (NSUInteger)supportedInterfaceOrientations
{
    return PB_GetSupportedOrientations(window);
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orient
{
    return ([self supportedInterfaceOrientations] & (1 << orient)) != 0;
}
#endif

- (BOOL)prefersStatusBarHidden
{
    BOOL hidden = (window->flags & (SDL_WINDOW_FULLSCREEN|SDL_WINDOW_BORDERLESS)) != 0;
    return hidden;
}

- (BOOL)prefersHomeIndicatorAutoHidden
{
    BOOL hidden = NO;
    if (self.homeIndicatorHidden == 1) {
        hidden = YES;
    }
    return hidden;
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
{
    if (self.homeIndicatorHidden >= 0) {
        if (self.homeIndicatorHidden == 2) {
            return UIRectEdgeAll;
        } else {
            return UIRectEdgeNone;
        }
    }

    /* By default, fullscreen and borderless windows get all screen gestures */
    if ((window->flags & (SDL_WINDOW_FULLSCREEN|SDL_WINDOW_BORDERLESS)) != 0) {
        return UIRectEdgeAll;
    } else {
        return UIRectEdgeNone;
    }
}

- (BOOL)prefersPointerLocked
{
    SDL_VideoDevice *_this = SDL_GetVideoDevice();
    
    if (SDL_PBHasGCMouse() &&
        (SDL_PBGCMouseRelativeMode() || _this->grabbed_window == window)) {
        return YES;
    } else {
        return NO;
    }
}

#endif /* !TARGET_OS_TV */

/*
 ---- Keyboard related functionality below this line ----
 */
#if SDL_IPHONE_KEYBOARD

@synthesize textInputRect;
@synthesize keyboardHeight;
@synthesize keyboardVisible;

/* Set ourselves up as a UITextFieldDelegate */
- (void)initKeyboard
{
    void (^handle)(void) = ^{
        self->changeText = nil;
        self->obligateForBackspace = @"                                                                "; /* 64 space */
        self->textField = [[UITextField alloc] initWithFrame:CGRectZero];
        self->textField.delegate = self;
        /* placeholder so there is something to delete! */
        self->textField.text = self->obligateForBackspace;

        /* set UITextInputTrait properties, mostly to defaults */
        self->textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self->textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self->textField.enablesReturnKeyAutomatically = NO;
        self->textField.keyboardAppearance = UIKeyboardAppearanceDefault;
        self->textField.keyboardType = UIKeyboardTypeDefault;
        self->textField.returnKeyType = UIReturnKeyDefault;
        self->textField.secureTextEntry = NO;

        self->textField.hidden = YES;
    };
    if (NSThread.isMainThread) {
        handle();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), handle);
    }
    
    keyboardVisible = NO;

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
#if !TARGET_OS_TV
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
#endif
    [center addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (NSArray *)keyCommands
{
    NSMutableArray *commands = [[NSMutableArray alloc] init];
    [commands addObject:[UIKeyCommand keyCommandWithInput:UIKeyInputUpArrow modifierFlags:kNilOptions action:@selector(handleCommand:)]];
    [commands addObject:[UIKeyCommand keyCommandWithInput:UIKeyInputDownArrow modifierFlags:kNilOptions action:@selector(handleCommand:)]];
    [commands addObject:[UIKeyCommand keyCommandWithInput:UIKeyInputLeftArrow modifierFlags:kNilOptions action:@selector(handleCommand:)]];
    [commands addObject:[UIKeyCommand keyCommandWithInput:UIKeyInputRightArrow modifierFlags:kNilOptions action:@selector(handleCommand:)]];
    [commands addObject:[UIKeyCommand keyCommandWithInput:UIKeyInputEscape modifierFlags:kNilOptions action:@selector(handleCommand:)]];
    return [NSArray arrayWithArray:commands];
}

- (void)handleCommand:(UIKeyCommand *)keyCommand
{
    SDL_Scancode scancode = SDL_SCANCODE_UNKNOWN;
    NSString *input = keyCommand.input;

    if (input == UIKeyInputUpArrow) {
        scancode = SDL_SCANCODE_UP;
    } else if (input == UIKeyInputDownArrow) {
        scancode = SDL_SCANCODE_DOWN;
    } else if (input == UIKeyInputLeftArrow) {
        scancode = SDL_SCANCODE_LEFT;
    } else if (input == UIKeyInputRightArrow) {
        scancode = SDL_SCANCODE_RIGHT;
    } else if (input == UIKeyInputEscape) {
        scancode = SDL_SCANCODE_ESCAPE;
    }

    if (scancode != SDL_SCANCODE_UNKNOWN) {
        if (self.window != NULL) {
            SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
            [data.uiqueue addObject:^{
                SDL_SendKeyboardKeyAutoRelease(scancode);
            }];
        }
        
    }
}

- (void)setView:(SDL_pbview *)view
{
    _view = view;

    if (NSThread.isMainThread) {
        [_view.view addSubview:textField];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_view.view addSubview:self->textField];
        });
    }

    if (keyboardVisible) {
        [self showKeyboard];
    }
}

/* willRotateToInterfaceOrientation and didRotateFromInterfaceOrientation are deprecated in iOS 8+ in favor of viewWillTransitionToSize */
#if TARGET_OS_TV || __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    rotatingOrientation = YES;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {}
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self->rotatingOrientation = NO;
    }];
}
#else
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    rotatingOrientation = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    rotatingOrientation = NO;
}
#endif /* TARGET_OS_TV || __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000 */

- (void)deinitKeyboard
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
#if !TARGET_OS_TV
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
#endif
    [center removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

/* reveal onscreen virtual keyboard */
- (void)showKeyboard
{
    keyboardVisible = YES;
    void (^handle)(void) = ^{
        if (self->textField.window) {
            self->showingKeyboard = YES;
            [self->textField becomeFirstResponder];
            self->showingKeyboard = NO;
        }
    };
    if (NSThread.isMainThread) {
        handle();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), handle);
    }
    
}

/* hide onscreen virtual keyboard */
- (void)hideKeyboard
{
    keyboardVisible = NO;

    if (NSThread.isMainThread) {
        [textField resignFirstResponder];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->textField resignFirstResponder];
        });
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.window == NULL) return;
#if !TARGET_OS_TV
    CGRect kbrect = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
    UIView* uview = data.uvcontroller.view;
    

    /* The keyboard rect is in the coordinate space of the screen/window, but we
     * want its height in the coordinate space of the view. */
    kbrect = [uview convertRect:kbrect fromView:nil];
    
    [self setKeyboardHeight:(int)kbrect.size.height];

    
#endif
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.window == NULL) return;
    SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
    [data.uiqueue addObject:^{
        if (!self->showingKeyboard && !self->rotatingOrientation) {
            SDL_StopTextInput();
        }
    }];
    [self setKeyboardHeight:0];
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if (self.window == NULL) return;
    SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
    [data.uiqueue addObject:^{
        [self textFieldTextDidChange_sdl: notification];
    }];
}

- (void)textFieldTextDidChange_sdl:(NSNotification *)notification
{
    if (changeText!=nil && textField.markedTextRange == nil)
    {
        NSUInteger len = changeText.length;
        if (len > 0) {
            if (!SDL_HardwareKeyboardKeyPressed()) {
                /* Go through all the characters in the string we've been sent and
                 * convert them to key presses */
                int i;
                for (i = 0; i < len; i++) {
                    unichar c = [changeText characterAtIndex:i];
                    SDL_Scancode code;
                    Uint16 mod;

                    if (c < 127) {
                        /* Figure out the SDL_Scancode and SDL_keymod for this unichar */
                        code = unicharToUIKeyInfoTable[c].code;
                        mod  = unicharToUIKeyInfoTable[c].mod;
                    } else {
                        /* We only deal with ASCII right now */
                        code = SDL_SCANCODE_UNKNOWN;
                        mod = 0;
                    }

                    if (mod & KMOD_SHIFT) {
                        /* If character uses shift, press shift */
                        SDL_SendKeyboardKey(SDL_PRESSED, SDL_SCANCODE_LSHIFT);
                    }

                    /* send a keydown and keyup even for the character */
                    SDL_SendKeyboardKey(SDL_PRESSED, code);
                    SDL_SendKeyboardKey(SDL_RELEASED, code);

                    if (mod & KMOD_SHIFT) {
                        /* If character uses shift, release shift */
                        SDL_SendKeyboardKey(SDL_RELEASED, SDL_SCANCODE_LSHIFT);
                    }
                }
            }
            SDL_SendKeyboardText([changeText UTF8String]);
        }
        changeText = nil;
    }
}

- (void)updateKeyboard {
    if (NSThread.isMainThread) {
        [self updateKeyboard_sdl];
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self updateKeyboard_sdl];
        });
    }
}

- (void)updateKeyboard_sdl
{
    if (self.window == NULL) return;
    SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
    UIView* uview = data.uvcontroller.view;
    
    CGAffineTransform t = uview.transform;
    CGPoint offset = CGPointMake(0.0, 0.0);
    CGRect frame = PB_ComputeViewFrame(window, uview.window.screen);

    if (self.keyboardHeight) {
        int rectbottom = self.textInputRect.y + self.textInputRect.h;
        int keybottom = self.view.bounds.size.height - self.keyboardHeight;
        if (keybottom < rectbottom) {
            offset.y = keybottom - rectbottom;
        }
    }

    /* Apply this view's transform (except any translation) to the offset, in
     * order to orient it correctly relative to the frame's coordinate space. */
    t.tx = 0.0;
    t.ty = 0.0;
    offset = CGPointApplyAffineTransform(offset, t);

    /* Apply the updated offset to the view's frame. */
    frame.origin.x += offset.x;
    frame.origin.y += offset.y;

    uview.frame = frame;
}

- (void)setKeyboardHeight:(int)height
{
    keyboardVisible = height > 0;
    keyboardHeight = height;
    [self updateKeyboard];
}

/* UITextFieldDelegate method.  Invoked when user types something. */
- (BOOL)textField:(UITextField *)_textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger len = string.length;
    if (len == 0) {
        changeText = nil;
        if (textField.markedTextRange == nil) {
            /* it wants to replace text with nothing, ie a delete */
            if (self.window != NULL) {
                SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
                [data.uiqueue addObject:^{
                    SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_BACKSPACE);
                }];
            }
            
        }
        if (textField.text.length < 16) {
            textField.text = obligateForBackspace;
        }
    } else {
        changeText = string;
    }
    return YES;
}

/* Terminates the editing session */
- (BOOL)textFieldShouldReturn:(UITextField*)_textField
{
    if (self.window) {
        SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)self.window->driverdata;
        [data.uiqueue addObject:^{
            SDL_SendKeyboardKeyAutoRelease(SDL_SCANCODE_RETURN);
            if (self->keyboardVisible &&
                SDL_GetHintBoolean(SDL_HINT_RETURN_KEY_HIDES_IME, SDL_FALSE)) {
                 SDL_StopTextInput();
            }
        }];
    }
    
    return YES;
}

#endif

@end

/* iPhone keyboard addition functions */
#if SDL_IPHONE_KEYBOARD

static SDL_pbviewcontroller *
GetWindowViewController(SDL_Window * window)
{
    if (!window || !window->driverdata) {
        SDL_SetError("Invalid window");
        return nil;
    }

    SDL_PBWindowData *data = (__bridge SDL_PBWindowData *)window->driverdata;

    return data.viewcontroller;
}

SDL_bool
PB_HasScreenKeyboardSupport(_THIS)
{
    return SDL_TRUE;
}

void
PB_ShowScreenKeyboard(_THIS, SDL_Window *window)
{
    @autoreleasepool {
        SDL_pbviewcontroller *vc = GetWindowViewController(window);
        [vc showKeyboard];
    }
}

void
PB_HideScreenKeyboard(_THIS, SDL_Window *window)
{
    @autoreleasepool {
        SDL_pbviewcontroller *vc = GetWindowViewController(window);
        [vc hideKeyboard];
    }
}

SDL_bool
PB_IsScreenKeyboardShown(_THIS, SDL_Window *window)
{
    @autoreleasepool {
        SDL_pbviewcontroller *vc = GetWindowViewController(window);
        if (vc != nil) {
            return vc.keyboardVisible;
        }
        return SDL_FALSE;
    }
}

void
PB_SetTextInputRect(_THIS, const SDL_Rect *rect)
{
    if (!rect) {
        SDL_InvalidParamError("rect");
        return;
    }

    @autoreleasepool {
        SDL_pbviewcontroller *vc = GetWindowViewController(SDL_GetFocusWindow());
        if (vc != nil) {
            vc.textInputRect = *rect;

            if (vc.keyboardVisible) {
                if (NSThread.isMainThread) {
                    [vc updateKeyboard];
                }
                else {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [vc updateKeyboard];
                    });
                }
                
            }
        }
    }
}


#endif /* SDL_IPHONE_KEYBOARD */


@interface SDL_pbuicontroller()

@property (nonatomic, retain) UIPercentDrivenInteractiveTransition * percentDrivenTransition;

@property (nonatomic, assign) BOOL isEnd;

@end



@implementation SDL_pbuicontroller

- (void) setContentView:(UIView *)contentView {
    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    
    if (contentView) {
        _contentView = contentView;
        [self.view insertSubview:_contentView atIndex:0];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [_contentView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
            [_contentView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
            [_contentView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
            [_contentView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        ]];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[YQPresentTransitionAnimated alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[YQDismissTransitionAnimated alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

#pragma mark - 添加手势的方法
- (void)addScreenLeftEdgePanGestureRecognizer:(UIView *)view {
    UIScreenEdgePanGestureRecognizer * edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)]; //手势由self来管理
    edgePan.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:edgePan];
}

#pragma mark - 手势的监听方法
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat progress = fabs([edgePan translationInView:[UIApplication sharedApplication].keyWindow].x / [UIApplication sharedApplication].keyWindow.bounds.size.width);
    
    if(edgePan.state == UIGestureRecognizerStateBegan){
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        if(edgePan.edges == UIRectEdgeLeft){
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }else if(edgePan.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if(edgePan.state == UIGestureRecognizerStateCancelled || edgePan.state == UIGestureRecognizerStateEnded){
        if(progress > 0.5){
            [_percentDrivenTransition finishInteractiveTransition];
        }else{
            [_percentDrivenTransition cancelInteractiveTransition];
        }
        _percentDrivenTransition = nil;
    }
}



- (void) viewDidLoad {
    [super viewDidLoad];
    
    UIButton* exitBtn = [UIButton buttonWithType:UIButtonTypeClose];
    [exitBtn addTarget:self action:@selector(handleExit) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:exitBtn];
    
    exitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [exitBtn.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-20],
        [exitBtn.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [_contentView.widthAnchor constraintEqualToConstant:30],
        [_contentView.heightAnchor constraintEqualToConstant:30],
    ]];
    
    
    self.isEnd = FALSE;
}

- (void) handleExit {
    if (self.swindow) {
        SDL_SendWindowEvent(self.swindow, SDL_WINDOWEVENT_CLOSE, 0, 0);
        SDL_SendQuit();
    }
}


- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    SDL_Window* wd = self.swindow;
    if (wd) {
        
        SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)wd->driverdata;
        if (data.viewcontroller.utextField.window == nil) {
            [self.view addSubview:data.viewcontroller.utextField];
            
            if (data.viewcontroller.keyboardVisible) {
                [data.viewcontroller showKeyboard];
            }
        }
        
        const CGSize size = self.view.bounds.size;
        int w = (int) size.width;
        int h = (int) size.height;

        SDL_SendWindowEvent(wd, SDL_WINDOWEVENT_RESIZED, w, h);
        
        __block SDL_pbviewcontroller* vc = data.viewcontroller;
        [data.uiqueue addObject:^{
            [vc viewDidLayoutSubviews];
        }];
    }
}

//- (void) viewDidDisappear:(BOOL)animated {
//    if (self.isEnd) return;
//    
//    SDL_Window* wd = self.swindow;
//    if (wd && self.isBeingDismissed) {
//        self.isEnd = YES;
//        
//        SDL_PBWindowData* data = (__bridge SDL_PBWindowData*)wd->driverdata;
//        [data.uiqueue addObject:^{
//            SDL_SendWindowEvent(wd, SDL_WINDOWEVENT_CLOSE, 0, 0);
//        }];
//    }
//}


- (SDL_Scancode)scancodeFromPress:(UIPress*)press
{
#ifdef __IPHONE_13_4
    if ([press respondsToSelector:@selector((key))]) {
        if (press.key != nil) {
            return (SDL_Scancode)press.key.keyCode;
        }
    }
#endif

    switch (press.type) {
    case UIPressTypeUpArrow:
        return SDL_SCANCODE_UP;
    case UIPressTypeDownArrow:
        return SDL_SCANCODE_DOWN;
    case UIPressTypeLeftArrow:
        return SDL_SCANCODE_LEFT;
    case UIPressTypeRightArrow:
        return SDL_SCANCODE_RIGHT;
    case UIPressTypeSelect:
        /* HIG says: "primary button behavior" */
        return SDL_SCANCODE_RETURN;
    case UIPressTypeMenu:
        /* HIG says: "returns to previous screen" */
        return SDL_SCANCODE_ESCAPE;
    case UIPressTypePlayPause:
        /* HIG says: "secondary button behavior" */
        return SDL_SCANCODE_PAUSE;
    default:
        break;
    }

    return SDL_SCANCODE_UNKNOWN;
}

- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    [super pressesBegan: presses withEvent:event];
    
    SDL_Window* wd = self.swindow;
    if (wd == NULL) return;
    SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
    
    
    if (!SDL_PBHasGCKeyboard()) {
        for (UIPress *press in presses) {
            SDL_Scancode scancode = [self scancodeFromPress:press];
            SDL_SendKeyboardKey(SDL_PRESSED, scancode);
        }
    }
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    [super pressesEnded:presses withEvent:event];
    
    SDL_Window* wd = self.swindow;
    if (wd == NULL) return;
    SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
    
    
    if (!SDL_PBHasGCKeyboard()) {
        for (UIPress *press in presses) {
            SDL_Scancode scancode = [self scancodeFromPress:press];
            SDL_SendKeyboardKey(SDL_RELEASED, scancode);
        }
    }
    
    for (UIPress *press in presses) {
        NSString* text = press.key.characters;
        if (text && text.length == 1) {
            SDL_SendKeyboardText(text.UTF8String);
        }
    }
    
   
}

- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    [super pressesCancelled:presses withEvent:event];
    
    SDL_Window* wd = self.swindow;
    if (wd == NULL) return;
    SDL_PBWindowData* wddata = (__bridge SDL_PBWindowData*)wd->driverdata;
    
    
    if (!SDL_PBHasGCKeyboard()) {
        for (UIPress *press in presses) {
            SDL_Scancode scancode = [self scancodeFromPress:press];
            SDL_SendKeyboardKey(SDL_RELEASED, scancode);
        }
    }
}

- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    /* This is only called when the force of a press changes. */
    [super pressesChanged:presses withEvent:event];
}


@end

#endif /* SDL_VIDEO_DRIVER_UIKIT */

/* vi: set ts=4 sw=4 expandtab: */

