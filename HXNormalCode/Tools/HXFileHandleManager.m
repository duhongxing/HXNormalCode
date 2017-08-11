//
//  HXFileHandleManager.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/7.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "HXFileHandleManager.h"

#define FILEMANAGER [NSFileManager defaultManager]

@implementation HXFileHandleManager

+ (HXFileHandleManager *)shareInstance{
    static HXFileHandleManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[HXFileHandleManager alloc]init];
        }
    });
    return manager;
}

#pragma mark
#pragma mark - 文件路径

- (NSString *)homeDirectory{
    return NSHomeDirectory();
}

- (NSString *)tempDirectory{
    return NSTemporaryDirectory();
}

- (NSString *)fileDiectoryDomainWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(pathDirectory, NSUserDomainMask, YES)lastObject];
    return directory;
}


- (void)createDirectoryWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory DirName:(NSString *)dirName{
    NSString *directory = [[self fileDiectoryDomainWithSearchDirectoryPath:pathDirectory]stringByAppendingPathComponent:dirName];
    BOOL ret = [FILEMANAGER createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    if (ret) {
        NSLog(@"creat success %@",directory);
    }else{
        NSLog(@"creat fail");
    }
}

- (NSString *)filePathWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory FileName:(NSString *)fileName{
    NSString *filePath = [[self fileDiectoryDomainWithSearchDirectoryPath:pathDirectory] stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *)completeFilePathWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory FileName:(NSString *)fileName Extension:(NSString *)extension{
    NSString *completeFilePath = [[self filePathWithSearchDirectoryPath:pathDirectory FileName:fileName] stringByAppendingPathExtension:extension];
    return completeFilePath;
}

- (NSArray *)pathComponentsWithPath:(NSString *)filePath{
    return [filePath pathComponents];
}

- (NSString *)filePathFromBundleWithFileName:(NSString *)fileName fileType:(NSString *)fileType{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:fileType];
    return filePath;
}

- (void)deleteFilePathLastCompent:(NSString *)filePath{
    [filePath stringByDeletingLastPathComponent];
}

- (void)deleteExtension:(NSString *)filePath{
    [filePath stringByDeletingPathExtension];
}


- (NSString *)getFileExtension:(NSString *)filePath{

    return [filePath pathExtension];
}

- (NSString *)appendExtension:(NSString *)filePath Extension:(NSString *)extension{

    return [filePath stringByAppendingPathExtension:extension];
}

#pragma mark
#pragma mark - 文件操作

- (BOOL)creatFileWithFilePath:(NSString *)filePath{

    BOOL ret = [FILEMANAGER createFileAtPath:filePath contents:nil attributes:nil];

    if (ret) {
        NSLog(@"文件创建成功");
    }else{
        NSLog(@"文件创建失败");
    }

    return ret;
}

- (void)writeToFileWithFilePath:(NSString *)filePath :(NSString *)content{
    if ([FILEMANAGER isWritableFileAtPath:filePath]) {
      BOOL ret =  [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];

        if (ret) {
            NSLog(@"write success");
        }else{
            NSLog(@"write fail");
        }
    }
}

- (NSString *)readFileContentWithFilePath:(NSString *)filePath{
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return content;
}


- (NSArray *)fileNamesFromDirectory:(NSString *)fileDirectory{
    NSArray *filesArr = nil;
    BOOL isDir;
    [FILEMANAGER fileExistsAtPath:fileDirectory isDirectory:&isDir];
    if (isDir) {
        filesArr = [FILEMANAGER subpathsAtPath:fileDirectory];
        NSLog(@"文件夹存在");
    }else{
        NSLog(@"文件夹不存在");
    }
    return filesArr;
}

- (unsigned long long)fileSizeAtFilePath:(NSString *)filePath{
    if ([FILEMANAGER fileExistsAtPath:filePath]) {
       unsigned long long fileSize = [FILEMANAGER attributesOfItemAtPath:filePath error:nil].fileSize;
        NSLog(@"文件存在");
        return fileSize;
    }else{
        NSLog(@"文件不存在");
        return 0;
    }
}

- (unsigned long long)folderSizeAtDirectory:(NSString *)directory{
    BOOL isDir;
    [FILEMANAGER fileExistsAtPath:directory isDirectory:&isDir];
    if (isDir) {

        NSEnumerator *childFileEnumerator =[[FILEMANAGER subpathsAtPath:directory]objectEnumerator];
        unsigned long long foldSize = 0;
        NSString *fileName;
        while ((fileName = [childFileEnumerator nextObject]) != nil) {
            NSString *fileAbsolutePath = [directory stringByAppendingPathComponent:fileName];
            foldSize += [self fileSizeAtFilePath:fileAbsolutePath];
        }
        return foldSize/(1024.0 * 1024);

    }else{
        NSLog(@"dir is not exist");
        return 0;
    }
}

- (BOOL)removeFileFromFilePath:(NSString *)filePath{
    BOOL ret;
    if ([FILEMANAGER fileExistsAtPath:filePath]) {
        ret = [FILEMANAGER removeItemAtPath:filePath error:nil];
        NSLog(@"delete success");
        return  ret;
    }else{
        NSLog(@"文件不存在");
        return NO;
    }
}

- (BOOL)moveFileFromPath1:(NSString *)path1 toPath2:(NSString *)path2{
    BOOL ret = [FILEMANAGER moveItemAtPath:path1 toPath:path2 error:nil];
    if (ret) {
        NSLog(@"move success");
    }else{
        NSLog(@"move fail");
    }
    return ret;
}

- (BOOL)reFileNameFromFileName1:(NSString *)fileName1 toFileName2:(NSString *)fileName2 SearchDirectoryPath:(NSSearchPathDirectory)pathDirrctory{

    NSString *fileName1Path = [self filePathWithSearchDirectoryPath:pathDirrctory FileName:fileName1];
    NSString *fileName2Path = [self filePathWithSearchDirectoryPath:pathDirrctory FileName:fileName2];

    BOOL ret = [FILEMANAGER moveItemAtPath:fileName1Path toPath:fileName2Path error:nil];

    if (ret) {
        NSLog(@"rename success");
    }else{
        NSLog(@"rename fail");
    }
    return ret;
}

@end
