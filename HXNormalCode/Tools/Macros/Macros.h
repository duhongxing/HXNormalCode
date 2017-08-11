//
//  Macros.h
//  HXNormalCode
//
//  Created by MacOS on 17/8/2.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define StringLog(s,...)  NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#define HXWeakObj(o) autoreleasepool{} __weak typeof(o) o##self = o;

#define kScale ([UIScreen mainScreen].bounds.size.width)/320

#define StatusBar_HEIGHT 20  //状态栏高度

#define NavigationBar_HEIGHT 44  //导航条高度

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) //屏幕宽度

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//屏幕高度

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue] //系统版本-float

#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])  //系统版本-string

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0]) //系统语言

#define kWindow [[UIApplication sharedApplication] keyWindow]

#ifdef DEBUG

#  define XHLog(fmt, ...) NSLog((@"%s [XH %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#  define XHLog(...)

#endif

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#if TARGET_OS_IPHONE

//iPhone Device

#endif

#if TARGET_IPHONE_SIMULATOR

//iPhone Simulator

#endif

//-------颜色-----
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define myBlue  [UIColor colorWithRed:2/255.0 green:152/255.0 blue:254/255.0 alpha:1]
#define myGray  [UIColor colorWithRed:242/255.0 green:244/255.0 blue:245/255.0 alpha:1]

#define HX_BLUECOLOR [UIColor colorWithRed:-0/255.0 green:180/255.0 blue:233/255.0 alpha:1.0]

#define HEX_COLOR_A(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]

#define HEX_COLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//View 圆角
#define ViewRadius(View,Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//ARC

#if __has_feature(objc_arc)

//compiling with ARC

#else

// compiling without ARC

#endif

//G－C－D
#define GCDBACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCDMAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define kNotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))

#define kIsNilOrNull(_ref)  (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#define OBJC_STRINGIFY(x) @#x

#define encodeObject(x) [aCoder encodeObject:x forKey:OBJC_STRINGIFY(x)]

#define decodeObject(x) x = [aDecoder decodeObjectForKey:OBJC_STRINGIFY(x)]

#define encodeBool(x) [aCoder encodeBool:x forKey:OBJC_STRINGIFY(x)]

#define decodeBool(x) x = [aDecoder decodeBoolForKey:OBJC_STRINGIFY(x)]

#define encodeInt(x) [aCoder encodeInt:x forKey:OBJC_STRINGIFY(x)]

#define decodeInt(x) x = [aDecoder decodeIntForKey:OBJC_STRINGIFY(x)]

#define encodeDouble(x) [aCoder encodeDouble:x forKey:OBJC_STRINGIFY(x)]

#define decodeDouble(x) x = [aDecoder decodeDoubleForKey:OBJC_STRINGIFY(x)

#endif /* Macros_h */
