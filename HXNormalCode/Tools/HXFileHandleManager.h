//
//  HXFileHandleManager.h
//  HXNormalCode
//
//  Created by MacOS on 17/8/7.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXFileHandleManager : NSObject

+ (HXFileHandleManager *)shareInstance;

#pragma mark /** -----------  文件路径操作  -------------   **/


/**
 获取HomeDirectroy路径

 @return HomeDirectroy路径
 */
- (NSString *)homeDirectory;

/**
 获取TempDirectory路径

 @return TempDirectory路径
 */
- (NSString *)tempDirectory;

/**
 获取根目录 document/cache

 @param pathDirectory 查询条件
 @return 路径
 */
- (NSString *)fileDiectoryDomainWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory;


/**
 创建指定的文件夹

 @param dirName 文件夹名字
 */
- (void)createDirectoryWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory DirName:(NSString *)dirName;

/**
 获取文件路径

 @param pathDirectory 搜索路径条件
 @param fileName 文件名
 @return 文件路径
 */
- (NSString *)filePathWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory FileName:(NSString *)fileName;

/**
 获取完整的文件路径

 @param fileName 文件名
 @param extension 文件扩展名
 @return 文件路径
 */
- (NSString *)completeFilePathWithSearchDirectoryPath:(NSSearchPathDirectory)pathDirectory FileName:(NSString *)fileName Extension:(NSString *)extension;


/**
 获取文件路径组成部分

 @param filePath 文件路径
 @return 路径组成部分
 */
- (NSArray *)pathComponentsWithPath:(NSString *)filePath;


/**
 删除文件路径最后组成部分

 @param filePath 文件路径
 */
- (void)deleteFilePathLastCompent:(NSString *)filePath;


/**
 删除扩展名

 @param filePath 文件路径
 */
- (void)deleteExtension:(NSString *)filePath;


/**
 获取扩展名

 @param filePath 文件路径
 @return 扩展名
 */
- (NSString *)getFileExtension:(NSString *)filePath;


/**
 追加扩展名

 @param filePath 文件路径
 @return 追加扩展名后的文件路径
 */
- (NSString *)appendExtension:(NSString *)filePath Extension:(NSString *)extension;

/**
 获取程序包中资源文件路径

 @param fileName 文件名
 @param fileType 文件类型
 @return 文件路径
 */
- (NSString *)filePathFromBundleWithFileName:(NSString *)fileName fileType:(NSString *)fileType;

#pragma mark /** -----------  文件操作  -------------   **/


/**
 创建文件

 @param filePath 文件路径
 @return 创建结果 YES/NO
 */
- (BOOL)creatFileWithFilePath:(NSString *)filePath;


/**
 写文件

 @param filePath 文件路径
 */
- (void)writeToFileWithFilePath:(NSString *)filePath :(NSString *)content;

/**
 读文件

 @param filePath 文件路径
 */
- (NSString *)readFileContentWithFilePath:(NSString *)filePath;


/**
 文件夹中的文件名数组

 @param fileDirectory 文件夹
 @return 文件名数组
 */
- (NSArray *)fileNamesFromDirectory:(NSString *)fileDirectory;


/**
 获取文件大小 B

 @param filePath 文件路径
 @return 文件大小
 */
- (unsigned long long)fileSizeAtFilePath:(NSString *)filePath;


/**
 获取文件夹中所有文件大小

 @param directory 文件夹
 @return 文件夹中文件大小
 */
- (unsigned long long)folderSizeAtDirectory:(NSString *)directory;


/**
 删除某个文件

 @param filePath 文件路径
 @return 删除结果
 */
- (BOOL)removeFileFromFilePath:(NSString *)filePath;


/**
 移动文件

 @param path1 文件路径1
 @param path2 文件路径2
 @return 移动结果
 */
- (BOOL)moveFileFromPath1:(NSString *)path1 toPath2:(NSString *)path2;


/**
 文件重命名

 @param fileName1 文件名1
 @param fileName2 文件名2
 @return 重命名结果
 */
- (BOOL)reFileNameFromFileName1:(NSString *)fileName1 toFileName2:(NSString *)fileName2 SearchDirectoryPath:(NSSearchPathDirectory)pathDirrctory;

@end
