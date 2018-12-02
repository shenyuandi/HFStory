//
//  HFHomePageViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/14.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomePageViewController.h"
#import "HFUIStoryView.h"
#import <YYLabel.h>
#import <UIView+LayoutMethods.h>
#import "HFHomeViewModel.h"
#import "HFHomeTableViewController.h"
#import "ONENavigationBarTool.h"
#import "HFHomeWeatherViewModel.h"
#import "NSString+ONEComponents.h"
#define TOTALNUM   7
typedef enum : NSUInteger {
    HFSrollDiretionLeft,
    HFSrollDiretionRight,
} HFSrollDiretion;
@interface HFHomePageViewController ()<UIScrollViewDelegate>
{
    //背景图片
    UIImageView *_backGroundImageView;
    //个人中心按钮;
    
    //内容视图
    UIButton *_userButton;
    CGPoint _lastOffset;
    
}
@property (weak, nonatomic) UITableView *leftTableView;
@property (weak, nonatomic) UITableView *middleTableView;
@property (weak, nonatomic) UITableView *rightTableView;
@property (weak, nonatomic) HFHomeTableViewController *leftVC;
@property (weak, nonatomic) HFHomeTableViewController *middleVC;
@property (weak, nonatomic) HFHomeTableViewController *rightVC;
//@property (strong, nonatomic) HFHomeViewModel *leftViewModel;
//@property (strong, nonatomic) HFHomeViewModel *middleViewModel;
//@property (strong, nonatomic) HFHomeViewModel *rightViewModel;
@property (strong, nonatomic) HFHomeWeatherViewModel *weatherViewModel;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger lastIndex;


@end

@implementation HFHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ONENavigationBarTool sharedInstance] updateCurrentViewController:self];
    _weatherViewModel = [HFHomeWeatherViewModel weatherViewModeToday];
    @weakify(self);
    [_weatherViewModel.finishSigal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self updateNavBarWeatherTextWithWeatherItem:self.weatherViewModel];
    }];
    [RACObserve(_weatherViewModel, date) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self updateNavBarWeatherTextWithWeatherItem:self.weatherViewModel];
    }];
    [self updateNavBarWeatherTextWithWeatherItem:self.weatherViewModel];
   // [self updateNavBarDateTextWithDateString:_weatherViewModel.date];
    [self setUpScrollView];
    [self setUpTableViews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ONENavigationBarTool sharedInstance] updateCurrentViewController:self];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[ONENavigationBarTool sharedInstance] showCustomTitleView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[ONENavigationBarTool sharedInstance] hideCustomTitleView];
}
- (void)setUpScrollView {
    UIScrollView *scrollV = self.scrollView;
    scrollV.contentSize = CGSizeMake(SCREEN_WIDTH*(TOTALNUM>3?3:TOTALNUM), 0);
    scrollV.backgroundColor =[UIColor colorWithRed:32.0/255 green:59.0/255 blue:93.0/255 alpha:1];
    scrollV.pagingEnabled = YES;
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.contentOffset = CGPointMake(SCREEN_WIDTH*(TOTALNUM>3?2:TOTALNUM-1), 0);
    _lastOffset =scrollV.contentOffset;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    scrollV.delegate = self;
}

