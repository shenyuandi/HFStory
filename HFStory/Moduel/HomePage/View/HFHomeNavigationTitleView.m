//
//  HFHomeNavigationTitleView.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeNavigationTitleView.h"
#import "HFHomeNavigationBarTitleTextView.h"
#define kMaxTitleY 20.0
#define kMinTitleY 0.0
#define kBackBtnCenterYOffset 10.0
#define kMaxBackBtnCenterY kNavigationBarHeight * 0.5 + kBackBtnCenterYOffset
#define kMinBackBtnCenterY kNavigationBarHeight * 0.5
@interface HFHomeNavigationTitleView ()

@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIButton *backToTodayButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) HFHomeNavigationBarTitleTextView *textView;

@property (assign, nonatomic, getter=isUnfold) BOOL unfold;

@end
@implementation HFHomeNavigationTitleView

+ (instancetype)homeNavTitleView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleButton.frame = CGRectMake(0, kMaxTitleY, SCREEN_WIDTH, kNavigationBarHeight - 20.0);
    self.weatherLabel.ct_centerX = SCREEN_WIDTH* 0.5;
    self.searchButton.ct_x = SCREEN_WIDTH - self.searchButton.ct_width;
    
    
    // 添加标题控件
    HFHomeNavigationBarTitleTextView *textView = [[HFHomeNavigationBarTitleTextView alloc] init];
    textView.frame = CGRectMake(0, kMaxTitleY, SCREEN_WIDTH, kNavigationBarHeight - kMaxTitleY);
    [self insertSubview:textView atIndex:0];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedsDidSelected) name:ONEFeedsDidSelectedNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setWeatherItem:(HFHomeWeatherViewModel *)weatherItem {
    _weatherItem = weatherItem;
    
    self.textView.dateString = weatherItem.date;
    
    NSString *weatherStr = [NSString stringWithFormat:@"%@     %@     %@°C",weatherItem.city_name,weatherItem.climate,weatherItem.temperature];
    self.weatherLabel.text = weatherStr;
}

#pragma mark - 事件响应
- (IBAction)titleButtonClick:(UIButton *)sender {
    
    self.unfold = !self.isUnfold;
    
    // 修改箭头朝向
    if(self.unfold) {
        [UIView animateWithDuration:0.3 animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI*-179.9/180);
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
    // 发出通知来处理弹出或收起
    if (self.unfold) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ONETitleViewFeedsUnFoldNotification object:nil userInfo:@{ONEDateStringKey : self.textView.dateString}];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:ONETitleViewFeedsFoldNotification object:nil userInfo:nil];
    }
}

- (IBAction)searchButtonClick:(UIButton *)sender {
   // [[ONESearchTool sharedInstance] presentSearchViewController];
}

- (IBAction)backToTodayButtonClick:(UIButton *)sender {
    if (self.unfold) {
        [self titleButtonClick:nil];
    }
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ONETitleViewBackToTodayButtonClickNotifcation object:nil userInfo:nil];
}

- (void)feedsDidSelected {
    // 点击一次按钮，让其收起
    [self titleButtonClick:nil];
}

#pragma mark - 对外方法
- (void)updateSubFrameAndAlphaWithOffset:(CGFloat)offset {
    // 修改搜索按钮的alpha
    self.searchButton.alpha = (offset/ONEScrollOffsetLimit);
    // 修改箭头的alpha
    self.arrowImageView.alpha = (offset/ONEScrollOffsetLimit);
    // 修改天气标签的alpha
    self.weatherLabel.alpha = 1-offset/ONEScrollOffsetLimit;
    // 修改title的frame
    CGFloat titleY = kMinTitleY + kMaxTitleY * (offset/ONEScrollOffsetLimit);
    titleY = titleY < kMinTitleY ? kMinTitleY : titleY;
    titleY = titleY > kMaxTitleY ? kMaxTitleY : titleY;
    self.textView.y = titleY;
    // 修改返回标签的frame
    CGFloat backCenterY = kMinBackBtnCenterY + kBackBtnCenterYOffset * (offset/ONEScrollOffsetLimit);
    backCenterY = backCenterY < kMinBackBtnCenterY ? kMinBackBtnCenterY : backCenterY;
    backCenterY = backCenterY > kMaxBackBtnCenterY ? kMaxBackBtnCenterY : backCenterY;
    self.backToTodayButton.centerY = backCenterY;
    
    self.titleButton.enabled = (offset >= ONEScrollOffsetLimit);
}
- (void)updateBackButtonVisible:(BOOL)isHidden {
    self.backToTodayButton.hidden = isHidden;
}
- (void)updateDateStringWithDateString:(NSString *)dateString {
    self.textView.dateString = dateString;
}

@end
