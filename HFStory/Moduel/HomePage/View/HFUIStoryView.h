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
#import "HFStoryHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFUIStoryView : UITableViewCell

/**
 故事开头
 */
@property (strong, nonatomic)  UIButton *likeBtn;
@property (strong, nonatomic)  UIButton *shareBtn;
@property (strong, nonatomic)  UIButton *commentBtn;
@property (strong, nonatomic) RACSignal *sectionSelected;
/* 摆放作者，头像等内容 */
@property(strong,nonatomic)HFStoryHeaderView *headerView;
@property(strong,nonatomic)HFStorySectionView *beginningSectionView;
@property(strong,nonatomic)HFStorySectionView *enddingSectionView;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIView * foregroundView;
@property (nonatomic, strong) UIView * interView;
@property(strong,nonatomic)YYLabel *storyTileLabel;
@property(assign,nonatomic)NSInteger visbleIndex;
@property(assign,nonatomic)NSInteger currentHeight;
@property(assign,nonatomic)CGFloat closeHeight;
@property(assign,nonatomic)CGFloat openHeight;
-(void)setViewModel:(HFStoryViewModel*) storyViewModel;
-(UIView *)firstSectionView;
- (void)unfold:(BOOL)value animated:(BOOL )animated completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END

