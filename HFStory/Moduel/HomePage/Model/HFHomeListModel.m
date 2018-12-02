//
//  HFHomeListModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/11/16.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeListModel.h"


@implementation HFHomeListModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"storyList" : [HFStoryModel class]};
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"storyList":@"list"};
    
}
@end
