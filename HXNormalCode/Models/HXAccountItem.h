//
//  HXAccountItem.h
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXAccountItem : NSObject<NSCoding>

//!< 姓名
@property (nonatomic,copy)NSString *user_name;

//!< 电话号
@property (nonatomic,copy)NSString *user_phoneNum;

//!< 年龄
@property (nonatomic,copy)NSString *user_age;

//!< 性别
@property (nonatomic,copy)NSString *user_gender;

@end

