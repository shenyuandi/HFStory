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
typedef enum :NSInteger{
    HFSectionTypeHeader,
    HFSectionTypeContent,
    HFSectionTypeTail,
    HFSectionTypeBlank
}HFSectionType;


@interface HFStoryElementViewModel : NSObject
@property(strong,nonatomic,readonly) HFStoryElementModel *model;
-(instancetype)initWithModel:(HFStoryElementModel*)model;
@end




@interface HFStorySectionViewModel : NSObject
@property(nonatomic,assign)HFSectionType sectionType;
-(instancetype)initWithArray:(NSArray*)array;
@property (nonatomic, strong, readonly) NSMutableArray<HFStoryElementViewModel*> *storyElementViewModleArray;
@end



@interface HFStoryViewModel : NSObject
@property(nonatomic,strong,readonly)HFStoryModel *storyModel;
@property(nonatomic,strong,readonly)NSString *creatTimeString;
@property(nonatomic,strong,readonly)NSString *commentNumberString;
@property(nonatomic,strong,readonly)NSString *likeNumberString;
@property(nonatomic,strong,readonly)HFStorySectionViewModel *particulars;
@property(nonatomic,strong,readonly)HFStorySectionViewModel *outlines;
+(instancetype)viewModelWithModel:(HFStoryModel*)model;
@end    

NS_ASSUME_NONNULL_END
