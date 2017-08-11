//
//  OperationViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/10.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "OperationViewController.h"

#define kURL @"http://d.5857.com/yys_170425/009.jpg"

@interface OperationViewController ()

@end

/**
 使用NSOperation的两种方式。一种用定义好的两个子类NSInvocationOperation和NSBlockOperation，另一个是继承NSOperation。

 NSOperation是设计用来扩展的，只需继承重写NSOperation的一个方法main，然后把NSOperation子类的对象放入NSOperationQueue队列中，该队列就会启动并开始处理它。
 */

@implementation OperationViewController
{
    UIImageView *_imageV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageV =[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_imageV];

    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downloadImage:) object:kURL];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [queue addOperation:operation];//放进去就开始了


    [self operationBlock];
}


- (void)downloadImage:(NSString *)urlStr{
    NSURL *url =[NSURL URLWithString:urlStr];
    NSData *data =[[NSData alloc]initWithContentsOfURL:url];
    UIImage *image =[[UIImage alloc]initWithData:data];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}

- (void)updateUI:(UIImage *)image{
    _imageV.image = image;
}


//block
- (void)operationBlock{

    NSBlockOperation *blockOp =[NSBlockOperation blockOperationWithBlock:^{

        NSLog(@"block operation");
    }];

    NSOperationQueue *queue = [NSOperationQueue mainQueue];

    [queue addOperation:blockOp];
}

@end
