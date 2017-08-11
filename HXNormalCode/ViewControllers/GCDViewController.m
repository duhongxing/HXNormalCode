//
//  GCDViewController.m
//  Effective-ObjectiveC
//
//  Created by MacOS on 17/8/9.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "GCDViewController.h"

/**
 GCD中的FIFO队列称为dispatch queue，用来保证先进来的任务先得到执行。
 dispatch queue分三种:

 1.Serial：又叫private dispatch queues，同时只执行一个任务。Serial queue常用于同步访问特定的资源或数据。当你创建多个Serial queue时，虽然各自是同步，但serial queue之间是并发执行。(串行)
 2.Concurrent：又叫global dispatch queue，可以并发的执行多个任务，但执行完成顺序是随机的。（并行）
 3.Main dispatch queue：全局可用的serial queue，在应用程序主线程上执行任务。
 
 GCD 概要
 1.和operation queue一样都是基于队列的并发编程API，他们通过集中管理大家协同使用的线程池。
 2.公开的5个不同队列：运行在主线程中的main queue，3个不同优先级的后台队列（High Priority Queue，Default Priority Queue，Low Priority Queue），以及一个优先级更低的后台队列Background Priority Queue（用于I/O）
 3.可创建自定义队列：串行或并列队列。自定义一般放在Default Priority Queue和Main Queue里。

 */


@interface GCDViewController ()

@end

@implementation GCDViewController
{
    UIImageView *_imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageView =[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_imageView];

    [self dispatchAsync];
}


/**
 单次执行
 */
- (void)dispatchOnce{
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        NSLog(@"once invoke");
    });
}


/**
 异步执行
 */
- (void)dispatchAsync{

    /**
     可以避免界面会被一些耗时的操作卡死，比如读取网络数据，大数据IO，还有大量数据的数据库读写，这时需要在另一个线程中处理，然后通知主线程更新界面，GCD使用起来比NSThread和NSOperation方法要简单方便。
     */

    //代码框架
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
        });
    });

    //下载图片的示例
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://d.5857.com/yys_170425/009.jpg"];
        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc]initWithData:data];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image = image;
            });
        }
    });
}


/**
 延后执行
 */
- (void)dispatchAfter{

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"延迟2秒打印");
    });
}


/**
 线程队列
 */
- (void)dispatchQueue{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, queue, ^{

        NSLog(@"block1");
    });

    dispatch_group_async(group, queue, ^{

        NSLog(@"block2");
    });

    dispatch_group_async(group, queue, ^{

        NSLog(@"block3");
    });

    //barrier 障碍
    dispatch_barrier_async(queue, ^{
        NSLog(@"阻碍你一下");
    });

    dispatch_group_async(group, queue, ^{

        NSLog(@"block4");
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });

    //重复执行一个任务
    dispatch_apply(3, queue, ^(size_t index) {
        
        NSLog(@"%zu",index);
    });

}

/**
 5种队列，主队列（main queue）,四种通用调度队列，自己定制的队列。四种通用调度队列为

 QOS_CLASS_USER_INTERACTIVE：user interactive等级表示任务需要被立即执行提供好的体验，用来更新UI，响应事件等。这个等级最好保持小规模。
 QOS_CLASS_USER_INITIATED：user initiated等级表示任务由UI发起异步执行。适用场景是需要及时结果同时又可以继续交互的时候。
 QOS_CLASS_UTILITY：utility等级表示需要长时间运行的任务，伴有用户可见进度指示器。经常会用来做计算，I/O，网络，持续的数据填充等任务。这个任务节能。
 QOS_CLASS_BACKGROUND：background等级表示用户不会察觉的任务，使用它来处理预加载，或者不需要用户交互和对时间不敏感的任务。
 */

- (void)aliasDispath{

    dispatch_queue_t GlobalMainQueue = dispatch_get_main_queue();

    dispatch_queue_t GlobalUserInteractiveQueue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);

    dispatch_queue_t GlobalUserInitiatedQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);

    dispatch_queue_t GlobalUtilityQueue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);

    dispatch_queue_t GlobalBackgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);

}


- (void)GCD_Monitoring{

//    dispatch_group_enter(<#dispatch_group_t  _Nonnull group#>)
//dispatch_group_leave(<#dispatch_group_t  _Nonnull group#>)


}


@end
