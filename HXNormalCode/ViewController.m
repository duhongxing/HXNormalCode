//
//  ViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *catalogueTab;

@property (nonatomic,strong)NSMutableArray *fileNamesArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setupData];
    [self setupUI];

}

#pragma mark =========== 界面布局 ==========

/**
 初始化界面
 */
- (void)setupUI{
    [self.view addSubview:self.catalogueTab];
}

/**
 初始化数据
 */
- (void)setupData{

    [self.fileNamesArr addObject:@"SandBoxPathViewController"];//文件路径
    [self.fileNamesArr addObject:@"DataStoredViewController"];//数据存储
    [self.fileNamesArr addObject:@"DateHandleViewController"];//日期处理
    [self.fileNamesArr addObject:@"CatchExceptionViewController"];//捕获异常
    [self.fileNamesArr addObject:@"ValueHandleViewController"];//NSValue
    [self.fileNamesArr addObject:@"EncryptionViewController"];//加密
    [self.fileNamesArr addObject:@"RegularExpressionViewController"];//正则表达式
    [self.fileNamesArr addObject:@"LLDBCommandViewController"];//lldb调试命令

}

#pragma mark =========== delegate 视图代理 ======

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fileNamesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const identifier = @"normalCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.fileNamesArr[indexPath.row];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //push
    Class vcClass = NSClassFromString(self.fileNamesArr[indexPath.row]);
    UIViewController *vc = [[vcClass alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark =========== getter 属性 ==========

- (UITableView *)catalogueTab{
    if (!_catalogueTab) {
        _catalogueTab =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _catalogueTab.delegate = self;
        _catalogueTab.dataSource = self;
        _catalogueTab.tableFooterView =[UIView new];
    }
    return _catalogueTab;
}

- (NSMutableArray *)fileNamesArr{
    if (!_fileNamesArr) {
        _fileNamesArr = [[NSMutableArray alloc]init];
    }
    return _fileNamesArr;
}

@end
