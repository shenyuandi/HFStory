//
//  HFHomePageViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/14.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomePageViewController.h"

@interface HFHomePageViewController ()
{
    //背景图片
    IBOutlet UIImageView *_backGroundImageView;
    //个人中心按钮
    IBOutlet UIButton *_userCentreBtn;
    //日期和天气
    IBOutlet UILabel *_dateAndWeatherLabel;
    //天气图标
    IBOutlet UIImageView *_weatherImageView;
}

@end

@implementation HFHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateAndWeatherLabel.text = @"2018-10-14";//[NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
