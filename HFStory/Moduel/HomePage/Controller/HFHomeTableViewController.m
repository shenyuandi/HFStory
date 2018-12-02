//
//  HFHomeTableViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/11/7.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeTableViewController.h"
#import "HFHomeViewModel.h"
#import "HFUIStoryView.h"
#import "HFHomeNavigtionBar.h"
#import <CoreLocation/CoreLocation.h>
#import <MJRefresh.h>
@interface HFHomeTableViewController ()

@property (nonatomic,copy) NSMutableArray* itemHeight;
@property (nonatomic,strong) HFHomeViewModel* homeViewModel;

@end

@implementation HFHomeTableViewController
+(instancetype)viewControllerWithViewModel:(HFHomeViewModel*) viewModel
{
    HFHomeTableViewController *vc = [[HFHomeTableViewController alloc] init];
    vc.homeViewModel = viewModel;
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    MJRefreshStateHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //默认【上拉加载】
    self.tableView.mj_header = header;
    [header setTitle:@"人物，性格，情节……" forState:MJRefreshStateIdle];
    [header setTitle:@"有时候该放手也要放手" forState:MJRefreshStatePulling];
    [header setTitle:@"每个人内心都有一个压箱底的好故事" forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [[_homeViewModel.requestCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)refresh
{
    [self.homeViewModel getStorysList];
    [[self.homeViewModel.requestCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    }];
}
-(void)loadMore
{
    [self.homeViewModel loadMoreStorys];
}
-(void)setDate:(NSString *)date
{
    _homeViewModel =   [HFHomeViewModel HFHomeViewModelWithDate:date];
    [[_homeViewModel.requestCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.itemHeight[indexPath.row] floatValue];
}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(HFUIStoryView *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSTimeInterval duration = 0.0;
//    if([self.itemHeight[indexPath.row] floatValue] == cell.closeHeight){
//        //open cell
//
//        [cell unfold:NO animated:YES completion:nil];
//        duration = 0.4;
//    }else{
//        //close cell
//        [cell unfold:YES animated:YES completion:nil];
//        duration = 0.8;
//    }
//    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        [tableView beginUpdates];
//        [tableView endUpdates];
//    } completion:nil];
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HFUIStoryView * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSTimeInterval duration = 0.0;
    CGFloat interheight;
    if([self.itemHeight[indexPath.row] floatValue] == cell.closeHeight){
        //open cell
        interheight = cell.openHeight -cell.closeHeight;
        self.itemHeight[indexPath.row] = [NSNumber numberWithFloat:cell.openHeight];
        [cell unfold:YES animated:YES completion:nil];
        duration = 0.4;
    }else{
        //close cell
        interheight = cell.closeHeight -cell.openHeight;
        self.itemHeight[indexPath.row] = [NSNumber numberWithFloat:cell.closeHeight];
        [cell unfold:NO animated:YES completion:nil];
        duration = 0.8;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if(tableView.contentOffset.y+interheight>0)
        {
            [tableView setContentOffset:CGPointMake(0,tableView.contentOffset.y+interheight)];
        }
        [tableView beginUpdates];
        [tableView endUpdates];
    } completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _homeViewModel.storyList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFUIStoryView * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell %ld",(long)indexPath.row]];
    if (cell == nil) {
        cell = [[HFUIStoryView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell %ld",(long)indexPath.row]];
    }
    [cell setViewModel:[_homeViewModel.storyList objectAtIndex:indexPath.row]];
    return cell;
}
-(NSMutableArray *)itemHeight{
    if(_itemHeight == nil){
        _itemHeight = [NSMutableArray array];
        HFUIStoryView *cell = [[HFUIStoryView alloc] init];
        
        for(int i = 0; i < _homeViewModel.storyList.count; i ++){
            
            [cell setViewModel:[_homeViewModel.storyList objectAtIndex:i]];
            [_itemHeight addObject:[NSNumber numberWithFloat:cell.closeHeight]];
        }
    }
    
    return _itemHeight;
}
@end


