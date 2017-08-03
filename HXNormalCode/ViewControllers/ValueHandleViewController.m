//
//  ValueHandleViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

struct HXPoint {
    float x;
    float y;
};

#import "ValueHandleViewController.h"

@interface ValueHandleViewController ()

@end


@implementation ValueHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self valueHandle];

    [self simpleKnowledge];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 NSValue 操作
 */
- (void)valueHandle{

    //封包
//    NSRange range = {10,5};
//    NSValue *rangeValue =[NSValue valueWithRange:range];
//    NSValue *pointValue =[NSValue valueWithCGPoint:CGPointMake(0, 0)];

    //自定义的结构体包装成NSValue对象
    struct HXPoint point = {50,100};
    NSValue *pointValue = [NSValue value:&point withObjCType:@encode(struct HXPoint)];

    //解包结构体
    struct HXPoint p0;
    [pointValue getValue:&p0];
    NSLog(@"x=%f,y=%f",p0.x,p0.y);

    NSNull *null1 =[NSNull null];
    NSNull *null2 =[NSNull null];
    NSArray *arrayNull = @[null1,null2];
    NSLog(@"%@",arrayNull);

    for (id item in arrayNull) {
        //判断数组中的对象是否为一个NSNull对象，如果是，则过滤掉
        if (item == [NSNull null]) {
            NSLog(@"--- null ---");
            continue;
        }
    }

    [self compareStr1:@"A" Str2:@"B"];
}

//创建NSNumber（包装基本数据类型）
- (void)numberHandle{
    NSNumber *intNum =[NSNumber numberWithInt:180];
    NSNumber *floatNum =[NSNumber numberWithFloat:2.95f];
    NSNumber *longNum =[NSNumber numberWithLong:145677766666];
    NSNumber *boolNum =[NSNumber numberWithBool:YES];
    NSArray *array = @[intNum,floatNum,longNum,boolNum];

    int intValue =[intNum intValue];
    float floatValue =[floatNum floatValue];

    NSNumber *intNumber = @100;
    NSNumber *charVaule = @'a';

    NSArray *array1 = @[@(intValue),@(floatValue),intNumber,charVaule];

    NSLog(@"%@ %@",array,array1);

}

//字符串比较
- (void)compareStr1:(NSString *)str1 Str2:(NSString *)str2{
    NSComparisonResult result = [str1 compare:str2];

    if (result == NSOrderedAscending) {
        NSLog(@"%@ < %@",str1,str2);
    }else if (result == NSOrderedSame){
        NSLog(@"%@ == %@",str1,str2);
    }else if (result == NSOrderedDescending){
        NSLog(@"%@ > %@",str1,str2);
    }
}

- (void)simpleKnowledge{
    int randomNum = arc4random_uniform(10);
    NSLog(@"生成随机数:%d",randomNum);
}

- (NSString *)replaceXMLSensitiveLettler:(NSString *)text{
    NSString *tmp =[text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    tmp = [tmp stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    tmp = [tmp stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    return tmp;
}

@end
