//
//  SKNavigationBar.h
//  SKProject01
//
//  Created by 侯森魁 on 2017/9/11.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

/**
 重写NSLog,Debug模式下打印日志和当前行数
 
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
#define IS_IPHONE_X (SCREEN_HEIGHT == 812.0f) ? YES : NO
#define Height_NavContentBar 44.0f
#define Height_StatusBar ((IS_IPHONE_X )?(44.0): (20.0))
#define Height_NavBar ((IS_IPHONE_X )?(88.0): (64.0))
#define Height_TabBar ((IS_IPHONE_X )?(83.0): (49.0))
#define Height_TabBar_SafeArea ((IS_IPHONE_X )?(34): (0))

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#define OnePx (1/([UIScreen mainScreen].scale))

typedef void(^onClick)(void);

@interface NavBtnParams:NSObject

@property (nonatomic,copy)onClick onClick;
@property (nonatomic,copy)NSString *btnTitle;
@property (nonatomic,strong)UIImage * backgroundImg;
@property (nonatomic,strong)UIImage * backgroundSelectImg;

@end

#pragma mark--这里给UIControl扩充一个block方法
@interface UIControl (ClickBlock)

@property(nonatomic,copy)onClick click;
@end

@interface SKNavigationBar : UIView

@property (nonatomic,strong)UIView *titleView;

-(instancetype)initWithFrame:(CGRect)frame;

//设置复杂背景视图 比如毛玻璃
- (void)setBackgroundView:(UIView *)view;

/**
 设置头部视图
 */
- (void)setTitleView:(UIView *)viwe;

- (void)setTitleTextColor:(UIColor *)color;

- (void)setTitleWithString:(NSString *)title;

- (void)setTitleWithImage:(UIImage *)image;

- (void)setContentViewBackgroundColor:(UIColor *)color;


- (void)hiddenBottomLine;

- (void)rmvLeftButton;

- (void)rmvRightButton;

- (void)addLeftButton:(onClick)onClick;

- (void)showLeftButtons:(NSArray *)params;

- (void)showRightButtons:(NSArray *)params;


/**
 使用的时候 必须设置view的frame
 */
- (void)showLeftViews:(NSArray <UIView *>*)views;

- (void)showRightViews:(NSArray <UIView *>*)views;
@end
