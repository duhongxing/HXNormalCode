//
//  HXAccountManager.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "HXAccountManager.h"

@implementation HXAccountManager

+ (HXAccountManager *)shareInstance{
    static HXAccountManager *manager = nil;
    static dispatch_once_t  onceToken;

    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[HXAccountManager alloc]init];
        }
    });
    return manager;
}

@end
