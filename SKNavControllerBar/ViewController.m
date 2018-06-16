//
//  ViewController.m
//  SKNavControllerBar
//
//  Created by housenkui on 2018/4/5.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navBar setTitleWithString:@"首页"];

    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self testButton];
    NSLog(@"");
}
- (void)testButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试按钮1" forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(100, 100, 100, 40);
    [self.view addSubview:button];
    
    
    button.click = ^{
        FirstViewController *vc = [[FirstViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    UIButton *button2 = [UIButton new];
    [button2 setTitle:@"测试按钮2" forState:UIControlStateNormal];
    
    button2.backgroundColor = [UIColor blueColor];
    button2.frame = CGRectMake(100, 200, 100, 40);
    [self.view addSubview:button2];

    
    button2.click = ^{
        SecondViewController *vc2 = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:vc2 animated:YES];
    };
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));

}

@end
