//
//  RegularExpressionViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/2.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "RegularExpressionViewController.h"

@interface RegularExpressionViewController ()

@end

@implementation RegularExpressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//正则匹配
- (BOOL)string:(NSString *)source MatchRegex:(NSString *)exp{
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",exp];
    return [predicate evaluateWithObject:source];
}

//获取正则表达式中匹配的个数
- (NSInteger)getMatchCount:(NSString *)text inRegx:(NSString *)exp{
    NSRegularExpression *regex =[NSRegularExpression regularExpressionWithPattern:exp options:0 error:nil];
    int count = 0;
    if (regex != nil) {
        NSArray *array =[regex matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, [text length])];
        for (int i = 0; i < [array count]; i++) {
            NSTextCheckingResult *tcr =[array objectAtIndex:i];
            NSRange range = [tcr range];
            count += range.length;
        }
    }
    return count;
}


@end
