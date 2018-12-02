//
//  HFStoryHeaderView.h
//  HFStory
//
//  Created by 沈子琦 on 2018/11/8.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYLabel.h>
NS_ASSUME_NONNULL_BEGIN

@interface HFStoryHeaderView : UIView
@property (strong, nonatomic) UIImageView *headerImageView;
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
@end

NS_ASSUME_NONNULL_END
