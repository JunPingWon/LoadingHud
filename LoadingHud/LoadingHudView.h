//
//  LoadingHudView.h
//  LoadingHud
//
//  Created by JunpingWon on 15/10/20.
//  Copyright (c) 2015年 JunpingWon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingHudView : UIView

//球的颜色
@property (nonatomic,strong)UIColor *ballColor;

//展示加载动画
- (void)showHud;

//关闭加载动画
- (void)dismissHud;

@end
