//
//  HFHomeNavigationTitleView.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHomeWeatherViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFHomeNavigationTitleView : UIView
@property (strong, nonatomic) HFHomeWeatherViewModel *weatherItem;

+ (instancetype)homeNavTitleView;

- (void)updateSubFrameAndAlphaWithOffset:(CGFloat)offset;

- (void)updateBackButtonVisible:(BOOL)isHidden;

- (void)updateDateStringWithDateString:(NSString *)dateString;

@end

NS_ASSUME_NONNULL_END
