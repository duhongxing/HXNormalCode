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

@property (nonatomic,strong)NSMutableArray *indexArr;
@property (nonatomic,strong)NSMutableArray *dataArray;

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

    self.catalogueTab.sectionIndexColor = [UIColor redColor];
    self.catalogueTab.sectionIndexBackgroundColor = [UIColor whiteColor];
}

/**
 初始化数据
 */
- (void)setupData{

    [self.fileNamesArr addObject:@"SandBoxPathViewController"];//文件路径
    [self.fileNamesArr addObject:@"DataStoredViewController"];//数据存储 & 数组及字典排序方法及用时
    [self.fileNamesArr addObject:@"DateHandleViewController"];//日期处理
    [self.fileNamesArr addObject:@"CatchExceptionViewController"];//捕获异常
    [self.fileNamesArr addObject:@"ValueHandleViewController"];//NSValue
    [self.fileNamesArr addObject:@"EncryptionViewController"];//加密
    [self.fileNamesArr addObject:@"RegularExpressionViewController"];//正则表达式
    [self.fileNamesArr addObject:@"LLDBCommandViewController"];//lldb调试命令
    [self.fileNamesArr addObject:@"BlockViewController"];//block操作
    [self.fileNamesArr addObject:@"RunLoopViewController"];//runloop
    [self.fileNamesArr addObject:@"ConcurrentProgrammingViewController"];//并发编程
    [self.fileNamesArr addObject:@"GCDViewController"];//grand central dispacth
    [self.fileNamesArr addObject:@"OperationViewController"];//operation
    [self.fileNamesArr addObject:@"RunTimeViewController"];//runtime

    [self setupIndexArray];
}


/**
 获取索引
 */
- (void)setupIndexArray{

    NSMutableArray *tempArr = [NSMutableArray array];
    NSMutableArray *temFiles =[NSMutableArray array];

    for (NSString *fileName in self.fileNamesArr) {
        if (![tempArr containsObject:[self catchFirstLetterWithFileName:fileName]]) {
            [tempArr addObject:[self catchFirstLetterWithFileName:fileName]];
            NSMutableArray *array =[NSMutableArray array];
            [array addObject:fileName];
            [temFiles addObject:array];
        }else{
            NSInteger index = [tempArr indexOfObject:[self catchFirstLetterWithFileName:fileName]];
            [temFiles[index] addObject:fileName];
        }
    }

    [tempArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];

    [temFiles sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [self catchFirstLetterWithFileName: obj1[0]] > [self catchFirstLetterWithFileName: obj2[0]];
    }];

    [self.dataArray addObjectsFromArray:temFiles];
    [self.indexArr addObjectsFromArray:tempArr];
}

#pragma mark =========== private method =======

- (NSString *)catchFirstLetterWithFileName:(NSString *)fileName{
    return [fileName substringWithRange:NSMakeRange(0, 1)];
}

#pragma mark =========== delegate 视图代理 ======

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.indexArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const identifier = @"normalCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

//索引
- (NSArray<NSString *>*)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.indexArr;
}

//头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return self.indexArr[section];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //push
    Class vcClass = NSClassFromString(self.dataArray[indexPath.section][indexPath.row]);
    UIViewController *vc = [[vcClass alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark =========== getter 属性 ==========

//目录列表
- (UITableView *)catalogueTab{
    if (!_catalogueTab) {
        _catalogueTab =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _catalogueTab.delegate = self;
        _catalogueTab.dataSource = self;
        _catalogueTab.tableFooterView =[UIView new];
    }
    return _catalogueTab;
}


/**
 初始化文件数组

 @return <#return value description#>
 */
- (NSMutableArray *)fileNamesArr{
    if (!_fileNamesArr) {
        _fileNamesArr = [[NSMutableArray alloc]init];
    }
    return _fileNamesArr;
}


/**
 索引数组

 @return <#return value description#>
 */
- (NSMutableArray *)indexArr{
    if (!_indexArr) {
        _indexArr = [[NSMutableArray alloc]init];
    }
    return _indexArr;
}


/**
 列表数据

 @return <#return value description#>
 */
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
