//
//  HFStorySectionView.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/23.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFStorySectionView.h"
#import <YYWebImage.h>
#import <YYText.h>


@implementation HFStorySectionView
-(void)layoutSubviews
{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[YYLabel class]]) {
            [v widthEqualToView:self];
            [v leftInContainer:8 shouldResize:NO];
            [v rightInContainer:8 shouldResize:YES];
        }
        else if([v isKindOfClass:[UIImageView class]])
        {
            [v centerXEqualToView:self];
        }
    }
}
-(void)setViewModel:(HFStorySectionViewModel *) storySectionViewModel
{
    self.ct_height = 0;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    //  [self widthEqualToView:self.superview];
    for (HFStoryElementViewModel *viewModel in storySectionViewModel.storyElementViewModleArray) {
        
        if ([viewModel.model.type isEqualToString:@"text"]) {
            YYLabel *label = [[YYLabel alloc] init];
            label.ct_y = self.ct_height;
            [self addSubview:label];
            label.text = viewModel.model.content;
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByCharWrapping;
            label.textAlignment = NSTextAlignmentLeft;
            label.preferredMaxLayoutWidth = 2;
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:viewModel.model.content];
            attri.yy_font = [UIFont systemFontOfSize:15];
            [attri setYy_lineSpacing:9];
            CGSize size = CGSizeMake(self.ct_width, CGFLOAT_MAX);
            //设置label的frame
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attri];
            label.textLayout = layout;
            label.attributedText = attri;
            label.ct_height = layout.textBoundingSize.height;
            label.ct_width = size.width;
            label.userInteractionEnabled = NO;
            self.ct_height += label.ct_height;
        }
        else if ([viewModel.model.type isEqualToString:@"pic"])
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,viewModel.model.width,viewModel.model.height)];
            imageView.ct_y = self.ct_height;
            [self addSubview:imageView];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView centerXEqualToView:self];
            [imageView yy_setImageWithURL:[NSURL URLWithString:viewModel.model.content]  placeholder:[UIImage imageNamed:@"大"] options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {}];
            self.ct_height += imageView.ct_height;
        }
        
    }
}
@end


