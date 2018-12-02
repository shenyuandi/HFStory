//
//  HFHomeViewModel.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/25.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFStoryViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFHomeViewModel : NSObject
@property (nonatomic, assign, readonly) BOOL allStorysLoaded;
@property (nonatomic, strong, readwrite) NSString *dateString;
@property(nonatomic,assign,readonly)NSInteger total;
@property(nonatomic,assign,readonly)NSInteger offset;
@property (nonatomic, strong) RACCommand *requestCmd;
@property(nonatomic,strong,readonly)NSArray<HFStoryViewModel*> *storyList;


- (void) getStorysList;
- (void) loadMoreStorys;
-(void)requestWithDate:(NSString*) dateStr;
+(instancetype)HFHomeViewModelWithDate:(NSString*)date;

@end

NS_ASSUME_NONNULL_END
