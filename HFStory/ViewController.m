//
//  ViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/12.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "ViewController.h"
#import "ModuelCategory/HomePage/CTMediator+CTMediatorModuleHomePage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_viewControllerForHomePage];
    
    // 获得view controller之后，在这种场景下，到底push还是present，其实是要由使用者决定的，mediator只要给出view controller的实例就好了
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
