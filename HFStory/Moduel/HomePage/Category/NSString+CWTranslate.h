//
//  NSString+CWTranslate.h
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/1.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFStoryModel.h"

@interface NSString (CWTranslate)

+ (instancetype)chineseNumberWithNumber:(NSUInteger)number;

/// 根据category数字获取中文
+ (instancetype)getCategoryStringWithCategoryInteger:(NSInteger)category;

/// 根据category数字获取类型
- (HFStoryType)getType;

+ (instancetype)getCategoryWithType:(HFStoryType)type;


/// 根据category数字获取英文
+ (NSString *)getTypeStrWithCategoryInteger:(NSInteger)category;
/// 根据类型获取英文
+ (NSString *)getTypeStrWithType:(HFStoryType)type;



@end
