//
//  HFHomeWeatherViewModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeWeatherViewModel.h"
#import <AFNetworking.h>
#import <HeWeather/HeWeather.h>
#import "NSString+ONEComponents.h"
@interface HFHomeWeatherViewModel ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager* locationManager;
@end
@implementation HFHomeWeatherViewModel
+ (instancetype)weatherViewModeToday {
    HFHomeWeatherViewModel *item = [[HFHomeWeatherViewModel alloc] init];
    item.date = [NSString getDateStringWithDate:[NSDate date]];
    item.finishSigal = [[RACSubject alloc] init];
    item.city_name = @"获取天气中...";
    [item startLocation];
    return item;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // do nothing
}
-(void)getWeatherOfCity:(NSString *)city
{
    AllWeatherInquieirs *heWeather = [AllWeatherInquieirs sharedInstance];
    
    heWeather.userType = USER_TYPE_FREE_USER;
    heWeather.kHeAppUsername =@"HE1811121125421615";
    heWeather.kHeAppKey = @"0acd9aea8f0948ca90682a0e117db89b";
    heWeather.location = city;
    
    [heWeather weatherWithInquireType:INQUIRE_TYPE_WEATHER_NOW WithSuccess:^( WeatherNowBaseClass *responseObject) {
        self.temperature = responseObject.now.tmp;
        self.wind_direction = responseObject.now.wind_dir;
        self.climate = responseObject.now.cond_txt;
        self.cond_code = responseObject.now.cond_code;
        [self.finishSigal sendNext:nil];
        
    } faileureForError:^(NSError *error) {
        [self.finishSigal sendNext:nil];
        
    }];
}
-(void)startLocation{
    
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;//遵循代理
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManager.distanceFilter = 10.0f;
        [_locationManager requestWhenInUseAuthorization];
        
        //使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        
        //开始定位
        [self.locationManager startUpdatingLocation];
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
        self.city_name = @"请在设置中开启定位权限";
        
    }
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    //    [self presentViewController:alert animated:YES completion:nil];
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            }
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:{
            NSLog(@"访问受限");
            self.city_name = @"请在设置中开启定位权限";
            break;
        }
        case kCLAuthorizationStatusDenied:{
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
                self.city_name = @"请在设置中开启定位权限";
            } else {
                NSLog(@"定位服务关闭，不可用");
                self.city_name = @"请在设置中开启定位权限";
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:{
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currLocation = [locations lastObject];
    
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *address = [placemark addressDictionary];
            
            //  Country(国家)  State(省)  City（市）
            NSLog(@"#####%@",address);
            
            NSLog(@"%@", [address objectForKey:@"Country"]);
            
            NSLog(@"%@", [address objectForKey:@"State"]);
            
            NSLog(@"%@", [address objectForKey:@"City"]);
            self.city_name =[address objectForKey:@"City"];
            [self getWeatherOfCity:self.city_name];
        }
        
    }];
}
-(void)setDateOffset:(NSInteger) offset{
    NSDateComponents *dateCpmponents =  [self.date getComponents];
    [dateCpmponents setDay:[dateCpmponents day] +offset];
    NSCalendar *calendar    = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.date =   [NSString getDateStringWithDate:[calendar dateFromComponents:dateCpmponents]];
}
@end


