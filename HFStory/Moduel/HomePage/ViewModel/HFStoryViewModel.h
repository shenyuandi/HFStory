//
//  HFStoryViewModel.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/17.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFStoryModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface HFStoryElementViewModel : NSObject
@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSString *content;
-(instancetype)initWithModel:(HFStoryElementModel*)model;
@end




@interface HFStorySectionViewModel : NSObject
@property(nonatomic,strong,readonly)HFStorySectionModel *storySectionModel;
@property (nonatomic, strong, readonly) NSMutableArray<HFStoryElementViewModel*> *storyElementViewModleArray;
-(instancetype)initWithModel:(HFStorySectionModel*)model;
@property(nonatomic,assign)NSInteger isHiden;
@end





@interface HFStoryViewModel : NSObject
@property(nonatomic,strong,readonly)HFStoryModel *storyModel;
@property (nonatomic, strong,readonly) NSString *nickNameString;
@property (nonatomic, strong,readonly) NSString *creatTimeString;
@property (nonatomic, strong,readonly) NSString *stroyTitleString;
@property (nonatomic,strong) NSString *date;
@property (strong, nonatomic) NSURL *headerImageUrl;
//是否是原创
@property (assign, nonatomic)  BOOL  isOriginal;
@property (nonatomic, strong, readonly) NSMutableArray<HFStorySectionViewModel*> *storySectionViewModleArray;
@property (nonatomic, strong, readonly) NSMutableArray<HFStorySectionViewModel*> *visbleStorySectionViewModleArray;
-(instancetype)initWithDate:(NSString *)date;
@end    

NS_ASSUME_NONNULL_END
