//
//  HFUIStoryView.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/13.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYLabel.h>
#import "HFStorySectionView.h"
#import "HFStoryViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFUIStoryView : UITableViewCell
@property (strong, nonatomic) UIImageView *headerImageView;
//故事标题
@property (strong, nonatomic)  UILabel *storyTitleLabel;
//是否是原创
@property (strong, nonatomic)  UIImageView *originalImageView;

/**
 昵称
 */
@property (strong, nonatomic) UILabel *nickNameLabel;

/**
 发表时间
 */
@property (strong, nonatomic)  YYLabel *creatTimeLabel;

/**
故事开头
 */
@property (strong, nonatomic)  UIButton *likeBtn;
@property (strong, nonatomic)  UIButton *shareBtn;
@property (strong, nonatomic)  UIButton *commentBtn;
-(void)setViewModel:(HFStoryViewModel*) storyViewModel;
@end

NS_ASSUME_NONNULL_END
