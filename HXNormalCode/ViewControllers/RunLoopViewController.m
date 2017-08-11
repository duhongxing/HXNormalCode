//
//  RunLoopViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/9.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@property (nonatomic,strong)UIImageView *avatarImageView;

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 系统级：GCD，mach kernel，block，pthread
 应用层：NSTimer，UIEvent，Autorelease，NSObject(NSDelayedPerforming)，NSObject(NSThreadPerformAddition)，CADisplayLink，CATransition，CAAnimation，dispatch_get_main_queue()（GCD中dispatch到main queue的block会被dispatch到main RunLoop执行），NSPort，NSURLConnection，AFNetworking(这个第三方网络请求框架使用在开启新线程中添加自己的run loop监听事件)

 堆栈最底层是start(dyld)，往上依次是main，UIApplication(main.m) -> GSEventRunModal(Graphic Services) -> RunLoop(包含CFRunLoopRunSpecific，__CFRunLoopRun，__CFRunLoopDoSouces0，CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION) -> Handle Touch Event
 
 执行顺序的伪代码

 SetupThisRunLoopRunTimeoutTimer(); // by GCD timer
 do {
 __CFRunLoopDoObservers(kCFRunLoopBeforeTimers);
 __CFRunLoopDoObservers(kCFRunLoopBeforeSources);

 __CFRunLoopDoBlocks();
 __CFRunLoopDoSource0();

 CheckIfExistMessagesInMainDispatchQueue(); // GCD

 __CFRunLoopDoObservers(kCFRunLoopBeforeWaiting);
 var wakeUpPort = SleepAndWaitForWakingUpPorts();
 // mach_msg_trap
 // Zzz...
 // Received mach_msg, wake up
 __CFRunLoopDoObservers(kCFRunLoopAfterWaiting);
 // Handle msgs
 if (wakeUpPort == timerPort) {
 __CFRunLoopDoTimers();
 } else if (wakeUpPort == mainDispatchQueuePort) {
 // GCD
 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__()
 } else {
 __CFRunLoopDoSource1();
 }
 __CFRunLoopDoBlocks();
 } while (!stop && !timeout);

 */

#pragma mark - runloop

//Thread包含一个CFRunLoop，一个CFRunLoop包含一种CFRunLoopMode，mode包含CFRunLoopSource，CFRunLoopTimer和CFRunLoopObserver。
//    NSDefaultRunLoopMode：默认，空闲状态
//    UITrackingRunLoopMode：ScrollView滑动时
//    UIInitializationRunLoopMode：启动时
//    NSRunLoopCommonModes：Mode集合 Timer计时会被scrollView的滑动影响的问题可以通过将timer添加到NSRunLoopCommonModes来解决

- (void)runloopComponent{
    UIImage *downloadImage;
    [self.avatarImageView performSelector:@selector(setImage:) withObject:downloadImage afterDelay:0 inModes:@[NSDefaultRunLoopMode]];

}


@end
