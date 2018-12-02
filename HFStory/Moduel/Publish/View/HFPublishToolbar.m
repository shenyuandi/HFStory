//
//  HFPublishToolbar.m
//  HFStory
//
//  Created by 沈子琦 on 2018/12/1.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFPublishToolbar.h"
@interface HFPublishToolbar ()
@end
@implementation HFPublishToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];

//    [_originalBtn setImage:[UIImage imageNamed:@"原创-选中"] forState:UIControlStateSelected];
    [[_originalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        BOOL select = x.isSelected;
        [x setSelected:!select];
    }];
}
-(IBAction)photoPicker:(UIBarButtonItem *)btnItem
{
}
- (IBAction)original:(UIButton *)sender {
}
@end
