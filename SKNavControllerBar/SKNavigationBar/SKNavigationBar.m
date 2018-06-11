//
//  SKNavigationBar.m
//  SKProject01
//
//  Created by 侯森魁 on 2017/9/11.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "SKNavigationBar.h"
#import <objc/runtime.h>

@implementation NavBtnParams
@end

static const void *associateKey = "associateKey";

#pragma mark--这里给UIControl扩充一个block方法
@implementation UIControl (ClickBlock)

- (void)setClick:(onClick)click {
    objc_setAssociatedObject(self, associateKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (onClick)click {
    return objc_getAssociatedObject(self, associateKey);
}

- (void)buttonClick {
    if (self.click) {
        self.click();
    }
}
@end

@interface SKButton : UIButton

@end

@implementation SKButton
#pragma mark--扩大按钮的响应区域
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(50.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(50.0 -bounds.size.height, 0);
    
    bounds = CGRectInset(bounds, -0.5 *widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}
@end

#pragma mark--枚举类型

typedef NS_ENUM(NSInteger,NavBtnType) {
    NavBtnTypeLeft = 1,
    NavBtnTypeRight = 2
};

@interface SKNavigationBar ()

@property (nonatomic,assign)CGFloat Margin;
@property (nonatomic,assign)CGFloat Gap;
@property (nonatomic,copy) NSString *Test;

#pragma mark--容器View
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIButton *titleButton;
@property (nonatomic,assign)CGFloat titleOffset;

#pragma mark--导航栏底部的线条
@property (nonatomic,strong)UIView *lineView;


@end

@implementation SKNavigationBar

@synthesize titleView;


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.Margin = 15;
        self.Gap = 10;
        
        //用于比较哪边按钮长，以最长的作为title标准
        self.titleOffset = 0;
        
        [self setupUI];
        [self addTitleLabel:@""];
        [self addLineView];
        
    }
    return self;
}

- (void)setupUI {
    
    self.contentView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

}

- (void)addTitleLabel:(NSString *)title {
    
    self.titleView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44.0);
        make.top.mas_equalTo(Height_StatusBar);
        make.left.mas_equalTo(self.contentView.mas_left).offset(50);
        make.right.equalTo(self.contentView.mas_right).offset(-50);
    }];
    self.titleButton.backgroundColor = [UIColor clearColor];
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    [self.titleButton setTitle:title forState:UIControlStateHighlighted];
    
    self.titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [self.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.titleView addSubview:self.titleButton];
    
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titleView);
    }];
    
}
#pragma mark--设置底部线条(高度低于1px)
- (void)addLineView {
    
    self.lineView.backgroundColor = [UIColor colorWithRed:217/256.0 green:216/256.0 blue:217/256.0 alpha:1.0];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(OnePx);
    }];
}

#pragma mark--懒加载
- (UIView*)titleView {
    if (!titleView) {
        titleView = [[UIView alloc]init];
    }
    return titleView;
}
- (UIView*)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}
- (UIView*)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _titleButton;
}
- (UIView*)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}

#pragma mark--设置左/右标题的布局
- (void)setNavSubViewLayout:(UIView *) view :(CGFloat) margin :(NavBtnType)type{
    
    if (type == NavBtnTypeLeft) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.contentView.mas_left).offset(margin);
            make.width.mas_equalTo(view.frame.size.width);
            make.height.mas_equalTo(view.frame.size.height);
            make.centerY.mas_equalTo(self).offset(Height_StatusBar/2.0);
        }];
        
    } else if (type == NavBtnTypeRight){
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-margin);
            make.width.mas_equalTo(view.frame.size.width);
            make.height.mas_equalTo(view.frame.size.height);
            make.centerY.mas_equalTo(self).offset(Height_StatusBar/2.0);
        }];
    }
}

#pragma mark--更新titleView的约束
- (void)updateTitleConstraint:(CGFloat)offset {
    self.titleOffset = fmax(self.titleOffset, offset);//返回参数的最大值
    //https://msdn.microsoft.com/zh-cn/library/hh308439.aspx
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(self.titleOffset);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-self.titleOffset);
    }];
}

/**
 将会对传入的数组views和type进行布局

 @param views view数组
 @param type 左/右按钮
 */
- (void)showViews:(NSArray<UIView *> *)views :(NavBtnType)type {
    CGFloat offsetGap = 0;
    for (UIView *view in views) {
        [view layoutIfNeeded];
        view.tag = type;
        [self.contentView addSubview:view];
        NSInteger index = [views indexOfObject:view];
        CGFloat margin = offsetGap + self.Gap * (CGFloat)index + self.Margin;
        offsetGap += view.frame.size.width;
        
        [self setNavSubViewLayout:view :margin :type];
    }
    [self updateTitleConstraint:offsetGap + self.Gap * (CGFloat)views.count + self.Margin];
}

