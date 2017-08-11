//
//  FindMinMaxThread.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/10.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "FindMinMaxThread.h"

@implementation FindMinMaxThread
{
    NSArray *_numbers;
}

- (instancetype)initWithNumbers:(NSArray *)numbers
{
    self = [super init];

    if (self) {
        _numbers = numbers;
    }

    return self;
}

- (void)handle{
    NSUInteger min;
    NSUInteger max;
    self.min = min;
    self.max = max;
}

@end
