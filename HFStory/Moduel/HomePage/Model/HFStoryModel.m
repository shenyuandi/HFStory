//
//  HFStoryModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/17.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFStoryModel.h"

@implementation HFStoryModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"particulars" : [HFStoryElementModel class],@"outlines" : [HFStoryElementModel class]};
}
@end

@implementation HFStorySectionModel
+(instancetype)storySectionModeWithDictionary:(NSDictionary *)dic
{
    return nil;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"particulars" : [HFStoryElementModel class],@"outlines" : [HFStoryElementModel class]};
}
@end
@implementation HFStoryElementModel

+ (NSArray *)modelPropertyWhitelist {
    return @[@"width",@"height",@"type",@"content"];
}


@end
