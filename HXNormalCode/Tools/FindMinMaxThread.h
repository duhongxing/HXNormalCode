//
//  FindMinMaxThread.h
//  HXNormalCode
//
//  Created by MacOS on 17/8/10.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindMinMaxThread : NSThread

@property (nonatomic)NSUInteger min;
@property (nonatomic)NSUInteger max;

- (instancetype)initWithNumbers:(NSArray *)numbers;

@end
