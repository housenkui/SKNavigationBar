//
//  BaseViewController.h
//  SKProject01
//
//  Created by 侯森魁 on 2017/9/13.
//  Copyright © 2017年 侯森魁. All rights reserved.
//


@interface BaseViewController : UIViewController

@property (nonatomic,strong) SKNavigationBar *navBar;
@property (nonatomic,strong) WKWebView *wkWebView;
- (void)loadWithURL:(NSString *)urlString;
@end
