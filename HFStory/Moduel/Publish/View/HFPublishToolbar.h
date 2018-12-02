//
//  HFPublishToolbar.h
//  HFStory
//
//  Created by 沈子琦 on 2018/12/1.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPublishToolbar : UIToolbar
@property(weak,nonatomic)IBOutlet UIButton *publishBtn;
@property(weak,nonatomic)IBOutlet UIButton *originalBtn;
@property(weak,nonatomic)IBOutlet UIButton *photoPickerBtn;

@end

NS_ASSUME_NONNULL_END
