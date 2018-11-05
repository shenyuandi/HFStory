//
//  HFHomeNavigtionBar.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeNavigtionBar.h"
#import "HFHomeNavigationTitleView.h"
//#import "UIImage+CWColorAndStretch.h"
#import <YYWebImage.h>
@interface HFHomeNavigationBar()
@property (weak, nonatomic) UIView *navBarBackgroundView;

@property (weak, nonatomic) UIImageView *shadowView;

@property (weak, nonatomic) HFHomeNavigationTitleView *homeTitleView;

@property (assign, nonatomic) CGFloat tempStatusBarAlpha;
@end
@implementation HFHomeNavigationBar
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBackgroundView];
        [self setTintColor:[UIColor grayColor]];
        
        self.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0]};
    }
    return self;
}

- (void)setUpBackgroundView {
    // 设置navBar背景色
    UIView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20,SCREEN_WIDTH, kNavigationBarHeight)];
    backgroundView.backgroundColor = [UIColor colorWithWhite:254/255.0 alpha:1.0];
    UIImage *underlineImage = [UIImage yy_imageWithColor:[UIColor colorWithWhite:239/255.0 alpha:1.0]];
    UIImageView *underlineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, 0.5)];
    underlineImageView.image = underlineImage;
    [backgroundView addSubview:underlineImageView];
    //    [self setValue:backgroundView forKeyPath:@"_customBackgroundView"];
    self.navBarBackgroundView = backgroundView;
    
}

#pragma mark - 对外公有方法
//- (void)updateTitleViewWithOffset:(CGFloat)offset {
//
//    // 修改状态栏的透明度
//    [self changeAlphaOfStatusBar:(offset/ONEScrollOffsetLimit)];
//
//    // 让titleView更新
//    [self.homeTitleView updateSubFrameAndAlphaWithOffset:offset];
//}
//
//- (void)confirmTitlViewWithOffset:(CGFloat)offset {
//
//    if (offset >= ONEScrollOffsetLimit * 0.5) {
//        [self changeAlphaOfStatusBar:1];
//        [self.homeTitleView updateSubFrameAndAlphaWithOffset:ONEScrollOffsetLimit];
//    } else {
//        [self changeAlphaOfStatusBar:0];
//        [self.homeTitleView updateSubFrameAndAlphaWithOffset:0];
//    }
//}
//
//- (void)updateTitleViewBackToTodayButtonVisible:(BOOL)isHidden {
//    [self.homeTitleView updateBackButtonVisible:isHidden];
//}
//
//- (void)updateTitleViewDateStringWithDateString:(NSString *)dateString {
//    [self.homeTitleView updateDateStringWithDateString:dateString];
//}
//
//- (void)updateTitleViewWeatherStringWithWeatherItem:(ONEHomeWeatherItem *)weatherItem {
//    self.homeTitleView.weatherItem = weatherItem;
//}

- (void)hideCustomTitleView {
    self.homeTitleView.hidden = YES;
    [self saveTempAlpha];
    [self changeAlphaOfStatusBar:1.0];
}

- (void)showCustomTitleView {
    self.homeTitleView.hidden = NO;
    [self changeAlphaOfStatusBar:self.tempStatusBarAlpha];
}

- (void)changeNavigationBarToShortMode {
    self.ct_y = -44;
    self.navBarBackgroundView.ct_y = 20;
    self.navBarBackgroundView.alpha = 1;
}

- (void)changeNavigationBarToLucencyMode {
    self.ct_y = 20;
    self.navBarBackgroundView.ct_y = 0;
    self.navBarBackgroundView.alpha = 0;
}

- (void)resumeNavigationBar {
    self.ct_y = 20;
    self.navBarBackgroundView.ct_y = 0;
    self.navBarBackgroundView.alpha = 1;
}

- (void)changeStatusBarStyle {
    
}

- (void)changeShadowViewVisible:(BOOL)visible {
    self.shadowView.hidden = !visible;
}

- (void)changeAlphaOfBackgroundAndShadow:(CGFloat)alpha {
    self.navBarBackgroundView.alpha = alpha;
    self.shadowView.alpha = alpha;
}

#pragma mark - 私有方法
- (void)changeAlphaOfStatusBar:(CGFloat)alpha {
    UIApplication *app = [UIApplication sharedApplication];
    // 通过KVC拿到statusBar
    UIView *statusBar = [app valueForKeyPath:@"statusBar"];
    statusBar.alpha = alpha;
}

- (void)saveTempAlpha {
    UIApplication *app = [UIApplication sharedApplication];
    // 通过KVC拿到statusBar
    UIView *statusBar = [app valueForKeyPath:@"statusBar"];
    self.tempStatusBarAlpha = statusBar.alpha;
}
#pragma mark - 懒加载
- (HFHomeNavigationTitleView *)homeTitleView {
    if (!_homeTitleView) {
        HFHomeNavigationTitleView *homeTitleView = [HFHomeNavigationTitleView homeNavTitleView];
        homeTitleView.frame = CGRectMake(0, -20, SCREEN_WIDTH, kNavigationBarHeight);
        [self addSubview:homeTitleView];
        _homeTitleView = homeTitleView;
    }
    return _homeTitleView;
}

- (UIImageView *)shadowView {
    if (!_shadowView) {
        UIImageView *shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationBarShadowImage"]];
        shadowView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 10);
        shadowView.hidden = YES;
        [self addSubview:shadowView];
        _shadowView = shadowView;
    }
    return _shadowView;
}

@end
