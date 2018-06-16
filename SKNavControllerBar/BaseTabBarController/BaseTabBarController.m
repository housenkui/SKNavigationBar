//
//  BaseTabBarController.m
//  SKNavControllerBar
//
//  Created by housenkui on 2018/6/16.
//  Copyright © 2018年 housenkui. All rights reserved.
//

#import "BaseTabBarController.h"
#import "UITabBarItem+SpringEffect.h"


@interface BaseTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewController *vc1= [[ViewController alloc]init];
    
//    - (instancetype)initWithTitle:(nullable NSString *)title image:(nullable UIImage *)image selectedImage:(nullable UIImage *)selectedImage NS_AVAILABLE_IOS(7_0);

    
    UIImage *memberImage = [[UIImage imageNamed:@"table_icon_member_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *memberSelectedImage = [[UIImage imageNamed:@"table_icon_member_over"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *memberItem1 = [[UITabBarItem alloc]initWithTitle:@"我的" image:memberImage selectedImage:memberSelectedImage];
    UITabBarItem *memberItem2 = [[UITabBarItem alloc]initWithTitle:@"我的" image:memberImage selectedImage:memberSelectedImage];
    UITabBarItem *memberItem3 = [[UITabBarItem alloc]initWithTitle:@"我的" image:memberImage selectedImage:memberSelectedImage];

    
    vc1.tabBarItem = memberItem1;
    FirstViewController *vc2 = [[FirstViewController alloc]init];
    vc2.tabBarItem = memberItem2;

    SecondViewController *vc3 = [[SecondViewController alloc]init];

    vc3.tabBarItem = memberItem3;

    self.viewControllers = @[vc1,vc2,vc3];

    self.delegate  = self;
  
    
//    self.tabBar.delegate  =self;
//    UITabBar *tabBar = [[UITabBar alloc]init];
//    tabBar.delegate = self;
//    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark ================递归回调===============

- (void)recursion{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.selectedIndex >= self.viewControllers.count-1) {
            self.selectedIndex = 0;
        }else{
            self.selectedIndex += 1;
        }
        [self recursion];
    });
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;{
    
    NSLog(@"%s",__FUNCTION__);

} // called when a new view is selected by the user (but not programatically)

/* called when user shows or dismisses customize sheet. you can use the 'willEnd' to set up what appears underneath.
 changed is YES if there was some change to which items are visible or which order they appear. If selectedItem is no longer visible,
 it will be set to nil.
 */

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items __TVOS_PROHIBITED;          {
    NSLog(@"%s",__FUNCTION__);
}           // called before customize sheet is shown. items is current item list
- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray<UITabBarItem *> *)items __TVOS_PROHIBITED;             {
    NSLog(@"%s",__FUNCTION__);

}         // called after customize sheet is shown. items is current item list
- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed __TVOS_PROHIBITED; {
    NSLog(@"%s",__FUNCTION__);

}// called before customize sheet is hidden. items is new item list
- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed __TVOS_PROHIBITED; {
    NSLog(@"%s",__FUNCTION__);

} // called after customize sheet is hidden. items is new item list

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
        NSLog(@"视图显示后调用");
    UIImageView *tabBarItemImageView = viewController.tabBarItem.SK_TabBarImageView;
    
    tabBarItemImageView.transform = CGAffineTransformMakeScale(0.6,0.6);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        tabBarItemImageView.transform = CGAffineTransformMakeScale(1,1);
    } completion:nil];
}

//1、视图将要切换时调用，viewController为将要显示的控制器，如果返回的值为NO，则无法点击其它分栏了（viewController指代将要显示的控制器）
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    NSLog(@"被选中的控制器将要显示的按钮");
    //return NO;不能显示选中的控制器
    return YES;
    
}
//2、视图已经切换后调用，viewController 是已经显示的控制器

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    NSLog(@"视图显示后调用");
//}
//3、将要开始自定义item的顺序

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    
    NSLog(@"将要开始自定义item时调用");
    
    NSLog(@"%@",viewControllers);
}
//4、将要结束自定义item的顺序

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed

{
    
    NSLog(@"将要结束自定义item时调用");
    
    NSLog(@"%@",viewControllers);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