- (void)setUpTableViews {
    
    self.leftTableView.ct_x = 0;
    
    self.middleTableView.ct_x = SCREEN_WIDTH;
    
    //    self.loadingImageView.hidden = NO;
    //    [self.middleVC setDateStr:kCurrentDateString withCompletion:^{
    //        self.loadingImageView.hidden = YES;
   //         [self updateNavBarDateTextWithDateString:[HFDateTool sharedInstance].currentDateString];
    //    }];
    
    if (TOTALNUM>2) {
        self.rightTableView.ct_x = 2*SCREEN_WIDTH;
        [self.rightVC setDate:[[ONEDateTool sharedInstance] currentDateString]];
        [self.leftVC setDate:[[ONEDateTool sharedInstance] getDateStringFromCurrentDateWihtDateInterval:2]];
        [self.middleVC setDate:[[ONEDateTool sharedInstance] getDateStringFromCurrentDateWihtDateInterval:1]];
        
    }
    else
    {
        //           [_middleVC setDataWith:TOTALNUM-1];
        //           [_leftVC setDataWith:TOTALNUM-2];
    }
    _lastIndex = TOTALNUM-1;
    self.rightVC.date  = [ONEDateTool sharedInstance].currentDateString;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = [self.scrollView contentOffset];
    if (offset.x > SCREEN_WIDTH&&_lastIndex<TOTALNUM-1) { //向右滑动
        self.lastIndex += 1;
        [self.weatherViewModel  setDateOffset:+1];
        if (_lastIndex != TOTALNUM-1) {
            [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
          //  [self updateNavBarWeatherTextWithWeatherItem:];
            
        }
    }else if(offset.x <_lastOffset.x&&_lastIndex>1){ //向左滑动
        self.lastIndex -= 1;;
        //        [_leftVC setDataWith:_lastIndex-1];
        //        [_middleVC setDataWith:_lastIndex];
        //        [_rightVC setDataWith:_lastIndex+1];
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        [self.weatherViewModel  setDateOffset:-1];
        
    }
    else if (offset.x <_lastOffset.x)
    {
        [self.weatherViewModel  setDateOffset:-1];
    }
    else if(offset.x >_lastOffset.x)
    {
        [self.weatherViewModel  setDateOffset:1];
    }
    _lastOffset= _scrollView.contentOffset;
//    BOOL backButtonIsHidden = (index <= 1);
//    [self updateNavBarBackButtonVisible:backButtonIsHidden];
}
- (void)updateNavBarBackButtonVisible:(BOOL)isHidden {
    [[ONENavigationBarTool sharedInstance] updateTitleViewBackToTodayButtonVisible:isHidden];
}
- (void)updateNavBarWeatherTextWithWeatherItem:(HFHomeWeatherViewModel *)weatherItem {
    [[ONENavigationBarTool sharedInstance] updateTitleViewWeatherStringWithWeatherItem:weatherItem];
}
- (void)updateNavBarDateTextWithDateString:(NSString *)dateString {
    [[ONENavigationBarTool sharedInstance] updateTitleViewDateStringWithDateString:dateString];
}
#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight)];
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (HFHomeTableViewController *)leftVC {
    if (!_leftVC) {
        HFHomeTableViewController *leftTableVC =  [[HFHomeTableViewController alloc] init];;
        self.leftVC = leftTableVC;
        [self addChildViewController:leftTableVC];
        _leftVC = leftTableVC;
    }
    return _leftVC;
}
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        UITableView *leftTableView = self.leftVC.tableView;
        leftTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight-kNavigationBarHeight);
        [self.scrollView addSubview:leftTableView];
        _leftTableView = leftTableView;
    }
    return _leftTableView;
}
- (HFHomeTableViewController *)middleVC {
    if (!_middleVC) {
        HFHomeTableViewController *middleTableVC = [[HFHomeTableViewController alloc] init];
        self.middleVC = middleTableVC;
        [self addChildViewController:middleTableVC];
        _middleVC = middleTableVC;
    }
    return _middleVC;
}
- (UITableView *)middleTableView {
    if (!_middleTableView) {
        UITableView *middleTableView = self.middleVC.tableView;
        middleTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight-kNavigationBarHeight);
        [self.scrollView addSubview:middleTableView];
        _middleTableView = middleTableView;
    }
    return _middleTableView;
}
- (HFHomeTableViewController *)rightVC {
    if (!_rightVC) {
        HFHomeTableViewController *rightTableVC =   [[HFHomeTableViewController alloc] init];
        self.rightVC = rightTableVC;
        [self addChildViewController:rightTableVC];
        _rightVC = rightTableVC;
    }
    return _rightVC;
}
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        UITableView *rightTableView = self.rightVC.tableView;
        rightTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight-kNavigationBarHeight);
        [self.scrollView addSubview:rightTableView];
        _rightTableView = rightTableView;
    }
    return _rightTableView;
}

@end




