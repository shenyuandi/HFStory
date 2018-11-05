//
//  HFStoryViewModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/17.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFStoryViewModel.h"
@implementation HFStoryElementViewModel
-(instancetype)initWithModel:(HFStoryElementModel*)model
{
    self = [super init];
    if (self) {
        _type = model.type;
        _content = model.content;
    }
    return self;
}
@end

@implementation HFStorySectionViewModel
-(instancetype)initWithModel:(HFStorySectionModel*)model
{
    self = [super init];
    if (self) {
            _storyElementViewModleArray = [[NSMutableArray alloc] initWithCapacity:2];
        for (HFStoryElementModel *sectionModel in model.storySectionElementArray) {
            HFStoryElementViewModel *sem = [[HFStoryElementViewModel alloc] initWithModel:sectionModel];
            [_storyElementViewModleArray addObject:sem];
        }
    }
    return self;
}
@end
@implementation HFStoryViewModel
-(instancetype)init
{
    self = [super init];
    if (self) {
        _storyModel = [HFStoryModel storyModelWithDictionary:nil];
        _storySectionViewModleArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

-(instancetype)initWithDate:(NSString *)date
{
    self = [super init];
    if (self) {
        _storyModel = [HFStoryModel storyModelWithDictionary:date];
        _nickNameString = _storyModel.nickName;
        _creatTimeString = _storyModel.creatTime;
        _stroyTitleString = _storyModel.storyTitle;
        _isOriginal = _storyModel.isOriginal;
        _headerImageUrl = _storyModel.headerImageUrl;
        _storySectionViewModleArray = [[NSMutableArray alloc] initWithCapacity:2];
        for (HFStorySectionModel *sectionModel in _storyModel.storySectionArray) {
            HFStorySectionViewModel *svm = [[HFStorySectionViewModel alloc] initWithModel:sectionModel];
            [_storySectionViewModleArray addObject:svm];
            
        }
        _visbleStorySectionViewModleArray = [NSMutableArray arrayWithObject:[_storySectionViewModleArray firstObject]];
    }
    return self;
}
-(void)setDate:(NSString *)date
{
    _storyModel = [HFStoryModel storyModelWithDictionary:date];
    _nickNameString = _storyModel.nickName;
    _creatTimeString = _storyModel.creatTime;
    _stroyTitleString = _storyModel.storyTitle;
    _isOriginal = _storyModel.isOriginal;
    _headerImageUrl = _storyModel.headerImageUrl;
    _storySectionViewModleArray = [[NSMutableArray alloc] initWithCapacity:2];
    for (HFStorySectionModel *sectionModel in _storyModel.storySectionArray) {
        HFStorySectionViewModel *svm = [[HFStorySectionViewModel alloc] initWithModel:sectionModel];
        [_storySectionViewModleArray addObject:svm];
        
    }
}
@end
