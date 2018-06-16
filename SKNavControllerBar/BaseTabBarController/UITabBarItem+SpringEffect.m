//
//  UITabBarItem+SpringEffect.m
//  SKNavControllerBar
//
//  Created by housenkui on 2018/6/16.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import "UITabBarItem+SpringEffect.h"

@implementation UITabBarItem (SpringEffect)
- (UIControl *)SK_barButton{
    return [self valueForKey:@"view"];
}
- (UIImageView *)SK_TabImageView {
    UIControl *barButton = [self SK_barButton];
    if (!barButton) {
        return nil;
    }
    for (UIView *subView in barButton.subviews) {
        if ([NSStringFromClass([subView class]) isEqualToString:@"UITabBarSwappableImageView"]) {
            return (UIImageView *)subView;
        }
        if([[[UIDevice currentDevice]systemVersion]doubleValue] <10){
            if ([subView isKindOfClass:[UIImageView class]] &&![NSStringFromClass([subView class]) isEqualToString:@"UITabBarSelectionIndicatorView"] ) {
                return (UIImageView *)subView;
            }
        }
    }
    return nil;
}
@end
