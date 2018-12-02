//
//  HFPublishViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/11/29.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFPublishViewController.h"
#import "ONENavigationBarTool.h"
#import "HFPublishToolbar.h"
#include "HFStoryViewModel.h"
#import <TZImagePickerController.h>
#import <YYTextView.h>
#import <NSAttributedString+YYText.h>
@interface HFPublishViewController ()<UIScrollViewDelegate,TZImagePickerControllerDelegate>
@property(weak,nonatomic)IBOutlet UIButton *backbtn;
@property(weak,nonatomic)IBOutlet UITextField *titleTextView;
@property(weak,nonatomic)IBOutlet YYTextView *beginningTextView;
@property(weak,nonatomic)IBOutlet YYTextView *enddingTextView;
@property(strong,nonatomic) HFStoryViewModel *storyViewModel;
@end

@implementation HFPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HFPublishToolbar *toolbar =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HFPublishToolbar class]) owner:nil options:nil].firstObject;
    HFPublishToolbar *toolbar1 =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HFPublishToolbar class]) owner:nil options:nil].firstObject;
    self.titleTextView.placeholder = @"好的标题会让你的故事更吸引人（可选）";
    // self.titleTextView.placeholderFont =  [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    //  self.titleTextView.placeholderTextColor =  [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1/1.0];
    self.titleTextView.backgroundColor = [UIColor whiteColor];
    
    self.beginningTextView.placeholderText = @"让我们先写故事的开头吧";
    self.beginningTextView.backgroundColor = [UIColor whiteColor];
    self.beginningTextView.placeholderFont =  [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    self.beginningTextView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    self.beginningTextView.placeholderTextColor =  [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1/1.0];
    self.beginningTextView.backgroundColor = [UIColor whiteColor];
    
    self.enddingTextView.placeholderText = @"你的故事必须有一个情理之中，意料之外的结尾";
    self.enddingTextView.placeholderFont =  [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    self.enddingTextView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    self.enddingTextView.placeholderTextColor =  [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1/1.0];
    self.enddingTextView.backgroundColor = [UIColor whiteColor];
    self.enddingTextView.backgroundColor = [UIColor whiteColor];
    
    
    _beginningTextView.inputAccessoryView = toolbar;
    
    _enddingTextView.inputAccessoryView = toolbar1;
    
    [[_backbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[toolbar.photoPickerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:5 delegate:self];
        imagePickerVc.allowPickingGif = YES;
        imagePickerVc.allowPickingVideo = NO;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }];
    [[toolbar1.photoPickerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 delegate:self];
        imagePickerVc.allowPickingGif = YES;
        imagePickerVc.allowPickingVideo = NO;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }];
    [self.beginningTextView top:10 FromView:self.titleTextView];
    [self.enddingTextView top:10 FromView:self.beginningTextView];
    //    RAC(toolbar.publishBtn, enabled) =  [RACSignal combineLatest:@[self.beginningTextView.rac_textSignal, self.enddingTextView.rac_textSignal,] reduce:^(NSAttributedString *beginningString, NSAttributedString *endingString){
    //        return @(beginningString.length > 0 && endingString.length > 0);
    //    }];
}




-(HFStoryViewModel *)storyViewModel
{
    if (!_storyViewModel) {
        _storyViewModel = [[HFStoryViewModel alloc] init];
    }
    return _storyViewModel;
}
-(UITextField*)titleTextView
{
    if (!_titleTextView) {
        UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, 50)];
        _titleTextView = textView;
        [self.view addSubview:textView];
    }
    return _titleTextView;
}
-(YYTextView *)beginningTextView
{
    if (!_beginningTextView) {
        YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, 180)];
        _beginningTextView = textView;
        textView.textContainerInset = UIEdgeInsetsMake(15, 20, 15, 20);
        [self.view addSubview:_beginningTextView];
    }
    return _beginningTextView;
}
-(YYTextView *)enddingTextView
{
    if (!_enddingTextView) {
        YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, 180)];
        textView.textContainerInset = UIEdgeInsetsMake(15, 20, 15, 20);
        _enddingTextView = textView;
        [self.view addSubview:_enddingTextView];
    }
    return _enddingTextView;
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [self addImage:photos toTextView:_beginningTextView];
    
}
-(void)addImage:(NSArray *)imageArray toTextView:(YYTextView *)textView
{
    NSMutableAttributedString *contentText = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:18];
    for (UIImage *Simage in imageArray) {
            //图片资源
        YYImage *image = [YYImage imageWithData:[Simage yy_imageDataRepresentation]];
        image.preloadAllAnimatedImageFrames = YES;
        
        //添加图片
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, textView.width - 10, textView.width/image.size.width*image.size.height);
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView.ct_size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [contentText appendAttributedString:attachText];
        textView.attributedText = contentText;
    }


    // [self.view addSubview:textView];
    
    //获取图片资源
    //    NSArray *attachments =  textView.textLayout.attachments;
    //    for(YYTextAttachment *attachment in attachments)
    //    {
    //        YYAnimatedImageView *imageView = attachment.content;
    //        YYImage *image = (YYImage *)imageView.image;
    //        NSLog(@"获取到图片:%@",image);
    //    }
    //    NSArray *attachmentRanges = textView.textLayout.attachmentRanges;
    //    for (NSValue *range in attachmentRanges)
    //    {
    //        NSRange r = [range rangeValue];
    //        NSLog(@"资源所在位置：%ld 长度: %ld",r.location,r.length);
    //    }
    
}
@end



