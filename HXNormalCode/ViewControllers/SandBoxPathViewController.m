//
//  SandBoxPathViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/7/28.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

/**
 Documents 目录：用于存储用户数据或其他应该定期备份的信息 
 AppName.app 目录：它是应用程序的程序包目录 包含应用程序本身
 Library 目录: 有两个子目录(Caches 和 Preferences)  
            { 
              1.Preferences目录:包含应用程序的偏好设置文件 使用NSUserDefaults类取得和设置应用程序的偏好
              2.Caches 目录：用于存放应用程序专用的支持文件 保存应用程序再次启动过程中需要的信息
            }
 tmp目录:用于存放临时文件，保存应用程序再次启动过程中不需要的信息
 
 */

#import "SandBoxPathViewController.h"
#import "HXFileHandleManager.h"
@interface SandBoxPathViewController ()

@property (nonatomic,strong)UITextView *inforText;

@end

@implementation SandBoxPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.inforText];

    [self getDirectoryPaths];

    [self filePathHandle];

    [self fieleManagerHandle];

    [self fileHandleManagerTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ======== 获取目录路径的方法 =====

/**
 获取目录路径
 */
- (void)getDirectoryPaths{

    NSMutableString *string = [NSMutableString string];

    //HomeDirectory
    NSString *homeDirectory = NSHomeDirectory();
    StringLog(homeDirectory);

    //DocumentDirectory
    NSString *documentDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    StringLog(documentDirectory);

    //CachesDirectory
    NSString *cachesDirectory =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    StringLog(cachesDirectory);

    //tempDirectory
    NSString *tempDirectory = NSTemporaryDirectory();
    StringLog(tempDirectory);

    //获取应用程序包中资源文件路径的方法
    NSString *ImgPath =[[NSBundle mainBundle]pathForResource:@"iOS 开发" ofType:@"jpg"];
    StringLog(ImgPath);

    [string appendFormat:@"homeDirectory:\n%@\n\n documentDirectory:\n%@\n\n cachesDirectory:\n%@\n\n tempDirectory:\n%@\n\n ImgPath:\n%@\n\n",homeDirectory,documentDirectory,cachesDirectory,tempDirectory,ImgPath];

    self.inforText.text = string;
}


/**
 文件路径操作
 */
- (void)filePathHandle{
    //实例
    NSString *fielPath = @"/Users/macos/Library/Developer/CoreSimulator/Devices/C11A06D1-3BF8-4A48-AB43-2729E9B7E161/data/Containers/Bundle/Application/D10F4358-C819-4CE0-A490-191585410D0D/HXNormalCode.app/iOS 开发.jpg";
    //返回路径组成
    NSArray *array =[fielPath pathComponents];
    StringLog(array);
    //路径最后的部分
    NSString *lastComponent =[[fielPath pathComponents]lastObject];
    StringLog(lastComponent);

    //追加路径
    //自己添加“/”
//    NSString *newPath = [fielPath stringByAppendingString:@"/appleFile.text"];
    //自动添加"/"
//    NSString *newPath =[fielPath stringByAppendingPathComponent:@"appFile.text"];

    //删除最后的组成部分
    NSString *deleteLastPath =[fielPath stringByDeletingLastPathComponent];
    StringLog(deleteLastPath);

    //删除扩展名
    NSString *deleteExtenstion =[fielPath stringByDeletingPathExtension];
    StringLog(deleteExtenstion);

    //获取最后部分的扩展名
    NSString *appendExtenstion =[fielPath pathExtension];
    StringLog(appendExtenstion);

    //追加扩展名
    NSString *appendExt =[fielPath stringByAppendingPathExtension:@"jpg"];
    StringLog(appendExt);

}


/**
 文件管理操作
 */
- (void)fieleManagerHandle{

    //源文件路径
    NSString *srcPath =[NSHomeDirectory() stringByAppendingPathComponent:@"iOS 开发.txt"];
    StringLog(srcPath);

    //目标文件路径
    NSString *targetPath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/iOS 开发.txt"];
    StringLog(targetPath);

    //注意:使用NSFileHandle 只能读写已经存在的文件 不能创建文件；使用NSFileManager创建文件
    NSFileManager *fileManager =[NSFileManager defaultManager];

    //创建目标文件
    BOOL ret = [fileManager createFileAtPath:targetPath contents:nil attributes:nil];

    if (ret) {
        NSLog(@"目标文件创建成功");
    }

    //创建读取文件的FileHandle对象
    NSFileHandle *readHandle =[NSFileHandle fileHandleForReadingAtPath:srcPath];

    //创建用于写入的FileHandle对象
    NSFileHandle *writeHandle =[NSFileHandle fileHandleForWritingAtPath:targetPath];

    //从当前偏移量读到文件的末尾 偏移量默认是起始位置
    //    NSData *data =[readHandle readDataToEndOfFile];
    //    NSData *data = [readHandle availableData];

    NSString *testString = @"我将要写入文件";
    NSData *textData = [testString dataUsingEncoding:NSUTF8StringEncoding];

    //写入文件
    [writeHandle writeData:textData];


//    NSError *error;

    //判断文件是否移动成功
//    BOOL result =[fileManager moveItemAtPath:srcPath toPath:targetPath error:&error];

    //判断文件是否复制成功
//    BOOL result = [fileManager copyItemAtPath:srcPath toPath:targetPath error:&error];

    //判断文件是否存在
    //    BOOL fileExist = [fileManager fileExistsAtPath:srcPath];

    //判断目录是否存在
//    BOOL isDir;
//    [fileManager fileExistsAtPath:srcPath isDirectory:&isDir];

    //删除文件
//    [fileManager removeItemAtPath:srcPath error:&error];

    //判断文件是否可读、可写、可删除
//    [fileManager isWritableFileAtPath:srcPath];
//    [fileManager isReadableFileAtPath:srcPath];
//    [fileManager isDeletableFileAtPath:srcPath];


//    if (result) {
//        NSLog(@"移动成功");
//    }else{
//        NSLog(@"移动失败%@",error);
//    }

    //关闭文件
    [writeHandle closeFile];

    //关闭文件
    [readHandle closeFile];



    //获取文件的路径
    NSString *file =[[NSBundle mainBundle]pathForResource:@"iOS 开发" ofType:@"jpg"];
    StringLog(file);

    //获取文件的属性信息
    NSDictionary *fileAttr =[fileManager attributesOfItemAtPath:file error:nil];
    StringLog(fileAttr);
//    NSFileCreationDate = "2017-07-28 02:55:32 +0000";
//    NSFileExtensionHidden = 0;
//    NSFileGroupOwnerAccountID = 20;
//    NSFileGroupOwnerAccountName = staff;
//    NSFileModificationDate = "2017-07-28 02:55:32 +0000";
//    NSFileOwnerAccountID = 501;
//    NSFilePosixPermissions = 420;
//    NSFileReferenceCount = 1;
//    NSFileSize = 645945;
//    NSFileSystemFileNumber = 55064820;
//    NSFileSystemNumber = 16777220;
//    NSFileType = NSFileTypeRegular;

    //从字典中通过key：NSFileSize 获取文件大小
    NSNumber *fileSize =[fileAttr objectForKey:NSFileSize];
    long long sizeValue = [fileSize longLongValue];
    NSLog(@"文件大小:%lldKB",sizeValue/1024);
}


#pragma mark ======= FileHandleManager 测试 =======

//文件操作管理测试
- (void)fileHandleManagerTest{

    HXFileHandleManager *manager =[HXFileHandleManager shareInstance];

    NSString *completeFilePath = [manager completeFilePathWithSearchDirectoryPath:NSDocumentDirectory FileName:@"皈依佛" Extension:@"text"];
    StringLog(completeFilePath);

    NSString *imgPath =[manager filePathFromBundleWithFileName:@"iOS 开发" fileType:@"jpg"];
    StringLog(imgPath);
    NSLog(@"%lld",[manager fileSizeAtFilePath:imgPath]/1024);

    NSString *directory = [manager fileDiectoryDomainWithSearchDirectoryPath:NSDocumentDirectory];

    NSLog(@"%@",[manager filesPathFromDirectory:directory]);


}


#pragma mark ======= getter 属性 ========

- (UITextView *)inforText{
    if (_inforText == nil) {
        _inforText =[[UITextView alloc]initWithFrame:self.view.bounds];
        _inforText.editable = NO;
        _inforText.font = [UIFont boldSystemFontOfSize:18];
        _inforText.textColor =[UIColor blueColor];
    }
    return _inforText;
}

@end
