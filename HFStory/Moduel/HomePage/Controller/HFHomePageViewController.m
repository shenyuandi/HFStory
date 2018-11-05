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
#import <DYKit.h>
#import "HFHomeViewModel.h"
#define TOTALNUM   7
typedef enum : NSUInteger {
    HFSrollDiretionLeft,
    HFSrollDiretionRight,
} HFSrollDiretion;
@interface HFHomePageViewController ()<UIScrollViewDelegate>
{
    //背景图片
    UIImageView *_backGroundImageView;
    //个人中心按钮
    //日期和天气
    YYLabel *_dateAndWeatherLabel;
    //天气图标
    UIImageView *_weatherImageView;
    
    //内容视图
    UIButton *_userButton;
    CGPoint _lastOffset;
    
}
@property (weak, nonatomic) UITableView *leftTableView;
@property (weak, nonatomic) UITableView *middleTableView;
@property (weak, nonatomic) UITableView *rightTableView;
@property (strong, nonatomic) HFHomeViewModel *leftViewModel;
@property (strong, nonatomic) HFHomeViewModel *middleViewModel;
@property (strong, nonatomic) HFHomeViewModel *rightViewModel;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger lastIndex;
@end

@implementation HFHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:[self backGroundImageView]];
//    [self.view addSubview:[self storyView]];
//    [self.view addSubview:[self userButton]];
//    [self.view addSubview:[self dateAndWeatherLabel]];
  //  _storyView.storyEnddingLabel.text= @"哈哈\nsdsdsdasdsasdsdaSdasdasdasdasdasdas\ndas\ndasdasdasdsadasdasdsadsadasdasdad";
  //  [self layoutPageSubviews];
    _leftViewModel = [HFHomeViewModel HFHomeViewModelWithDate:@"27"];
    _middleViewModel = [HFHomeViewModel HFHomeViewModelWithDate:@"28"];
    _rightViewModel = [HFHomeViewModel HFHomeViewModelWithDate:@"29"];
    [self setUpScrollView];
    [self setUpTableViews];
//    RAC(_middleTableView,dy_data) =RACObserve(_middleViewModel,storys);
//    RAC(_leftTableView,dy_data) =RACObserve(_leftViewModel,storys);
//    RAC(_rightTableView,dy_data) =RACObserve(_rightViewModel,storys);
    // Do any additional setup after loading the view from its nib.
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
 
         self.leftTableView.ct_x = 0+15;
    self.middleTableView.ct_x = SCREEN_WIDTH+15;
//    self.loadingImageView.hidden = NO;
//    [self.middleVC setDateStr:kCurrentDateString withCompletion:^{
//        self.loadingImageView.hidden = YES;
//        [self updateNavBarDateTextWithDateString:[HFDateTool sharedInstance].currentDateString];
//        [self updateNavBarWeatherTextWithWeatherItem:self.middleVC.weatherItem];
//    }];

    if (TOTALNUM>2) {
        self.rightTableView.ct_x = 2*SCREEN_WIDTH+15;
//        [_rightVC setDataWith:TOTALNUM-1];
//        [_middleVC setDataWith:TOTALNUM-2];
//        [_leftVC setDataWith:TOTALNUM-3];
     
    }
    else
    {
//           [_middleVC setDataWith:TOTALNUM-1];
//           [_leftVC setDataWith:TOTALNUM-2];
    }
    _lastIndex = TOTALNUM-1;
  //  self.rightVC.dateStr = [[HFDateTool sharedInstance] yesterdayDateStr];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = [self.scrollView contentOffset];
    if (offset.x > SCREEN_WIDTH&&_lastIndex<TOTALNUM-1) { //向右滑动
        self.lastIndex += 1;
  
        if (_lastIndex != TOTALNUM-1) {
//            [_leftVC setDataWith:_lastIndex-1];
//            [_middleVC setDataWith:_lastIndex];
//            [_rightVC setDataWith:_lastIndex+1];
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
            
        }
    }else if(offset.x <_lastOffset.x&&_lastIndex>1){ //向左滑动
        self.lastIndex -= 1;;
//        [_leftVC setDataWith:_lastIndex-1];
//        [_middleVC setDataWith:_lastIndex];
//        [_rightVC setDataWith:_lastIndex+1];
        [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
 
    }
    _lastOffset= _scrollView.contentOffset;
}

#pragma mark - getter
-(UIImageView*)backGroundImageView
{
    if (!_backGroundImageView) {
        UIImageView *cell = [[UIImageView alloc] init];
       _backGroundImageView = cell;
        [_backGroundImageView setBackgroundColor:[UIColor colorWithRed:32.0/255 green:59.0/255 blue:93.0/255 alpha:1]];
    }
    
    return _backGroundImageView;
}
-(UIButton*)userButton
{
    if (!_userButton) {
        UIButton *btn = [[UIButton alloc] init];
        _userButton = btn;
        [_userButton setBackgroundImage:[UIImage imageNamed:@"个人中心"] forState:UIControlStateNormal];
    }
    
    return _userButton;
}
-(YYLabel*)dateAndWeatherLabel
{
    if (!_dateAndWeatherLabel) {
        YYLabel *btn = [[YYLabel alloc] init];
        _dateAndWeatherLabel = btn;
        
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
        [_dateAndWeatherLabel setText:currentDateString];
        [_dateAndWeatherLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:15]];
        [_dateAndWeatherLabel setTextColor:[UIColor whiteColor]];
        [_dateAndWeatherLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    return _dateAndWeatherLabel;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        UITableView *leftTableView = [self creatTableView];
         [self.scrollView addSubview:leftTableView];
        leftTableView.dy_data = _leftViewModel.storys;
        leftTableView.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, SCREEN_HEIGHT);
        _leftTableView = leftTableView;
    }
    return _leftTableView;
}
- (UITableView *)middleTableView {
    if (!_middleTableView) {
        UITableView *middleTableView =[self creatTableView];
                [self.scrollView addSubview:middleTableView];
        middleTableView.dy_data = _middleViewModel.storys;
        middleTableView.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, SCREEN_HEIGHT);
        _middleTableView = middleTableView;
    }
    return _middleTableView;
}
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        UITableView *rightTableView = [self creatTableView];
        [self.scrollView addSubview:rightTableView];
        rightTableView.dy_data = _rightViewModel.storys;
        rightTableView.frame = CGRectMake(15, 0,SCREEN_WIDTH-30, SCREEN_HEIGHT);
        _rightTableView = rightTableView;
    }
    return _rightTableView;
}
-(UITableView*)creatTableView
{
    UITableView *tempTableView = [[UITableView alloc] init];
    tempTableView.showsVerticalScrollIndicator = NO;
    [tempTableView   assemblyByReuseIdentifier:@"HFUIStoryView" withAssemblyBlock:^(HFUIStoryView *cell, HFStoryViewModel *modelView, NSIndexPath *indexPath) {
        cell.ct_height = 0;
        //[cell setViewModel:modelView];
    }];
//    [tempTableView setNumberOfRowsInSection:^NSInteger(UITableView *tableView, NSInteger section) {
//        return 1;
//    }];
//    [tempTableView setHeightForFooterInSection:^CGFloat(UITableView *tableView, NSInteger section) {
//        return 32;
//    }];
//    [tempTableView setNumberOfSectionsInTableView:^NSInteger(UITableView *tableView) {
//        return 2;
//    }];
    tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tempTableView setBackgroundColor:[UIColor colorWithRed:32.0/255 green:59.0/255 blue:93.0/255 alpha:1]];
    return tempTableView;
}
@end
