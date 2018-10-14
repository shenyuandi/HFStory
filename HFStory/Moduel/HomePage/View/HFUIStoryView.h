//
//  HFUIStoryView.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/13.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFUIStoryView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

/**
 是否是新浪会员
 */
@property (weak, nonatomic) IBOutlet UILabel *storyTitleLabel;

//是否是原创
@property (weak, nonatomic) IBOutlet UIImageView *isOriginalImageView;

/**
 昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

/**
 发表时间
 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;

/**
故事开头
 */
@property (weak, nonatomic) IBOutlet UILabel *storyBeginningLabel;
//故事结尾
@property (weak, nonatomic) IBOutlet UILabel *storyEnddingLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@end

NS_ASSUME_NONNULL_END
