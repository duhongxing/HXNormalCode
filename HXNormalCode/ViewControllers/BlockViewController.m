//
//  BlockViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/9.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@property (nonatomic,strong)NSOperationQueue *queue;
@property (nonatomic, copy) void (^completionHandler)();
@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self blockHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 block 操作
 */
- (void)blockHandle{
    [self createBlock];
    [self closuer];
    [self changeLocalVariable];

    [self sumWithA:10 :15 resultBlock:^(int sum) {
        NSLog(@"%d",sum);
    }];
}

#pragma mark - block handle

- (void)createBlock{

    //有参数的 有返回值的 block
    int (^SumBlock)(int a,int b);

    SumBlock = ^int(int a, int b){
        return a + b;
    };

    int sum = SumBlock(5,6);
    NSLog(@"求和:%d",sum);

}

//闭包
- (void)closuer{
    //block的闭包 closure block内部可以访问定义在block外部的非局部变量。非局部变量会以拷贝形式存储到block中。
    NSString *make = @"Honda";
    NSString *(^getFullCarName)(NSString *) = ^(NSString *model){
        return [make stringByAppendingString:model];
    };
    NSLog(@"%@",getFullCarName(@"Wang"));
    make = @"Seaser";
    NSLog(@"%@",getFullCarName(@" Car"));
}

//修改局部变量
- (void)changeLocalVariable{
    __block int i = 0;
    int (^count)(void)= ^{
        i += 1;
        return i;
    };

    NSLog(@"%d",count());
    NSLog(@"%d",count());
    NSLog(@"%d",count());
}

//block 作为函数的参数
- (void)sumWithA:(int)A :(int)B resultBlock:(void(^)(int sum))result{
    result(A + B);
}

//定义block 类型
typedef double (^SpeedFunction)(double);

//风险
//block会存在导致retain cycles的风险，如果发送者需要 retain block 但又不能确保引用在什么时候被赋值为 nil， 那么所有在 block 内对 self 的引用就会发生潜在的 retain 环。NSOperation 是使用 block 的一个好范例。因为它在一定的地方打破了 retain 环，解决了上述的问题。 使用弱引用解决问题;

@end
