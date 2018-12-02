//
//  HFUIStoryView.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/13.
//  Copyright © 2018 沈子琦. All rights reserved.
//
#import "HFUIStoryView.h"
#import <YYText.h>
#import <YYWebImage.h>
#import <UIView+LayoutMethods.h>
#import "HFStorySectionView.h"
@interface HFUIStoryView()
@end
@implementation HFUIStoryView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.ct_height = 0;
        self.backgroundColor = [UIColor clearColor];
        
        self.foregroundView = [self createForegroundView];
        self.containerView = [self createContainerView];
        self.containerView.alpha = 0;
        self.interView.alpha = 0;
    }

    return self;
}
-(void)setViewModel:(HFStoryViewModel*) storyViewModel
{
    [self.beginningSectionView setViewModel:storyViewModel.outlines];
    
    
    //重新设置前景视图的高度
    self.foregroundView.ct_height = self.beginningSectionView.ct_height+self.headerView.ct_height+8;
    
    [self.enddingSectionView setViewModel:storyViewModel.particulars];
    self.headerView.nickNameLabel.text = storyViewModel.storyModel.ownerName;
    self.headerView.creatTimeLabel.text = storyViewModel.creatTimeString;

    [self.commentBtn setTitle:storyViewModel.commentNumberString forState:UIControlStateNormal];
    [self.likeBtn setTitle:storyViewModel.likeNumberString forState:UIControlStateNormal];
    
    
    self.containerView.ct_height = self.enddingSectionView.ct_height+85;
    _openHeight = self.foregroundView.ct_height +self.containerView.ct_height+ 17;
    _closeHeight = self.foregroundView.ct_height+17;
   // self.ct_height = self.foregroundView.ct_height + self.containerView.ct_height + 8;
}
-(void)layoutSubviews
{

    [self.interView top:-10 FromView:self.foregroundView];
    [self.interView rightInContainer:17 shouldResize:NO];
    [self.interView leftInContainer:17 shouldResize:YES];
    self.interView.ct_height = 30;

    
    [self.interView widthEqualToView:self.foregroundView];
    [self.foregroundView topInContainer:8 shouldResize:NO];
    [self.foregroundView centerXEqualToView:self.contentView];
    [self.foregroundView rightInContainer:17 shouldResize:NO];
    [self.foregroundView leftInContainer:17 shouldResize:YES];
    
    [self.headerView widthEqualToView:self.foregroundView];
    
    [self.containerView top:8 FromView:self.foregroundView];
    [self.containerView centerXEqualToView:self.contentView];
    [self.containerView rightInContainer:17 shouldResize:NO];
    [self.containerView leftInContainer:17 shouldResize:YES];
    self.containerView.ct_height = self.enddingSectionView.ct_height+85;

    
    [self.beginningSectionView  top:5 FromView:self.headerView];
    [self.beginningSectionView  widthEqualToView:self.foregroundView];
    [self.enddingSectionView  widthEqualToView:self.foregroundView];
    
    [self.likeBtn bottomInContainer:15.5 shouldResize:NO];
    [self.likeBtn setCt_size:CGSizeMake(self.superview.ct_size.width/3, 50)];
    [_likeBtn rightInContainer:0 shouldResize:NO ];
    [self.shareBtn centerXEqualToView:self];
    [self.shareBtn sizeEqualToView:self.likeBtn];
    [_shareBtn centerYEqualToView:_likeBtn];
    [self.commentBtn leftInContainer:0 shouldResize:NO ];
    [_commentBtn centerYEqualToView:_likeBtn];
    [self.commentBtn sizeEqualToView:self.likeBtn];
}
- (void)unfold:(BOOL)value animated:(BOOL)animated completion:(void (^)(void))completion{
    [self layoutSubviews];
    [UIView animateWithDuration:0.4 animations:^{
        self.interView.alpha = value?1:0;
        self.containerView.alpha = value?1:0;
    }];
}


