//
//  BaseNavigationController.m
//  WebView
//
//  Created by 侯森魁 on 2017/9/6.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
// 记录push标志
@property (nonatomic, getter=isPushing) BOOL pushing;

@property(nullable, nonatomic, readwrite) UIGestureRecognizer *fullInteractivePopGestureRecognizer;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    self.navigationBar.translucent = NO;
    
    self.delegate = self;

    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIView *view = self.interactivePopGestureRecognizer.view;
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    
    self.fullInteractivePopGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    self.fullInteractivePopGestureRecognizer.delaysTouchesBegan = YES;
    self.fullInteractivePopGestureRecognizer.delegate = self;
    [view addGestureRecognizer:self.fullInteractivePopGestureRecognizer];
    

    // Do any additional setup after loading the view.
}

#pragma mark--给手势添加事件
- (void)addTarget{
    id target = self.interactivePopGestureRecognizer.delegate;
    
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    
    [self.fullInteractivePopGestureRecognizer  addTarget:target action:action];
    
}
#pragma mark--给手势移除事件

- (void)removeTarget{
    
    id target = self.interactivePopGestureRecognizer.delegate;
    
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    
    [self.fullInteractivePopGestureRecognizer removeTarget:target action:action];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 左滑时可能与UITableView左滑删除手势产生冲突
    CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0)
    {
        return NO;
    }
    
    // 跟视图控制器不响应手势
    return ([self.viewControllers count] == 1) ? NO : YES;
}
#pragma mark --防止多次push

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.pushing) {
        NSLog(@"被拦截");
        return;
    } else {
        NSLog(@"push");
        self.pushing = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}

@end
