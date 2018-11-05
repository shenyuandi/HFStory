//
//  HFHomeNavigtionBar.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHomeWeatherViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFHomeNavigationBar : UINavigationBar
- (void)updateTitleViewWithOffset:(CGFloat)offset;

/// 确定title的状态
- (void)confirmTitlViewWithOffset:(CGFloat)offset;

/// 修改返回今天按钮的显示性
- (void)updateTitleViewBackToTodayButtonVisible:(BOOL)isHidden;

/// 修改日期
- (void)updateTitleViewDateStringWithDateString:(NSString *)dateString;

/// 修改天气
- (void)updateTitleViewWeatherStringWithWeatherItem:(HFHomeWeatherViewModel *)weatherItem;

/// 隐藏日期
- (void)hideCustomTitleView;

/// 显示日期
- (void)showCustomTitleView;

/// 将导航条修改为只显示20的高度的白底格式
- (void)changeNavigationBarToShortMode;

/// 将导航条修改为无背景，按钮和状态栏均为白色的格式
- (void)changeNavigationBarToLucencyMode;

/// 恢复为原大小
- (void)resumeNavigationBar;

/// 显示或隐藏阴影
- (void)changeShadowViewVisible:(BOOL)visible;

/// 修改导航条背景和阴影的alpha值
- (void)changeAlphaOfBackgroundAndShadow:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