#pragma mark - getter
-(UIView *)interView
{
    if (!_interView) {
        _interView = [[UIView alloc] init];
        [_interView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView insertSubview:_interView atIndex:0];
    }
    return _interView;
}
- (UIView *)createForegroundView{
    UIView * foregroundView = [[UIView alloc] initWithFrame:CGRectZero];
    foregroundView.backgroundColor = [UIColor whiteColor];
    foregroundView.translatesAutoresizingMaskIntoConstraints = NO;
    foregroundView.clipsToBounds = YES;
    foregroundView.layer.cornerRadius = 10;
    [self.contentView addSubview:foregroundView];
    [foregroundView layoutIfNeeded];
    return foregroundView;
}

- (UIView *)createContainerView{
    UIView * containerView = [[UIView alloc] initWithFrame:CGRectZero];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.clipsToBounds = YES;
    containerView.layer.cornerRadius = 10;
    
    [containerView addSubview:self.enddingSectionView];
    [containerView addSubview:self.likeBtn];
    [containerView addSubview:self.shareBtn];
    [containerView addSubview:self.commentBtn];
    [self.contentView addSubview:containerView];
    
    [containerView layoutIfNeeded];
    
    return containerView;
}
-(HFStoryHeaderView*)headerView
{
    if (!_headerView) {
        HFStoryHeaderView *sectionView = [[HFStoryHeaderView alloc] init];
        sectionView.ct_height = 65;
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        _headerView= sectionView;
        
        [self.foregroundView addSubview:_headerView];
    }
    
    return _headerView;
}
-(HFStorySectionView*)beginningSectionView
{
    if (!_beginningSectionView) {
        HFStorySectionView *sectionView = [[HFStorySectionView alloc] init];
        [sectionView widthEqualToView:self];
        _beginningSectionView = sectionView;
        [self.foregroundView addSubview:_beginningSectionView];
    }
    
    return _beginningSectionView;
}
-(HFStorySectionView*)enddingSectionView
{
    if (!_enddingSectionView) {
        HFStorySectionView *sectionView = [[HFStorySectionView alloc] init];
        [sectionView widthEqualToView:self];
        _enddingSectionView = sectionView;
        [self.containerView addSubview:_enddingSectionView];
    }
    
    return _enddingSectionView;
}
-(YYLabel*)storyTileLabel
{
    if (!_storyTileLabel) {
        YYLabel *lable = [[YYLabel alloc] init];
        _storyTileLabel = lable;
        [self.containerView addSubview:_storyTileLabel];
    }
    return _storyTileLabel;
}
-(UIButton*)likeBtn
{
    if (!_likeBtn) {
        UIButton *btn = [[UIButton alloc] init];
        
        [btn setImage:[UIImage imageNamed:@"爱心"] forState:UIControlStateNormal];
        //   [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        [btn setTitleColor: [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        //    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        // [btn setCt_size:CGSizeMake(titleSize.width+btn.currentImage.size.width+6, btn.currentImage.size.width)];
        _likeBtn = btn;
        [self.containerView addSubview:_likeBtn];
    }
    
    return _likeBtn;
}
-(UIButton*)shareBtn
{
    if (!_shareBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        btn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        [btn setTitleColor: [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        // CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        // [btn setCt_size:CGSizeMake(titleSize.width+btn.currentImage.size.width+6, btn.currentImage.size.width)];
        _shareBtn = btn;
        [self.containerView addSubview:_shareBtn];
    }
    
    return _shareBtn;
}
-(UIButton*)commentBtn
{
    if (!_commentBtn) {
        UIButton *btn = [[UIButton alloc] init];
        // NSString *str = @"回复(10000)";
        [btn setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateNormal];
        btn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        [btn setTitleColor: [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        // CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        _commentBtn = btn;
        [self.containerView addSubview:_commentBtn];
    }
    return _commentBtn;
}
@end












