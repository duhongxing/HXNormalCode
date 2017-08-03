//
//  LLDBCommandViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/3.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "LLDBCommandViewController.h"

@interface LLDBCommandViewController ()

@end

@implementation LLDBCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self lldbNormalCommand];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//lldb 常用 命令
- (void)lldbNormalCommand{
    //缩略命令 l -> "list";  b -> "breakpoint"; p -> "print".

    /**
     1.list 列出程序的源代码，默认每次显示10行
     list + 行号：将当前文件从“行号”的开始10行代码；eg:list 12
     list + 函数名：将显示“函数名”为中心的前后10行代码；eg:list main
     list ：不带参数，将接着上一次list命令的 输出下面的内容
     
     2.设置断点 
     b n:在第n行处设置断点
     b func:在函数func的入口处设置断点
     breakpoint list -f：查看所有断点信息
     breakpoint delete 断点号n:删除第n个断点
     breakpoint disable 断点号n:暂停第n个断点
     breakpoint enable 断点号n:开启第n个断点
     
     3.运行程序
     r -> "run"

     4.打印变量值
     print a:将显示整数a的值
     print ++a:将把a中的值加1,并显示出来
     print name:将显示字符串name的值
     print Lldb_test(22):将以整数22作为参数调用Lldb_test()函数
     print Lldb_test(a):将以变量a作为参数调用Lldb_test()函数
     
     5.单步运行
     next (n)/step(s)
     
     6.恢复程序运行
     continuing (c)
     
     7.display m 查看表达式的值
     
     8.查看栈的信息
     backtrace -> "bt"
     打印当前函数调用栈的所有信息
     frame info ：查看当前栈桢的信息
     frame select：栈桢序号 选择栈桢
     frame variable ：查看当前栈桢的局部变量
     
     9.输出格式
     x 按十六进制格式显示变量
     d 按十进制显示变量
     u 按十六进制无符号显示
     o 按八进制显示变量
     t 按二进制显示变量
     a 按十六进制格式显示变量
     c 按字符格式显示
     f 按浮点数格式显示变量
     
     10 查看内存
     examine -> x 
     x/<n/f/u><addr>

     n/f/u 可选参数 
     n:一个正整数 表示显示内存的长度
     f:表示显示的格式
     u:表示从当前地址往后请求的字节数
     
     <addr> 表示一个内存地址
     
     11.其他命令
     finish 运行程序，直到当前函数完成返回 并打印函数返回时的堆栈地址和返回值及参数值等信息

     */
    

}


@end
