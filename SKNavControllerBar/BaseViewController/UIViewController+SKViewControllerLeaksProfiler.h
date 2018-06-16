//
//  UIViewController+SKViewControllerLeaksProfiler.h
//  SKNavControllerBar
//
//  Created by housenkui on 2018/6/16.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark ================用于检测viewController实例是否正常释放===============
typedef void(^DeallocBlock)(void);

@interface UIViewController (SKViewControllerLeaksProfiler)
-(void)sk_viewDidDisappear:(BOOL)animated;
- (void)sk_dealloc;
@property (nonatomic,copy) DeallocBlock deallocBlock;

@end
