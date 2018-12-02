//
//  HFHomeTableViewController.h
//  HFStory
//
//  Created by 沈子琦 on 2018/11/7.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHomeViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFHomeTableViewController : UITableViewController
+(instancetype)viewControllerWithViewModel:(HFHomeViewModel*) viewModel;
-(void)setDate:(NSString *)date;
-(void)moveToNextDay;
-(void)moveToLastDay;
@end

NS_ASSUME_NONNULL_END
