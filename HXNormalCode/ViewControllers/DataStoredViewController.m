//
//  DataStoredViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "DataStoredViewController.h"
#import "HXAccountItem.h"

@interface DataStoredViewController ()

@end

@implementation DataStoredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self archiveFile];

    [self unArchiveFile];

    [self archiveAccountItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 归档 文件
 */
- (void)archiveFile{
    NSArray *array = @[@"张三",@"李四",@"程飞",@"王超",@"王朝"];

    NSString *filePath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/array.plist"];
    StringLog(filePath);
    BOOL ret = [NSKeyedArchiver archiveRootObject:array toFile:filePath];

    if (ret) {
        StringLog(@"归档成功");
    }
}


/**
 解归档
 */
- (void)unArchiveFile{

    //文件路径
    NSString *filePath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/array.plist"];
    //解归档
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    for (NSString *s in array) {
        StringLog(s);
    }
}

//归档/解档 对象
- (void)archiveAccountItem{
    HXAccountItem *account =[[HXAccountItem alloc]init];
    account.user_age = @"20";
    account.user_gender = @"male";
    account.user_phoneNum = @"10030201000";
    account.user_name = @"程国强";

    NSData *accountData =[NSKeyedArchiver archivedDataWithRootObject:account];

    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/account"];
    [accountData writeToFile:filePath atomically:YES];

    NSData *acData =[[NSData alloc]initWithContentsOfFile:filePath];
    HXAccountItem *unAccount = [NSKeyedUnarchiver unarchiveObjectWithData:acData];

    StringLog(unAccount.user_name);

}


@end
