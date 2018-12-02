//
//  HFHomeListModel.h
//  HFStory
//
//  Created by 沈子琦 on 2018/11/16.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFStoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFHomeListModel : NSObject
@property(nonatomic,assign)NSInteger total;
@property(nonatomic,strong)NSArray<HFStoryModel*> *storyList;
@end

NS_ASSUME_NONNULL_END
