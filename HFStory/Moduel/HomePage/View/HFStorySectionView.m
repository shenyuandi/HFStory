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
#import <DYKit.h>
@implementation HFStoryElementView
-(void)setViewModel:(HFStoryElementViewModel *) storyElemntViewModel
{
    if ([storyElemntViewModel.type isEqualToString:@"text"]) {
        YYLabel *label = [[YYLabel alloc] init];
        [self addSubview:label];
        label.text = storyElemntViewModel.content;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.textAlignment = NSTextAlignmentLeft;
        label.preferredMaxLayoutWidth = 2;
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:storyElemntViewModel.content];
        attri.yy_font = [UIFont systemFontOfSize:15];
        [attri setYy_lineSpacing:9];
        CGSize size = CGSizeMake(self.ct_width, CGFLOAT_MAX);
        //设置label的frame
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:attri];
        label.textLayout = layout;
        label.attributedText = attri;
        label.ct_height = layout.textBoundingSize.height;
        label.ct_width = size.width;
        self.ct_height = label.ct_height;
    }
    else if ([storyElemntViewModel.type isEqualToString:@"pic"])
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,80,80)];
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.ct_height = imageView.ct_height;
        [imageView centerXEqualToView:self];
        [imageView yy_setImageWithURL:[NSURL URLWithString:storyElemntViewModel.content]  placeholder:[UIImage imageNamed:@"大"] options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {}];
    }
}
@end
@interface HFStorySectionView ()
@property (strong, nonatomic) UITableView *containerTableview;
@end
@implementation HFStorySectionView
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.userInteractionEnabled = YES;
    [self setBackgroundColor:[UIColor whiteColor]];
    _containerTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.ct_width, SCREEN_HEIGHT)];
    _containerTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _containerTableview.userInteractionEnabled = NO;
    [self addSubview:_containerTableview];
    @weakify(self);
    [_containerTableview assemblyByReuseIdentifier:@"HFStoryElementView" withAssemblyBlock:^(HFStoryElementView *cell, HFStoryElementViewModel *model, NSIndexPath *indexPath) {
        @strongify(self);
        [cell widthEqualToView:self];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setViewModel:model];
        self.ct_height += cell.ct_height;
    }];
    [_containerTableview setHeightForRowAtIndexPath:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return [tableView.dy_agent tableView:tableView cellForRowAtIndexPath:indexPath].ct_height;
    }];
    return self;
}
-(void)layoutSubviews
{
    [_containerTableview sizeEqualToView:self];
}
-(void)setViewModel:(HFStorySectionViewModel *) storySectionViewModel
{
    self.ct_height = 0;
    _containerTableview.dy_data = storySectionViewModel.storyElementViewModleArray;
}
@end
