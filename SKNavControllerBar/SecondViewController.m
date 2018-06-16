//
//  SecondViewController.m
//  SKNavControllerBar
//
//  Created by housenkui on 2018/4/15.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    [self.navBar setTitleWithString:@"新闻"];
    
    NavBtnParams *param = [[NavBtnParams alloc]init];
    param.btnTitle = @"返回";
    param.backgroundImg = [UIImage imageNamed:@"backImage"];
    param.backgroundSelectImg = [UIImage imageNamed:@"backImage"];
    
    param.onClick = ^{
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [self.navBar showLeftButtons:@[param]];
}

@end
