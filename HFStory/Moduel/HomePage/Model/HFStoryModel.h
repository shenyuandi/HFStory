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
@end


@interface HFStoryElementModel : NSObject
@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSString *content;
@property(assign,nonatomic) NSInteger width;
@property(assign,nonatomic) NSInteger height;
@end



@interface HFStoryModel : NSObject
@property (strong, nonatomic) NSURL *headerImageUrl;
//故事标题
@property (strong, nonatomic)  NSString *storyTitle;
//是否是原创
@property (assign, nonatomic)  BOOL  isOriginal;

@property (assign, nonatomic) NSInteger commentNum;
@property (assign, nonatomic) NSInteger thumbsUpNum;

/**
 昵称
 */
@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSString *ownerID;
@property (strong, nonatomic) NSString *storyID;

@property (strong, nonatomic) NSArray<HFStoryElementModel*> *particulars;

@property (strong, nonatomic) NSArray<HFStoryElementModel*> *outlines;

/**
 发表时间
 */
@property (strong, nonatomic)  NSString *creatTime;
@end


NS_ASSUME_NONNULL_END
