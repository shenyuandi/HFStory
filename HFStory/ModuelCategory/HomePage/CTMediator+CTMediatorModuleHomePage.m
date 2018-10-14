//
//  CTMediator+CTMediatorModuleHomePage.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/14.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "CTMediator+CTMediatorModuleHomePage.h"
NSString * const kCTMediatorTargetHomePage = @"HFHomePageViewController";

NSString * const kCTMediatorActionHomePageController = @"nativeHomePageController";
NSString * const kCTMediatorActionNativePresentImage = @"nativePresentImage";
NSString * const kCTMediatorActionNativeNoImage = @"nativeNoImage";
NSString * const kCTMediatorActionShowAlert = @"showAlert";
NSString * const kCTMediatorActionCell = @"cell";
NSString * const kCTMediatorActionConfigCell = @"configCell";

@implementation CTMediator (CTMediatorModuleHomePage)
- (UIViewController *)CTMediator_viewControllerForHomePage
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetHomePage
                                                    action:kCTMediatorActionHomePageController
                                                    params:@{@"key":@"value"}
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
