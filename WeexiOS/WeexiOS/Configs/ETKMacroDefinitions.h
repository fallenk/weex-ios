//
//  ETKMacroDefinitions.h
//  WeexiOS
//
//  Created by FallenK on 2016/11/11.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#ifndef ETKMacroDefinitions_h
#define ETKMacroDefinitions_h
#pragma mark - DDLOG

#ifdef DEBUG
//static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
//static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif


#pragma mark - COLORS

#define ETK_COLOR_THEME_PURPLE RGB(215, 92, 243)  // 紫
#define ETK_COLOR_THEME_PINK RGB(235, 79, 144)    // 粉
#define ETK_COLOR_THEME_RED RGB(254, 100, 101)    // 红
#define ETK_COLOR_THEME_CYAN RGB(128, 238, 237)   // 青
#define ETK_COLOR_BG RGB(237, 237, 237)           // 背景色
#define ETK_COLOR_SHADE RGBA(0, 0, 0, 0.3)        // 遮罩
#define ETK_COLOR_WORD_HIGH RGB(51, 51, 51)       // 标题文字
#define ETK_COLOR_WORD_NORMAL RGB(153, 153, 153)  // 正文文字
#define ETK_COLOR_WORD_LOW RGB(153, 153, 153)     // 次要文字
#define ETK_COLOR_WORD_LIGHTBLACK RGB(102, 102, 102)//浅黑文字

#pragma mark - FONTS

#define kFont10 [UIFont systemFontOfSize:10]
#define kFont11 [UIFont systemFontOfSize:11]
#define kFont12 [UIFont systemFontOfSize:12]
#define kFont13 [UIFont systemFontOfSize:13]
#define kFont14 [UIFont systemFontOfSize:14]
#define kFont15 [UIFont systemFontOfSize:15]
#define kFont16 [UIFont systemFontOfSize:16]
#define kFont17 [UIFont systemFontOfSize:17]
#define kFont18 [UIFont systemFontOfSize:18]
#define kFont19 [UIFont systemFontOfSize:19]
#define kFont20 [UIFont systemFontOfSize:20]
#define kFont21 [UIFont systemFontOfSize:21]
#define kFont22 [UIFont systemFontOfSize:22]
#define kFont23 [UIFont systemFontOfSize:23]
#define kFont24 [UIFont systemFontOfSize:24]
#define kFont25 [UIFont systemFontOfSize:25]
#define kFont26 [UIFont systemFontOfSize:26]
#define kFont27 [UIFont systemFontOfSize:27]
#define kFont28 [UIFont systemFontOfSize:28]
#define kFont29 [UIFont systemFontOfSize:29]
#define kFont30 [UIFont systemFontOfSize:30]

#define kFontBold13 [UIFont fontWithName:@"Helvetica-Bold" size:13]
#define kFontBold15 [UIFont fontWithName:@"Helvetica-Bold" size:15]
#define kFontBold17 [UIFont fontWithName:@"Helvetica-Bold" size:17]
#define kFontBold18 [UIFont fontWithName:@"Helvetica-Bold" size:18]
#define kFontBold19 [UIFont fontWithName:@"Helvetica-Bold" size:19]
#define kFontBold20 [UIFont fontWithName:@"Helvetica-Bold" size:20]
#define kFontBold21 [UIFont fontWithName:@"Helvetica-Bold" size:21]
#define kFontBold22 [UIFont fontWithName:@"Helvetica-Bold" size:22]
#define kFontBold23 [UIFont fontWithName:@"Helvetica-Bold" size:23]
#define kFontBold24 [UIFont fontWithName:@"Helvetica-Bold" size:24]
#define kFontBold25 [UIFont fontWithName:@"Helvetica-Bold" size:25]


#endif /* ETKMacroDefinitions_h */
