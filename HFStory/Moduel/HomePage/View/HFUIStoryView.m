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
#import <DYKit.h>
@interface HFUIStoryView()
@property (strong, nonatomic) UITableView *containerTableview;
@end
@implementation HFUIStoryView
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.layer.cornerRadius = 8;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.ct_height = 62+85;
    _containerTableview = [[UITableView alloc] initWithFrame:CGRectMake(0,62, self.ct_width, 600)];
    [_containerTableview setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:_containerTableview];
    [_containerTableview assemblyByReuseIdentifier:@"HFStorySectionView" withAssemblyBlock:^(HFStorySectionView* cell, HFStorySectionViewModel *model, NSIndexPath *indexPath) {
        [cell setViewModel:model];;
        self.ct_height += cell.ct_height;
    }];
    [_containerTableview setHeightForRowAtIndexPath:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return [tableView.dy_agent tableView:tableView cellForRowAtIndexPath:indexPath].ct_height;
    }];
//    [[_containerTableview didSelectRowAtIndexPathSignal] subscribeNext:^(RACTuple* x) {
//        UITableView *tv =x.first;
//        NSIndexPath *indexPath  = x.second;
//        if (indexPath.section == [tv numberOfSections]-1) {
//            if (indexPath.row == [tv numberOfRowsInSection:indexPath.section]) {
//                NSLog(@"sss");
//            }
//        }
//       
//    }];
    return self;
}
-(void)setViewModel:(HFStoryViewModel*) storyViewModel
{
    _containerTableview.dy_data = storyViewModel.storySectionViewModleArray;
    self.nickNameLabel.text = storyViewModel.nickNameString;
    self.creatTimeLabel.text = storyViewModel.creatTimeString;
    self.storyTitleLabel.text = storyViewModel.stroyTitleString;
}
-(void)layoutSubviews
{
    [_containerTableview topInContainer:62 shouldResize:NO];
    [_containerTableview bottomInContainer:85 shouldResize:YES];
    [_containerTableview fillWidth];
    [self.originalImageView setFrame:CGRectMake(19, 25, 41, 22)];
    [self.headerImageView setFrame:CGRectMake(69.5, 22, 26.5, 26.5)];
    [self.nickNameLabel setFrame:CGRectMake(104, 26, 84, 20)];
    //  [self layoutLabel:self.creatTimeLabel];
    [self.creatTimeLabel rightInContainer:20 shouldResize:NO];
    [self.creatTimeLabel topInContainer:26 shouldResize:NO];
    [self.creatTimeLabel sizeToFit];
    [self.likeBtn bottomInContainer:15.5 shouldResize:NO];
    [_likeBtn rightInContainer:18.5 shouldResize:NO ];
    [self.shareBtn centerXEqualToView:self];
    [_shareBtn centerYEqualToView:_likeBtn];
    [self.commentBtn leftInContainer:18.5 shouldResize:NO ];
    [_commentBtn centerYEqualToView:_likeBtn];
}
-(void)layoutLabel:(YYLabel *)label
{
    if (label.text) {
        
        NSString *string = label.text;
        //设置多行
        label.numberOfLines = 0;
        //这个属性必须设置，多行才有效
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
        
        attri.yy_font = [UIFont systemFontOfSize:15];
        [attri setYy_lineSpacing:9];
        //用label的attributedText属性来使用富文本
        label.attributedText = attri;
        label.textAlignment = NSTextAlignmentLeft;
        [label setTextVerticalAlignment:YYTextVerticalAlignmentTop];
        //自动换行，改变label高度，即自适应高度，注音⚠️：多行显示的label，必须设置该属性，否则需自行添加高度
        label.preferredMaxLayoutWidth = CGRectGetWidth(self.frame) - 30;
        CGSize maxSize = CGSizeMake(label.preferredMaxLayoutWidth, MAXFLOAT);
        //计算文本尺寸
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:attri];
        label.textLayout = layout;
        CGFloat introHeight = layout.textBoundingSize.height;
        
        [label setCt_size:CGSizeMake(maxSize.width, introHeight)];
    }
}
#pragma mark - getter
-(UIImageView*)headerImageView
{
    if (!_headerImageView) {
        UIImageView *view = [[UIImageView alloc] init];
        [view setImage:[UIImage imageNamed:@"大"]];
        _headerImageView = view;
        [self.contentView addSubview:_headerImageView];
    }
    
    return _headerImageView;
}
-(UILabel *)storyTitleLabel
{
    if (!_storyTitleLabel) {
        UILabel *label = [[UILabel alloc] init];
        _storyTitleLabel = label;
        [self.contentView addSubview:_storyTitleLabel];
    }
    
    return _storyTitleLabel;
    
}
-(UIImageView *)originalImageView
{
    if (!_originalImageView) {
        UIImageView *label = [[UIImageView alloc] init];
        _originalImageView = label;
        [_originalImageView setImage:[UIImage imageNamed:@"原创"]];
        [self.contentView addSubview:_originalImageView];
    }
    
    return _originalImageView;
}
-(UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1/1.0];
        _nickNameLabel = label;
        [self.contentView addSubview:_nickNameLabel];
    }
    
    return _nickNameLabel;
}
-(YYLabel *)creatTimeLabel
{
    if (!_creatTimeLabel) {
        YYLabel *label = [[YYLabel alloc] init];
        _creatTimeLabel = label;
        [self addSubview:_creatTimeLabel];
    }
    
    return _creatTimeLabel;
}
-(UIButton*)likeBtn
{
    if (!_likeBtn) {
        UIButton *btn = [[UIButton alloc] init];
        NSString *str = @"共鸣(100000)";
        [btn setImage:[UIImage imageNamed:@"爱心"] forState:UIControlStateNormal];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        [btn setTitleColor: [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        [btn setCt_size:CGSizeMake(titleSize.width+btn.currentImage.size.width+6, btn.currentImage.size.width)];
        //btn.hidden= YES;
        _likeBtn = btn;
        [self.contentView addSubview:_likeBtn];
    }
    
    return _likeBtn;
}
-(UIButton*)shareBtn
{
    if (!_shareBtn) {
        UIButton *btn = [[UIButton alloc] init];
        NSString *str = @"分享(100)";
        [btn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        [btn setTitleColor: [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        [btn setCt_size:CGSizeMake(titleSize.width+btn.currentImage.size.width+6, btn.currentImage.size.width)];
        //btn.hidden= YES;
        _shareBtn = btn;
        [self.contentView addSubview:_shareBtn];
    }
    
    return _shareBtn;
}
-(UIButton*)commentBtn
{
    if (!_commentBtn) {
        UIButton *btn = [[UIButton alloc] init];
        NSString *str = @"回复(10000)";
        [btn setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateNormal];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        [btn setTitleColor: [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        
        [btn setCt_size:CGSizeMake(titleSize.width+btn.currentImage.size.width+6, btn.currentImage.size.width)];
        //btn.hidden= YES;
        _commentBtn = btn;
        [self.contentView addSubview:_commentBtn];
    }
    
    return _commentBtn;
}
@end

