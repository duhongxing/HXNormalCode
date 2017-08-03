//
//  EncryptionViewController.m
//  HXNormalCode
//
//  Created by MacOS on 17/8/2.
//  Copyright © 2017年 baitongshiji. All rights reserved.
//

#import "EncryptionViewController.h"
#import <CommonCrypto/CommonDigest.h>
@interface EncryptionViewController ()

@end

@implementation EncryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//md5加密
- (NSString *)md5Digest:(NSString *)str{

    const char *cStr = [str UTF8String];

    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);

    NSMutableString *md5Result = [[NSMutableString alloc]init];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5Result appendFormat:@"%02x",result[i]];
    }

    return md5Result;
}

//哈希加密
- (NSString *)sha1:(NSString *)str{
    const char *cStr = [str UTF8String];
    NSData *data =[NSData dataWithBytes:cStr length:str.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, (CC_LONG)strlen(cStr), digest);

    NSMutableString *shaResult = [[NSMutableString alloc]init];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [shaResult appendFormat:@"%02x",digest[i]];
    }
    return shaResult;
}

@end
