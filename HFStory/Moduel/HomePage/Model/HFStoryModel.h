//
//  HFStoryModel.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/17.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYImage.h>
typedef enum : NSUInteger {
    HFStoryTypeSmallNote,
    HFStoryTypeEssay,
    HFStoryTypeSerial,
    HFStoryTypeQuestion,
    HFStoryTypeMusic,
    HFStoryTypeMovie,
    HFStoryTypeAdvertisement,
    HFStoryTypeRadio,
    HFStoryTypeTopic,
    HFStoryTypeUnknown,
} HFStoryType;
NS_ASSUME_NONNULL_BEGIN
@interface HFStorySectionModel : NSObject
@property(strong,nonatomic) NSArray *storySectionElementArray;
+(instancetype)storySectionModeWithDictionary:(NSDictionary*)dic;
@end
@interface HFStoryElementModel : NSObject
@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSString *content;
@end
@interface HFStoryModel : NSObject
@property (strong, nonatomic) NSURL *headerImageUrl;
//故事标题
@property (strong, nonatomic)  NSString *storyTitle;
//是否是原创
@property (assign, nonatomic)  BOOL  isOriginal;

/**
 昵称
 */
@property (strong, nonatomic) NSString *nickName;

/**
 发表时间
 */
@property (strong, nonatomic)  NSString *creatTime;

/**
 故事内容
 */
@property(strong,nonatomic) NSArray<HFStorySectionModel*> *storySectionArray;
+(instancetype)storyModelWithDictionary:(NSDictionary *)dic;
@end


NS_ASSUME_NONNULL_END
