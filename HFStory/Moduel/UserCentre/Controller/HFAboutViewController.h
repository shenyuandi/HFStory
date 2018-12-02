//
//  HFAboutViewController.h
//  HFStory
//
//  Created by 沈子琦 on 2018/11/28.
//  Copyright © 2018 沈子琦. All rights reserved.
//
/** 获取APP名称 */

#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

/** 程序版本号 */

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/** 获取APP build版本 */

#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

/** User-Agent */

#define APP_USER_AGENT [NSString stringWithFormat:@"/%@ (%@;U;%@ %@;%@/%@)", \APP_VERSION, DeviceModel, DeviceSystemName, DeviceVersion, DeviceLocal, DeviceLang]
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFAboutViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
