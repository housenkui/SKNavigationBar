//
//  FirstViewController.m
//  SKNavControllerBar
//
//  Created by housenkui on 2018/4/15.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    [self.navBar setTitleWithString:@"新闻"];
//    __weak typeof (self) weakSelf = self;

    NavBtnParams *param = [[NavBtnParams alloc]init];
    param.btnTitle = @"返回";
    param.backgroundImg = [UIImage imageNamed:@"backImage"];
    param.backgroundSelectImg = [UIImage imageNamed:@"backImage"];

    param.onClick = ^{
        if ([self.wkWebView canGoBack]) {
            [self.wkWebView goBack];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };

    NavBtnParams *param0 = [[NavBtnParams alloc]init];
    param0.btnTitle = @"关闭";
    param0.onClick = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };

    //self 持有 self.navBar,而self.navBar持有 临时变量param，而临时变量param又持有self,这就才造成了循环持有指针,所有不用__weak，不行！！！
    [self.navBar showLeftButtons:@[param,param0]];

    NavBtnParams *paramRight = [[NavBtnParams alloc]init];
    paramRight.backgroundImg = [UIImage imageNamed:@"icon_light"];
    paramRight.backgroundSelectImg = [UIImage imageNamed:@"icon_light"];
    paramRight.onClick = ^{
        NSLog(@"点击了右");
    };

    
    [self.navBar showRightButtons:@[paramRight]];
    
    [self.view addSubview:self.wkWebView];

    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(Height_NavBar);
        make.bottom.equalTo(self.view).offset(-Height_TabBar_SafeArea);
    }];
    NSString *string = [NSString stringWithFormat:@"https:www.baidu.com/#/?kyd_token=%d",arc4random()%10000];
    [self loadWithURL:string];


    // Do any additional setup after loading the view.
}

- (void)dealloc{
    NSLog(@"sssssss%s", __FUNCTION__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
