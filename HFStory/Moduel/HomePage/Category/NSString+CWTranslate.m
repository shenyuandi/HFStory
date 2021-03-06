//
//  NSString+CWTranslate.m
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/1.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "NSString+CWTranslate.h"

@implementation NSString (CWTranslate)

+ (instancetype)chineseNumberWithNumber:(NSUInteger)number {
    switch (number) {
        case 0:
            return @"〇";
            break;
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
        case 7:
            return @"七";
            break;
        case 8:
            return @"八";
            break;
        case 9:
            return @"九";
            break;
        default:
            return nil;
    }
}

// 中文

+ (instancetype)getCategoryStringWithCategoryInteger:(NSInteger)category {
    switch (category) {
        case 0:
            return @"小记";
        case 1:
            return @"阅读";
        case 2:
            return @"连载";
        case 3:
            return @"问答";
        case 4:
            return @"音乐";
        case 5:
            return @"影视";
        case 6:
            return @"广告";
        case 8:
            return @"电台";
        case 11:
            return @"专题";
        default:
            return nil;
    }
}


// 英文

+ (NSString *)getTypeStrWithCategoryInteger:(NSInteger)category {
    switch (category) {
        case 0:
            return @"";
        case 1:
            return @"essay";
        case 2:
            return @"serial";
        case 3:
            return @"question";
        case 4:
            return @"music";
        case 5:
            return @"movie";
        case 6:
            return @"advertisement";
        case 8:
            return @"radio";
        case 11:
            return @"topic";
        default:
            return nil;
    }
}

+ (NSString *)getTypeStrWithType:(HFStoryType)type {
    NSInteger category = [NSString getCategoryWithType:type].integerValue;
    return [self getTypeStrWithCategoryInteger:category];
}

// 相互转化

- (HFStoryType)getType {
    switch (self.integerValue) {
        case 0:
            return HFStoryTypeSmallNote;
        case 1:
            return HFStoryTypeEssay;
        case 2:
            return HFStoryTypeSerial;
        case 3:
            return HFStoryTypeQuestion;
        case 4:
            return HFStoryTypeMusic;
        case 5:
            return HFStoryTypeMovie;
        case 6:
            return HFStoryTypeAdvertisement;
        case 8:
            return HFStoryTypeRadio;
        case 11:
            return HFStoryTypeTopic;
        default:
            return HFStoryTypeUnknown;
    }
}

+ (instancetype)getCategoryWithType:(HFStoryType)type {
    NSInteger categoryNum = -1;
    switch (type) {
        case HFStoryTypeSmallNote:
            categoryNum = 0;
            break;
        case HFStoryTypeEssay:
            categoryNum = 1;
            break;
        case HFStoryTypeSerial:
            categoryNum = 2;
            break;
        case HFStoryTypeQuestion:
            categoryNum = 3;
            break;
        case HFStoryTypeMusic:
            categoryNum = 4;
            break;
        case HFStoryTypeMovie:
            categoryNum = 5;
            break;
        case HFStoryTypeAdvertisement:
            categoryNum = 6;
            break;
        case HFStoryTypeRadio:
            categoryNum = 8;
            break;
        case HFStoryTypeTopic:
            categoryNum = 11;
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%ld",categoryNum];
}


@end
