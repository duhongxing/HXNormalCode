//
//  DateHandleViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "DateHandleViewController.h"

@interface DateHandleViewController ()

@end

@implementation DateHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self dateHandle];

    [self dateFormatter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====   日期 操作     ========

- (void)dateHandle{

    //获取昨天、今天、明天的日期
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow: -(60 *60 *24)];
    StringLog(@"%@",yesterdayDate);

    NSDate *currentDate = [NSDate date];
    StringLog(@"%@",currentDate);

    NSDate *tommorwDate =[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24];
    StringLog(@"%@",tommorwDate);

    //获取在1970年加上一个时间戳后的日期
    NSDate *date1970 =[NSDate dateWithTimeIntervalSince1970:0];
    StringLog(@"%@",date1970);

    //获取某个日期的时间戳
//    NSTimeInterval someDateTiemStamp = [currentDate timeIntervalSince1970];

    //获取两个日期间的间隔
    NSTimeInterval timeInterval =[yesterdayDate timeIntervalSinceDate:tommorwDate];
    NSLog(@"%f",timeInterval);
}


/**
 日期比较

 @param date1 日期1
 @param date2 日期2
 @return 比较结果
 */
- (NSString *)dateCompareWithDate1:(NSDate *)date1 Date2:(NSDate *)date2{
    NSString *result;

    //时间戳比较
//    if ([date1 timeIntervalSince1970] > [date2 timeIntervalSince1970]) {
//        result = @"date1 > date2";
//    }else if ([date1 timeIntervalSince1970] < [date2 timeIntervalSince1970]){
//       result = @"date1 < date2";
//    }else{
//        result = @"date1 = date2";
//    }

    NSComparisonResult ret = [date1 compare:date2];
    if (ret == NSOrderedAscending) {
        result = @"date1 < date2";
    }else if (ret == NSOrderedDescending){
        result = @"date1 > date2";
    }else{
        result = @"date1 = date2";
    }
    return result;
}


/**
 获取两个日期的时间间隔

 @param date1 日期1
 @param date2 日期2
 @return 时间间隔
 */
- (NSTimeInterval)timeIntervalWithDate1:(NSDate *)date1 Date2:(NSDate *)date2{
    NSTimeInterval timeInterval = [date1 timeIntervalSinceDate:date2];
    return timeInterval;
}

#pragma mark =============   格式化日期  ==============

- (void)dateFormatter{

//    StringLog([self getTimeZoneArray]);

}

//日期 转 字符串
- (NSString *)dateStringFromeDate:(NSDate *)date{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日HH:mm:ss";
    NSTimeZone *zone =[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    dateFormatter.timeZone = zone;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

//字符串 转 日期
- (NSDate *)dateFromeDateString:(NSString *)dateString{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy年MM月dd日HH:mm:ss";
    NSTimeZone *zone =[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    dateFormatter.timeZone = zone;
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

//获取所有时区名称
- (NSArray *)getTimeZoneArray{
    return [NSTimeZone knownTimeZoneNames];
}

@end
