//
//  LCdes.h
//  DESDemo
//
//  Created by LuochuanAD on 16/4/29.
//  Copyright © 2016年 LuochuanAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
static NSString *key = @"story001";
 static   Byte iv[] = {'f', 'o', 'r', 's', 't',  'o',  'r',  'y' };
@interface LCdes : NSObject
//加密
+ (NSString *)lcEncryUseDES:(NSString *)string;
//解密
+ (NSString *)lcDecryUseDES:(NSString *)string;
//url编码
+ (NSString *)UrlValueEncode:(NSString *)str;
//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
@end
@interface NSString (MD5)
/**
 *  md5加密的字符串
 *
 */
-(NSString *) md5;
- (NSString *) md5_base64;
@end
