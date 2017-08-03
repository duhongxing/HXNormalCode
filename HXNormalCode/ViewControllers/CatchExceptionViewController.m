//
//  CatchExceptionViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "CatchExceptionViewController.h"

@interface CatchExceptionViewController ()

@end

@implementation CatchExceptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //查看某方法是否定义 若定义则执行
    if ([self respondsToSelector:@selector(catchException)]) {
        [self catchException];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//捕获异常
- (void)catchException{

    NSArray *arr =[NSArray array];

    @try {
        [arr objectAtIndex:4];
    } @catch (NSException *exception) {

        NSLog(@"错误: %@",exception);

    } @finally {

        NSLog(@"finally");
    }

}


@end
