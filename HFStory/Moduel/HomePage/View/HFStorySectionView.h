//
//  HFStorySectionView.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/23.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYLabel.h>
#import "HFStoryViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface HFStoryElementView : UITableViewCell
-(void)setViewModel:(HFStoryElementViewModel *) storyElemntViewModelArray;
@end


@interface HFStorySectionView : UITableViewCell
-(void)setViewModel:(HFStorySectionViewModel *) storyElemntViewModelArray;

@end

NS_ASSUME_NONNULL_END
