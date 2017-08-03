//
//  HXAccountItem.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "HXAccountItem.h"

@implementation HXAccountItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {
        self.user_name = [aDecoder decodeObjectForKey:@"user_name"];
        self.user_phoneNum = [aDecoder decodeObjectForKey:@"user_phoneNum"];
        self.user_gender = [aDecoder decodeObjectForKey:@"user_gender"];
        self.user_age =[aDecoder decodeObjectForKey:@"user_age"];
    }

    return self;

}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.user_name forKey:@"user_name"];
    [aCoder encodeObject:self.user_age forKey:@"user_age"];
    [aCoder encodeObject:self.user_gender forKey:@"user_gender"];
    [aCoder encodeObject:self.user_phoneNum forKey:@"user_phoneNum"];
}

@end