/**
 
 @param params 一个数组
 @param type 左/右按钮
 */
- (void)showButtons:(NSArray <NavBtnParams *>*)params :(NavBtnType)type {
    
    CGFloat offsetGap = 0.0f;
    
    for (NavBtnParams *param in params) {
        
        SKButton *btn = [SKButton buttonWithType:UIButtonTypeCustom];
        
        if (param.backgroundImg) {
            [btn setImage:param.backgroundImg forState:UIControlStateNormal];
        }
        if (param.backgroundSelectImg) {
            [btn setImage:param.backgroundSelectImg forState:UIControlStateHighlighted];
        }
        
        if (param.btnTitle.length > 0 ) {
            [btn setTitle:param.btnTitle forState:UIControlStateNormal];
            [btn setTitle:param.btnTitle forState:UIControlStateHighlighted];

        }
        [btn sizeToFit];
        
        btn.tag = type;
        btn.click = param.onClick;
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:btn];
        
        NSUInteger index = [params indexOfObject:param];
        CGFloat margin = offsetGap + self.Gap *(CGFloat)index + self.Margin;
        offsetGap += btn.frame.size.width;
        
        [self setNavSubViewLayout:btn :margin :type];
    }
    [self updateTitleConstraint:offsetGap + self.Gap * (CGFloat)params.count + self.Margin];
}


- (void)setBackgroundView:(UIView *)view {
    [self insertSubview:view belowSubview:self.contentView];
}

- (void)setContentViewBackgroundColor:(UIColor *)color{
    
    self.contentView.backgroundColor = color;
}

-(void)setTitleView:(UIView *)view {
    
    while (self.titleView.subviews.count) {
        UIView * childView = self.titleView.subviews.lastObject;
        [childView removeFromSuperview];
    }
    [self.titleView addSubview:view];
    
    [view layoutIfNeeded];
    
    CGFloat width = view.frame.size.width;
    CGFloat height = view.frame.size.height;
    
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
      
        make.center.mas_equalTo(self.titleView);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
}
#pragma mark--设置导航栏的标题的颜色
- (void)setTitleTextColor:(UIColor *)color {
    [self.titleButton setTitleColor:color forState:UIControlStateNormal];
    [self.titleButton setTitleColor:color forState:UIControlStateHighlighted];
}
#pragma mark--设置导航栏的标题
- (void)setTitleWithString:(NSString *)title {
    
    if(title&&[title isKindOfClass:[NSString class]]){
        [self.titleButton setTitle:title forState:UIControlStateNormal];
        [self.titleButton setTitle:title forState:UIControlStateHighlighted];
    }
}
#pragma mark--设置导航栏的标题的图片

- (void)setTitleWithImage:(UIImage *)image {
    [self.titleButton setImage:image forState:UIControlStateNormal];
    [self.titleButton setImage:image forState:UIControlStateHighlighted];

}

- (void)hiddenBottomLine{
    self.lineView.hidden = YES;
}
- (void)rmvLeftButton {

    NSArray *views = self.contentView.subviews;
    
    for (UIView *subView in views) {
        if (subView.tag == NavBtnTypeLeft) {
            [subView removeFromSuperview];
        }
    }
}

- (void)rmvRightButton {
    
    NSArray *views = self.contentView.subviews;
    
    for (UIView *subView in views) {
        if (subView.tag == NavBtnTypeRight) {
            [subView removeFromSuperview];
        }
    }
}
#pragma mark--添加导航栏的左按钮
- (void)addLeftButton:(onClick)onClick {
    
    NavBtnParams *param = [[NavBtnParams alloc]init];
    
    param.backgroundImg = [UIImage imageNamed:@"backImage"];
    param.backgroundSelectImg = [UIImage imageNamed:@"backImage"];
    
    param.onClick = onClick;
    
    [self showButtons:[NSArray arrayWithObject:param] :NavBtnTypeLeft];

}
- (void)showLeftButtons:(NSArray<NavBtnParams *> *)params {
    [self rmvLeftButton];
    [self showButtons:params :NavBtnTypeLeft];
}
- (void)showRightButtons:(NSArray<NavBtnParams *> *)params {
    [self rmvRightButton];
    [self showButtons:params :NavBtnTypeRight];
}

- (void)showLeftViews:(NSArray <UIView *> *)views {
    [self rmvLeftButton];
    [self showViews:views :NavBtnTypeLeft];
}

- (void)showRightViews:(NSArray<UIView *> *)views {
    [self rmvRightButton];
    [self showViews:views :NavBtnTypeRight];
}

@end
