//
//  ONEMainTabBarController.m
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/1.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "ONEMainTabBarController.h"
#import <YYWebImage.h>
#import "HFPublishViewController.h"
#define kUITabBarHeight 49.0

@interface ONEMainTabBarController () <UITabBarControllerDelegate>

@end

@implementation ONEMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
    self.delegate = self;
    UIImageView *tabbarView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 61)/2, self.tabBar.frame.size.height - 61, 61, 61)];
    tabbarView.image = [UIImage imageNamed:@"发布"];
    [self.tabBar addSubview:tabbarView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)setUpTabBar {
    
    // 设置tabBar背景色
//    UIImage *backgroundImage = [UIImage yy_imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, kUITabBarHeight)];
//    [self.tabBar insertSubview:[[UIImageView alloc] initWithImage:backgroundImage] atIndex:0];
    //调整tabBar中图片的位置
    for (UIViewController *vc in self.viewControllers) {
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
 //   self.tabBar.translucent = NO;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == self.viewControllers[1]) {
        //点击中间tabbarItem，不切换，让当前页面跳转
       HFPublishViewController *publishVC = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HFPublishViewController class]) owner:nil options:nil].firstObject;
        publishVC.hidesBottomBarWhenPushed = YES;
        [tabBarController.selectedViewController presentViewController:publishVC animated:YES completion:nil];
        return NO;
    }
    return YES;  
}


@end
