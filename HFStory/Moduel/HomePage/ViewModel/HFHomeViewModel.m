//
//  HFHomeViewModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/25.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeViewModel.h"
#import <AFNetworking.h>
@interface HFHomeViewModel()
@property (nonatomic, strong) RACCommand *requestCmd;
@end
@implementation HFHomeViewModel
+(instancetype)HFHomeViewModelWithDate:(NSString*)date
{
    HFHomeViewModel *vm = [[HFHomeViewModel alloc] init];
    [vm requestWithDate:date];
    HFStoryViewModel *storyViewModel = [[HFStoryViewModel alloc] initWithDate:date];
    HFStoryViewModel *storyViewMode2 = [[HFStoryViewModel alloc] initWithDate:@"teshu"];
    vm.storys = @[storyViewModel,storyViewMode2];
    return vm;
}
-(void)requestWithDate:(NSString*) dateStr
{
    @weakify(self);
    _requestCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input)
    {
        NSLog(@"我有被执行！");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
        {
            [[AFHTTPSessionManager manager]GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} progress:^(NSProgress * _Nonnull downloadProgress)
            {

            } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject)
            {
                @strongify(self);
                NSArray *dataArray = responseObject[@"books"];
                NSArray *books = [[dataArray.rac_sequence map:^id(id value)
                {
                    HFStoryModel *storys = [[HFStoryModel alloc] init];
                    storys = value;
                    return storys;
                }] array];
                [subscriber sendNext:books];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"失败");
            }];
            return nil;
        }];
    }];
    [_requestCmd execute:nil];
}
@end
