//
//  Target_HomePage.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/14.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "Target_HFHomePage.h"
#import "HFHomePageViewController.h"
@implementation Target_HFHomePage
-(UIViewController*)Action_nativeHomePageViewController:(NSDictionary *)params
{
    HFHomePageViewController *vc = [[HFHomePageViewController alloc] init];
    return vc;
}

@end
