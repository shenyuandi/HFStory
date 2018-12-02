//
//  HFStoryHeaderView.m
//  HFStory
//
//  Created by 沈子琦 on 2018/11/8.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFStoryHeaderView.h"

@implementation HFStoryHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews
{
    [self.originalImageView setFrame:CGRectMake(19, 25, 41, 22)];
    [self.headerImageView setFrame:CGRectMake(69.5, 22, 26.5, 26.5)];
    [self.nickNameLabel setFrame:CGRectMake(104, 26, 84, 20)];
    [self.creatTimeLabel rightInContainer:20 shouldResize:NO];
    [self.creatTimeLabel topInContainer:26 shouldResize:NO];
    [self.creatTimeLabel sizeToFit];
}
-(UIImageView*)headerImageView
{
    if (!_headerImageView) {
        UIImageView *view = [[UIImageView alloc] init];
        [view setImage:[UIImage imageNamed:@"大"]];
        _headerImageView = view;
        [self addSubview:_headerImageView];
    }
    
    return _headerImageView;
}
-(UIImageView *)originalImageView
{
    if (!_originalImageView) {
        UIImageView *label = [[UIImageView alloc] init];
        _originalImageView = label;
        [_originalImageView setImage:[UIImage imageNamed:@"原创"]];
        [self addSubview:_originalImageView];
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
        [self addSubview:_nickNameLabel];
    }
    
    return _nickNameLabel;
}
-(YYLabel *)creatTimeLabel
{
    if (!_creatTimeLabel) {
        YYLabel *label = [[YYLabel alloc] init];
        label.textColor =  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
        _creatTimeLabel = label;
        [self addSubview:_creatTimeLabel];
    }
    return _creatTimeLabel;
}
@end
