//
//  HFHomeNavigationBarTitleTextView.m
//  HFStory
//
//  Created by 沈子琦 on 2018/10/22.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFHomeNavigationBarTitleTextView.h"
#import "CWCalendarLabel.h"
#import "UIColor+Hex.h"
#import "NSString+ONEComponents.h"
#define kYearLabelWidth 60.0
#define kLabelWidth 40.0
#define kLabelHeight 25.0
#define kSlashWidth 10
@interface HFHomeNavigationBarTitleTextView ()

@property (weak, nonatomic) CWCalendarLabel *yearLabel;
@property (weak, nonatomic) CWCalendarLabel *monthLabel;
@property (weak, nonatomic) CWCalendarLabel *dayLabel;
@property (weak, nonatomic) UILabel *leftSlashLabel;
@property (weak, nonatomic) UILabel *rightSlashLabel;
@property (weak, nonatomic) UILabel *lastSlashLabel;

@end
@implementation HFHomeNavigationBarTitleTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpLabels];
          self.backgroundColor = MainBGC;
    }
    return self;
}

- (void)setUpLabels {
    CWCalendarLabel *monthLabel = [[CWCalendarLabel alloc] init];
    monthLabel.bounds = CGRectMake(0, 0, kLabelWidth, kLabelHeight);
    [self addSubview:monthLabel];
    self.monthLabel = monthLabel;
    
    UILabel *leftSlash = [[UILabel alloc] init];
    leftSlash.bounds = CGRectMake(0,0,kSlashWidth,kLabelHeight);
    [self addSubview:leftSlash];
    self.leftSlashLabel = leftSlash;
    
    CWCalendarLabel *yearLabel = [[CWCalendarLabel alloc] init];
    yearLabel.bounds = CGRectMake(0, 0, kYearLabelWidth, kLabelHeight);
    [self addSubview:yearLabel];
    self.yearLabel = yearLabel;
    
    UILabel *rightSlash = [[UILabel alloc] init];
    rightSlash.bounds = CGRectMake(0,0,kSlashWidth,kLabelHeight);
    [self addSubview:rightSlash];
    self.rightSlashLabel = rightSlash;
    
    CWCalendarLabel *dayLabel = [[CWCalendarLabel alloc] init];
    dayLabel.bounds = CGRectMake(0, 0, kLabelWidth, kLabelHeight);
    [self addSubview:dayLabel];
    self.dayLabel = dayLabel;
    
    UILabel *lastSlash = [[UILabel alloc] init];
    lastSlash.bounds = CGRectMake(0,0,kSlashWidth,kLabelHeight);
    [self addSubview:lastSlash];
    self.lastSlashLabel = lastSlash;
    
    [self setUpOneLabelsProperty:self.monthLabel];
    [self setUpOneLabelsProperty:self.yearLabel];
    [self setUpOneLabelsProperty:self.dayLabel];
    [self setUpOneLabelsProperty:self.leftSlashLabel];
    [self setUpOneLabelsProperty:self.rightSlashLabel];
    [self setUpOneLabelsProperty:self.lastSlashLabel];
}

- (void)setUpOneLabelsProperty:(UILabel *)label {
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor =  [UIColor colorWithRed:236/255.0 green:237/255.0 blue:251/255.0 alpha:1/1.0];
    label.font = [UIFont fontWithName:ONEThemeFontName size:15];
    if ([label isKindOfClass:[CWCalendarLabel class]]) {
        CWCalendarLabel *calendarLabel = (CWCalendarLabel *)label;
        calendarLabel.animateDuration = 0.35;
        calendarLabel.enableWhenSame = NO;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.yearLabel leftInContainer:40 shouldResize:NO];
    self.monthLabel.center = CGPointMake(165, self.ct_height * 0.5);
    self.leftSlashLabel.ct_centerY = self.ct_height * 0.5;
    [self.leftSlashLabel right:0 FromView:self.yearLabel];
    [self.monthLabel right:0 FromView:self.leftSlashLabel];
    self.yearLabel.ct_centerY = self.ct_height * 0.5;
    //[self.yearLabel centerYEqualToView:self];
    //    self.yearLabel.ct_x = self.leftSlashLabel.ct_x - kYearLabelWidth;
    self.rightSlashLabel.ct_centerY = self.ct_height * 0.5;
    [self.rightSlashLabel right:0 FromView:self.monthLabel];
    self.dayLabel.ct_centerY = self.ct_height * 0.5;
    [self.dayLabel right:0 FromView:self.rightSlashLabel];
    [self.lastSlashLabel right:0 FromView:self.dayLabel];
    [self.lastSlashLabel centerYEqualToView:self];
}


- (void)setDateString:(NSString *)dateString {
    NSDateComponents *components = [dateString getComponents];
    NSString *yearStr = [NSString stringWithFormat:@"%ld",components.year];
    NSString *monthStr = [NSString stringWithFormat:@"%02ld",components.month];
    NSString *dayStr = [NSString stringWithFormat:@"%02ld",components.day];
    
    self.leftSlashLabel.text = @"年";
    [self.leftSlashLabel sizeToFit];
    self.rightSlashLabel.text = @"月";
    [self.rightSlashLabel sizeToFit];
    self.lastSlashLabel.text = @"日";
    [self.lastSlashLabel sizeToFit];
    // 仅赋值，不做动画
    if (_dateString == nil) {
        self.yearLabel.text = yearStr;
        [self.yearLabel sizeToFit];
        self.monthLabel.text = monthStr;
        [self.monthLabel sizeToFit];
        self.dayLabel.text = dayStr;
        [self.dayLabel sizeToFit];
    } else {
        CWCalendarLabelScrollDirection direction = [_dateString isLaterThanAnotherDateString:dateString] ? CWCalendarLabelScrollToTop : CWCalendarLabelScrollToBottom;
        [self.yearLabel showNextText:yearStr withDirection:direction];
        [self.monthLabel showNextText:monthStr withDirection:direction];
        [self.dayLabel showNextText:dayStr withDirection:direction];
    }
    _dateString = dateString;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

