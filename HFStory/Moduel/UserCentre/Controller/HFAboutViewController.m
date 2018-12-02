//
//  HFAboutViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/11/28.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFAboutViewController.h"
#import "ONENavigationBarTool.h"

@interface HFAboutViewController ()
@property(weak,nonatomic)IBOutlet UILabel *versionLabel;
@property(weak,nonatomic)IBOutlet UIButton *userContractBtn;
@end

@implementation HFAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.versionLabel.text = APP_VERSION;

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
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
