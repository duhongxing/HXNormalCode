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
{
    UILabel * _testResult;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupLab];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 界面布局 -

- (void)setupLab{

    [self archiveFile];
    [self unArchiveFile];
    [self archiveAccountItem];

    _testResult =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, self.view.bounds.size.height - 20)];
    [self.view addSubview:_testResult];
    _testResult.numberOfLines = 0;
    _testResult.textAlignment = NSTextAlignmentCenter;

    [self arraySortHandle];
    [self dictionarySortHandle];
}


#pragma mark - private method -

/**
 归档 文件
 */
- (void)archiveFile{
    NSArray *array = @[@"张三",@"李四",@"程飞",@"王超",@"王朝"];

    NSString *filePath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/array.plist"];
    StringLog(@"%@",filePath);
    BOOL ret = [NSKeyedArchiver archiveRootObject:array toFile:filePath];

    if (ret) {
        StringLog(@"%@",@"归档成功");
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
    NSLog(@"%@",array);

//    for (NSString *s in array) {
//        StringLog(s);
//    }
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

    StringLog(@"%@",unAccount.user_name);

}

#pragma mark - 基础集合类 NSArray和NSDictionary性能、排序、枚举

/**
 数组排序处理
 */
- (void)arraySortHandle{

    NSArray *array = @[@"John",@"Bim Cool",@"Army",@"Err",@"Solo"];

    //逆序
    NSArray *reversResultArr = [array reverseObjectEnumerator].allObjects;
    NSLog(@"%@",reversResultArr);

    NSArray *sortArray = [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSLog(@"%@",sortArray);

    //存储内容是数字
    NSArray *numbers = @[@9,@5,@11,@3,@20];
    NSArray *sortedNumbers = [numbers sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@",sortedNumbers);


    NSArray *resultArr =  [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        return  obj1 < obj2;

    }];

//    [numbers sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//
//    }];

    NSLog(@"%@",resultArr);

//     indexOfObject:<#(nonnull id)#> inSortedRange:<#(NSRange)#> options:<#(NSBinarySearchingOptions)#> usingComparator:<#^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)cmp#>

    NSIndexSet *indexes = [numbers indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [self isBiggerThanNine:obj];
    }];

    NSLog(@"%@",indexes);

    NSArray *retArr = [numbers objectsAtIndexes:indexes];
    NSLog(@"%@",retArr);


    //传统枚举
    NSMutableArray *mutableArray =[NSMutableArray array];
    for (id obj in numbers) {
        if ([self isBiggerThanNine:obj]) {
            [mutableArray addObject:obj];
        }
    }

    //block枚举
    NSMutableArray *blockArray =[NSMutableArray array];
    [numbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isBiggerThanNine:obj]) {
            [blockArray addObject:obj];
        }
    }];

    //通过下标
    NSMutableArray *indexArray =[NSMutableArray array];
    for (NSInteger idx = 0; idx <numbers.count; idx++) {
        id obj = numbers[idx];
        if ([self isBiggerThanNine:obj]) {
            [indexArray addObject:obj];
        }
    }

    //学院派
    NSMutableArray *enumeratorArray =[NSMutableArray array];
    NSEnumerator *enumerator = [numbers objectEnumerator];
    id obj = nil;
    while ((obj = [enumerator nextObject]) != nil) {
        if ([self isBiggerThanNine:obj]) {
            [enumeratorArray addObject:obj];
        }
    }

//    使用predicate
    NSArray *reArray =[numbers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {

        return isBiggerThanSix(evaluatedObject);
    }]];

    NSLog(@"predicate:%@",reArray);

//    各个方法枚举时间参考，indexesOfObjectsWithOptions在开启了并发枚举的情况下比NSFastEnumeration快一倍。
    /**
     枚举方法 / 时间 [ms]	10.000.000 elements	10.000 elements
     indexesOfObjects:, concurrent	1844.73	2.25
     NSFastEnumeration (for in)	3223.45	3.21
     indexesOfObjects:	4221.23	3.36
     enumerateObjectsUsingBlock:	5459.43	5.43
     objectAtIndex:	5282.67	5.53
     NSEnumerator	5566.92	5.75
     filteredArrayUsingPredicate:	6466.95	6.31

     */

}

- (BOOL)isBiggerThanNine:(id)obj{
    if ([obj integerValue] > 9) {
        return YES;
    }else{
        return NO;
    }
}

bool isBiggerThanSix(id obj){

    if ([obj integerValue] > 6) {
        return YES;
    }else{
        return NO;
    }
}


/**
 字典排序处理
 */
- (void)dictionarySortHandle{

    NSDictionary *testDic = @{@"doca":@"te1",
                              @"loca":@"te2",
                              @"coca":@"te3",
                              @"eoca":@"te4",
                              @"aoca":@"te5"};
    //枚举 keysOfEntriesWithOptions:passingTest: 可并行
    NSSet *alkeys = [testDic keysOfEntriesPassingTest:^BOOL(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        return YES;
    }];
    NSArray *keys = alkeys.allObjects;
    NSLog(@"%@",keys);
    NSArray *values = [testDic objectsForKeys:keys notFoundMarker:NSNull.null];

    __unused NSDictionary *filteredDictionary =[NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSLog(@"%@",filteredDictionary);


    NSMutableDictionary *mutableDictionary =[NSMutableDictionary dictionary];
    id __unsafe_unretained objects[5];
    id __unsafe_unretained lkeys[5];
    [testDic getObjects:objects andKeys:lkeys];

    for (int i = 0; i < 5; i++) {
        id obj = objects[i];
        id key = lkeys[i];
        NSLog(@"obj:%@ ,key:%@",obj,key);
    }

    //block枚举
    [testDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key%@  obj%@",key,obj);
    }];

    //fast enumerate
    for (id key in testDic) {
        id obj = testDic[key];
        NSLog(@"%@ %@",obj,key);
    }

    //NSEnumeration
    NSEnumerator *enumerator =[testDic keyEnumerator];
    id key = nil;
    while ((key = [enumerator nextObject]) != nil) {
        id obj = testDic[key];
        NSLog(@"%@ %@",obj,key);
    }

    /**
     各个方法枚举时间参考
     枚举方法 / 时间 [ms]	50.000 elements	1.000.000 elements
     keysOfEntriesWithOptions:, concurrent	16.65	425.24
     getObjects:andKeys:	30.33	798.49
     keysOfEntriesWithOptions:	30.59	856.93
     enumerateKeysAndObjectsUsingBlock:	36.33	882.93
     NSFastEnumeration	41.20	1043.42
     NSEnumeration	42.21	1113.08
     */

}


@end
