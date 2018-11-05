//
//  HFHomeWeatherViewModel.h
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFHomeWeatherViewModel : NSObject
+ (instancetype)weatherItemWithDict:(NSDictionary *)dict;

@property (strong, nonatomic) NSString *city_name;

@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) NSString *temperature;

@property (strong, nonatomic) NSString *climate;

@property (strong, nonatomic) NSString *wind_direction;

@property (strong, nonatomic) NSString *hurricane;

@property (strong, nonatomic) NSString *icon_day;

@property (strong, nonatomic) NSString *icon_night;

@end

NS_ASSUME_NONNULL_END
