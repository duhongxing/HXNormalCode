//
//  RunTimeViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/11.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "RunTimeViewController.h"
#import <objc/message.h>
/**
 runtime 的作用:

 - 发送消息  方法调用的本质，就是让对象发送消息
 - objc_msgSend只有对象才能发送消息,因此以objc开头

 - 使用消息机制的前提,必须导入头文件#import<objc/message.h>

 - 消息机制的简单使用
 - clang -rewrite-objc main.m 查看最终生成代码
 
 id objc = [NSObject alloc];  ------>    objc_msgSend(objc_getClass("NSObject"), sel_registerName("alloc"));

 objc =[objc init];  ------>  objc_msgSend(objc,sel_registerName("init"));

 id:发送消息的对象
 SEL:发送的什么消息
 
 解决方法提示问题:

 - 导入头文件#import<objc/message.h>
 - Build setting  ---> 搜索 msg    设为NO
 
 Runtime(交换方法)
 + (void)load{
 Method imagedNameMethod = class_getClassMethod(self, @selector(imageNamed:));

 Method btsjImagedNameMethod = class_getClassMethod(self, @selector(btsj_imageNamed:));

 //方法交互
 method_exchangeImplementations(imagedNameMethod, btsjImagedNameMethod);

 }

 +(UIImage *)btsj_imageNamed:(NSString *)imageName{

 UIImage *image =[UIImage btsj_imageNamed:imageName];

 if (image == nil) {
 NSLog(@"图片加载失败");
 }else{
 NSLog(@"图片加载成功");
 }
 return image;
 }

 动态添加方
 /没有返回值 也没有参数
 void add(id self,SEL _cmd){

 NSLog(@"动态添加方法");
 }

 //任何方法默认都有两个参数self,_cmd _cmd当前方法编号

 //什么时候调用:只要一个对象调用了一个未实现的方法就会调用这个方法 进行处理。

 //动态添加方法,处理为实现

 + (BOOL)resolveInstanceMethod:(SEL)sel{
 if (sel == NSSelectorFromString(@"addMethod")) {
 //addMethod
 //class:给哪个类添加方法
 //SEL:添加哪个方法
 //IMP: 方法实现
 //type:
 class_addMethod(self, sel, (IMP)add,"v@:");
 return YES;
 }

 return [super resolveInstanceMethod:sel];

 }

 */

@interface RunTimeViewController ()

@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self creatObj];

    [self exchangeMethod];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 使用消息机制创建对象
 */
- (void)creatObj{

    id objc = objc_msgSend(objc_getClass("NSString"), sel_registerName("alloc"));
    objc = objc_msgSend(objc, sel_registerName("init"));
    NSLog(@"%@",NSStringFromClass([objc class]));

}

/**
 交换方法
 */
- (void)exchangeMethod{
    Method method = class_getInstanceMethod([self class], @selector(method1));
    Method method2 = class_getInstanceMethod([self class], @selector(method2));
    method_exchangeImplementations(method, method2);

    [self method1];
    [self method2];
}

- (void)method1{
    NSLog(@"%s,method1",__func__);
}

- (void)method2{

    NSLog(@"%s,method2",__func__);
}


@end
