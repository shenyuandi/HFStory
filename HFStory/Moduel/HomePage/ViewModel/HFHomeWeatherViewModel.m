//
//  HFHomeWeatherViewModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeWeatherViewModel.h"

@implementation HFHomeWeatherViewModel
+ (instancetype)weatherItemWithDict:(NSDictionary *)dict {
    HFHomeWeatherViewModel *item = [[HFHomeWeatherViewModel alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    
    [item setValue:dict[@"icons"][@"day"] forKeyPath:@"icon_day"];
    [item setValue:dict[@"icons"][@"night"] forKeyPath:@"icon_night"];
    
    return item;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // do nothing
}

@end
