//
//  Macros.h
//  HXNormalCode
//
//  Created by MacOS on 17/8/2.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#ifdef DEBUG
#define HXAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define HXAppLog(s, ... )
#endif

#define StringLog(string)  NSLog(@"%@",string)




#endif /* Macros_h */
