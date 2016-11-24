//
//  CommonMacro.h
//  WeexiOS
//
//  Created by FallenK on 2016/11/10.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h
// 系统版本
#define SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
// App Build 号
#define SYSTEM_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// App 版本号
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
// App 项目名
#define APP_DISPLAYNAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
// App 的 icon
#define ICON_IMAGE [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary]                                    \
valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] \
lastObject]]
// 获取 KeyWindow
#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define RGBA(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:((a) / 1.0)]
#define RGB(r, g, b) RGBA(r, g, b, 1.0)

#define SCREEN_WIDTH ((                                                                                                           \
([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) ||           \
([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? \
[[UIScreen mainScreen] bounds].size.width :                                                             \
[[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((                                                                                                           \
([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) ||           \
([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? \
[[UIScreen mainScreen] bounds].size.height :                                                            \
[[UIScreen mainScreen] bounds].size.width)
#define NAVGATIONBAR_HEIGHT 64.f
#define TABBAR_HEIGHT 49.f

#define IS_IPHONE4 (SCREEN_HEIGHT == 480)
#define IS_IPHONE5 (SCREEN_HEIGHT == 568)
#define IS_IPHONE6 (SCREEN_HEIGHT == 667)
#define IS_IPHONE6P (SCREEN_HEIGHT == 960)

// 强引用 / 弱引用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) \
autoreleasepool {}  \
__weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) \
autoreleasepool {}  \
__block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) \
try {               \
} @finally {        \
}                   \
{}                  \
__weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) \
try {               \
} @finally {        \
}                   \
{}                  \
__block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) \
autoreleasepool {}    \
__typeof__(object) object = weak##_##object;
#else
#define strongify(object) \
autoreleasepool {}    \
__typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) \
try {                 \
} @finally {          \
}                     \
__typeof__(object) object = weak##_##object;
#else
#define strongify(object) \
try {                 \
} @finally {          \
}                     \
__typeof__(object) object = block##_##object;
#endif
#endif
#endif




// 绘制 1px 线 当线宽为奇数时，绘制位置的偏移量的 x y 分别减去 SINGLE_LINE_ADJUST_OFFSET
#define SINGLE_LINE_WIDTH (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET ((1 / [UIScreen mainScreen].scale) / 2)

#endif /* CommonMacro_h */
