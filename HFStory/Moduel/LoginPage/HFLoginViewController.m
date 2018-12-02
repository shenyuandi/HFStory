//
//  HFLoginViewController.m
//  HFStory
//
//  Created by 沈子琦 on 2018/11/19.
//  Copyright © 2018 沈子琦. All rights reserved.
//

#import "HFLoginViewController.h"

@interface HFLoginViewController ()
@property(strong,nonatomic)UIButton *loginBtn;
@end

@implementation HFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.ct_size = CGSizeMake(SCREEN_WIDTH, 240);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 25, 25)];
        [btn setImage:[UIImage imageNamed:@"大"] forState:UIControlStateNormal];
        _loginBtn= btn;
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
    
    
}
@end

