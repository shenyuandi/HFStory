//
//  HFHomeViewModel.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/25.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeViewModel.h"
#import <AFNetworking.h>
#import "LCdes.h"
#import "HFHomeListModel.h"
@interface HFHomeViewModel()
@end
@implementation HFHomeViewModel
+(instancetype)HFHomeViewModelWithDate:(NSString*)date
{
    HFHomeViewModel *vm = [[HFHomeViewModel alloc] init];
    vm.dateString = date;
    [vm getStorysList];
    return vm;
}
-(void)loadMoreStorys
{
    
}
- (void) getStorysList
{
    [self requestWithDate:self.dateString];
}
-(void)setDateString:(NSString *)dateString
{
    _dateString = dateString;
    [self getStorysList];
}
-(void)requestWithDate:(NSString*) dateStr
{
    @weakify(self);
    _requestCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input)
    {
        @strongify(self);
        _offset = 10;
        NSDictionary *param = @{@"startTime":[dateStr stringByAppendingString:@" 00:00:0000"],@"endTime":[dateStr stringByAppendingString:@" 00:00:0000"],@"offset":@"0",@"count":@"10"};
        NSString *desParam =[LCdes lcEncryUseDES:[param yy_modelToJSONString]] ;
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
        {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:[ServerAdress stringByAppendingString:@"getHomeLists"] parameters:@{@"d":desParam,@"s":[[desParam stringByAppendingString:key] md5],@"k":@"story"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject)
            {
                NSString *data = [LCdes lcDecryUseDES:responseObject[@"d"]];;
                HFHomeListModel *dic = [HFHomeListModel yy_modelWithJSON:data];
                NSArray *dataArray = dic.storyList;
                _total = dic.total;
                NSArray *storys = [[dataArray.rac_sequence map:^id(id value)
                {
                    HFStoryViewModel *viewModel = [HFStoryViewModel viewModelWithModel:value];
                    return viewModel;
                }] array];
                _storyList = storys;
                [subscriber sendNext:storys];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"失败");
            }];
            return nil;
        }];
    }];
}
@end
