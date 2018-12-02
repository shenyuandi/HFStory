//
//  HFStoryViewModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/17.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFStoryViewModel.h"
#import "ONEDateTool.h"
#import "NSString+ONEComponents.h"
@implementation HFStoryElementViewModel
-(instancetype)initWithModel:(HFStoryElementModel*)model
{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}
@end

@implementation HFStorySectionViewModel
-(instancetype)initWithArray:(NSArray*)array
{
    self = [super init];
    if (self) {
        _storyElementViewModleArray = [[NSMutableArray alloc] initWithCapacity:2];
        for (HFStoryElementModel *sectionModel in array) {
            HFStoryElementViewModel *sem = [[HFStoryElementViewModel alloc] initWithModel:sectionModel];
            [_storyElementViewModleArray addObject:sem];
        }
    }
    return self;
}
@end
@implementation HFStoryViewModel
+(instancetype)viewModelWithModel:(HFStoryModel*)model
{
    HFStoryViewModel *vm = [[HFStoryViewModel alloc] initWithMode:model];
    return vm;
    
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        _storyModel = [[HFStoryModel alloc] init];
    }
    return self;
}
-(instancetype)initWithMode:(HFStoryModel *)model
{
    self = [super init];
    if (self) {
        _storyModel = model;
        _particulars = [[HFStorySectionViewModel alloc] initWithArray:model.particulars];
        _outlines = [[HFStorySectionViewModel alloc] initWithArray:model.outlines];
        _commentNumberString= [NSString stringWithFormat:@"%ld",model.commentNum];
        _likeNumberString = [NSString stringWithFormat:@"%ld",model.thumbsUpNum];
        [self convertCreateTime];
    }
    return self;
}
-(void)convertCreateTime
{
    NSInteger timeInterval = [[ONEDateTool sharedInstance] getDateIntervalFromCurrentDateWithDateString:_storyModel.creatTime];
    if (timeInterval/(24*60*60)) {
        if(-timeInterval/(24*60*60)>3){
            _creatTimeString = [[ONEDateTool sharedInstance] getCommentDateStringWithOriginalDateString:_storyModel.creatTime];
        }
        else
        _creatTimeString = [NSString stringWithFormat:@"%ld 天前",-timeInterval/(24*60*60)];
    }
    else if (timeInterval/(60*60)) {
        _creatTimeString = [NSString stringWithFormat:@"%ld 小时前",-timeInterval/(60*60)];
    }
    else if (timeInterval/60) {
        _creatTimeString = [NSString stringWithFormat:@"%ld 分前",-timeInterval/60];
    }
}
@end

