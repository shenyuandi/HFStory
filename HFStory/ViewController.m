//
//  ViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/12.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "ViewController.h"
#import "CTMediator+CTMediatorModuleHomePage.h"
#import "HFHomeNavigtionBar.h"
#import <UIView+LayoutMethods.h>
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{

   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
   // [self setNeedsStatusBarAppearanceUpdate];
    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_viewControllerForHomePage];
  // [self presentViewController:viewController animated:NO completion:nil];
    [self pushViewController:viewController animated:NO];
}
- (void)setUpNavigationBar {
    HFHomeNavigationBar *navBar = [[HFHomeNavigationBar alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    navBar.translucent = NO;
    [self setValue:navBar forKeyPath:@"navigationBar"];
}

#pragma mark - UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}
- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (navigationController.childViewControllers.count == 1) {
            self.interactivePopGestureRecognizer.enabled = NO;
        } else {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

@end
