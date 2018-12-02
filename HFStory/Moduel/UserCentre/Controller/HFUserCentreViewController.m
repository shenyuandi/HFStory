//
//  HFUserCentreViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/11/20.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFUserCentreViewController.h"
#import "ONENavigationBarTool.h"
#import "HFLoginViewController.h"
#import "HFAboutViewController.h"
@interface HFUserCentreViewController ()
@property(weak,nonatomic)IBOutlet UIImageView *avatarImageView;
@property(weak,nonatomic)IBOutlet UILabel *nickNameLabel;
@property(weak,nonatomic)IBOutlet UILabel *likeNumLabel;
@property(weak,nonatomic)IBOutlet UILabel *followNumLabel;
@property(weak,nonatomic)IBOutlet UILabel *funsNumLabel;
@property(weak,nonatomic)IBOutlet UIButton *loginBtn;
@end

@implementation HFUserCentreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"hehe");
    }];
    UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = image;
    UIImage *image1 = [self.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = image1;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ONENavigationBarTool sharedInstance] updateCurrentViewController:self];
    [[ONENavigationBarTool sharedInstance] changeNavigationBarToLucencyMode];
    [[ONENavigationBarTool sharedInstance] hideCustomTitleView];
    [[ONENavigationBarTool sharedInstance] hideStatusBarWithAnimated:NO];
    //[[ONENavigationBarTool sharedInstance] resumeStatusBarWithAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
