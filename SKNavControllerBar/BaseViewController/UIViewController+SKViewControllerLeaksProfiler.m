//
//  UIViewController+SKViewControllerLeaksProfiler.m
//  SKNavControllerBar
//
//  Created by housenkui on 2018/6/16.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import "UIViewController+SKViewControllerLeaksProfiler.h"
#import <objc/runtime.h>
static const void *associateKey = "associateKey1";

@implementation UIViewController (SKViewControllerLeaksProfiler)

- (void)setDeallocBlock:(DeallocBlock)click {
    objc_setAssociatedObject(self, associateKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (DeallocBlock)deallocBlock {
    return objc_getAssociatedObject(self, associateKey);
}
//编译时方法交换
+ (void)load
{
   
//    [UIViewController swizzleInstanceMethod:@selector(viewDidDisappear:) with:@selector(sk_viewDidDisappear:)];
//    [UIViewController swizzleInstanceMethod:NSSelectorFromString(@"dealloc") with:@selector(sk_dealloc)];

}

-(void)sk_viewDidDisappear:(BOOL)animated{
    
    [self sk_viewDidDisappear:animated];
    NSLog(@" 等待%@实例释放中....",NSStringFromClass([self class]));
//    __weak typeof (self) weakSelf = self;
//    self.deallocBlock = ^{
//        NSLog(@" %@实例已经释放",NSStringFromClass([weakSelf class]));
//    };
}
- (void)sk_dealloc{
    
    if(self){
        NSLog(@" %@实例已经释放",NSStringFromClass([self class]));
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.deallocBlock();
//        });
    }
    [self sk_dealloc];
    
    
}
@end
