//
//  UITabBarItem+SpringEffect.m
//  SKNavControllerBar
//
//  Created by housenkui on 2018/6/16.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import "UITabBarItem+SpringEffect.h"
#define IOS_VERSION ([[[UIDevice currentDevice]systemVersion]doubleValue])
@implementation UITabBarItem (SpringEffect)
- (UIControl *)SK_barButton{
    return [self valueForKey:@"view"];//私有API
}
- (UIImageView *)SK_TabBarImageView {
    NSLog(@"所有属性 = %@",[UITabBarItem getAllProperties:self]);
    [UITabBarItem LogAllMethodsFromClass:self];

    UIControl *barButton = [self SK_barButton];
    
    if (!barButton) {
        return nil;
    }
    for (UIView *subView in barButton.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            return (UIImageView *)subView;
        }
        if(IOS_VERSION < 10){
            if ([subView isKindOfClass:[UIImageView class]] &&![subView isKindOfClass:NSClassFromString(@"UITabBarSelectionIndicatorView")]) {
                return (UIImageView *)subView;
            }
        }
    }
    return nil;
}
@end
