//
//  BaseViewController.m
//  SKProject01
//
//  Created by 侯森魁 on 2017/9/13.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (SKNavigationBar *)navBar{
    if (!_navBar) {
        _navBar = [[SKNavigationBar alloc]initWithFrame:CGRectZero];
    }
    return _navBar;
}
- (WKWebView*)wkWebView{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc]init];
        
    }
    return _wkWebView;
}

- (void)loadWithURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [self.wkWebView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.navBar];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.width.equalTo(self.view);
        make.height.mas_equalTo(Height_NavBar);
    }];
    
//    [self.view addSubview:self.wkWebView];
//    
//    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.width.equalTo(self.view);
//        make.top.equalTo(self.view).offset(Height_NavBar);
//        make.bottom.equalTo(self.view).offset(-Height_TabBar_SafeArea);
//    }];
    
    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigation_head"]];
//    [self.navBar setBackgroundView:imageView];
    
}

@end
