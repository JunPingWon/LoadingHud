//
//  LoadingHudView.m
//  LoadingHud
//
//  Created by JunpingWon on 15/10/20.
//  Copyright (c) 2015年 JunpingWon. All rights reserved.
//

#import "LoadingHudView.h"

//宏定义
#define ORIGIN_X self.frame.origin.x
#define ORIGIN_Y self.frame.origin.y
#define WIDTH    self.frame.size.width
#define HEIGHT   self.frame.size.height
//球的直径
#define BALL_RADIUS 20

//延展，定义自己的私有属性或方法
@interface LoadingHudView ()
//第一个球
@property (nonatomic, strong) UIView *ball_1;
//第二个球
@property (nonatomic, strong) UIView *ball_2;
//第三个球
@property (nonatomic, strong) UIView *ball_3;

@end

@implementation LoadingHudView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //创建毛玻璃效果的背景视图
        UIVisualEffectView *visualBgView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualBgView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        visualBgView.layer.cornerRadius = BALL_RADIUS / 2;
        visualBgView.clipsToBounds = YES;
        [self addSubview:visualBgView];
        
    }
    return self;
    
}

- (UIColor *)ballColor {
    
    if (_ballColor) {
        return _ballColor;
    }
    return [UIColor blackColor];
}

- (void)showHud {
    //创建三个小球添加到背景视图
    
    //小球的纵坐标
    CGFloat ballH = HEIGHT / 2 - BALL_RADIUS * 0.5;
    
    UIView *ball_1 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH / 2 - BALL_RADIUS * 1.5, ballH, BALL_RADIUS, BALL_RADIUS)];
    ball_1.layer.cornerRadius = BALL_RADIUS / 2;//成为圆形
    ball_1.backgroundColor = self.ballColor;//小球的颜色
    [self addSubview:ball_1];
    self.ball_1 = ball_1;
    
    UIView *ball_2 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH / 2 - BALL_RADIUS * 0.5, ballH, BALL_RADIUS, BALL_RADIUS)];
    
    ball_2.layer.cornerRadius = BALL_RADIUS / 2;
    ball_2.backgroundColor = self.ballColor;
    [self addSubview:ball_2];
    self.ball_2 = ball_2;
    
    UIView *ball_3 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH / 2 + BALL_RADIUS * 0.5, ballH, BALL_RADIUS, BALL_RADIUS)];
    ball_3.layer.cornerRadius = BALL_RADIUS / 2;
    ball_3.backgroundColor = self.ballColor;
    [self addSubview:ball_3];
    self.ball_3 = ball_3;
    
    [self rotationAnimation];//调用动画的方法

}

- (void)rotationAnimation {
    //获取旋转的中心点
    CGPoint centerPoint = CGPointMake(WIDTH / 2, HEIGHT / 2);
    //获取第一个球的中心点
    CGPoint ceterBall_1 = CGPointMake(WIDTH / 2 - BALL_RADIUS, HEIGHT / 2);
    //获取第三个球的中心点
    CGPoint ceterBall_3 = CGPointMake(WIDTH / 2 + BALL_RADIUS, HEIGHT / 2);
    
    //绘制贝塞尔曲线
    //第一个圆的曲线
    UIBezierPath *pathBall_1 = [UIBezierPath bezierPath];
    [pathBall_1 moveToPoint:ceterBall_1];
    
    [pathBall_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI endAngle:M_PI*2 clockwise:NO];
    UIBezierPath *pathBall_1_1 = [UIBezierPath bezierPath];
    [pathBall_1_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:0 endAngle:M_PI clockwise:NO];
    [pathBall_1 appendPath:pathBall_1_1];
    
    //第一个圆的动画
    CAKeyframeAnimation *animationBall_1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animationBall_1.path = pathBall_1.CGPath;
    animationBall_1.delegate = self;
    animationBall_1.repeatCount = 1;
    animationBall_1.duration = 1.4;
    animationBall_1.autoreverses = NO;
    
    animationBall_1.removedOnCompletion = NO;
    //removedOnCompletion必须设置为NO才起效，kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
    animationBall_1.fillMode = kCAFillModeForwards;
    //kCAAnimationCubic对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算
    animationBall_1.calculationMode = kCAAnimationCubic;
    animationBall_1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.ball_1.layer addAnimation:animationBall_1 forKey:@"animation"];
    
    //第三个圆的曲线
    UIBezierPath *pathBall_3 = [UIBezierPath bezierPath];
    [pathBall_3 moveToPoint:ceterBall_3];
    
    [pathBall_3 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:0 endAngle:M_PI clockwise:NO];
    UIBezierPath *pathBall_3_1 = [UIBezierPath bezierPath];
    [pathBall_3_1 addArcWithCenter:centerPoint radius:BALL_RADIUS startAngle:M_PI endAngle:M_PI * 2 clockwise:NO];
    [pathBall_3 appendPath:pathBall_3_1];
    
    //第三个圆的动画
    CAKeyframeAnimation *animationBall_3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animationBall_3.path = pathBall_3.CGPath;
    animationBall_3.removedOnCompletion = NO;
    animationBall_3.fillMode = kCAFillModeForwards;
    animationBall_3.autoreverses = NO;
    animationBall_3.repeatCount = 1;
    animationBall_3.duration = 1.4;
    animationBall_3.calculationMode = kCAAnimationCubic;
//  animationBall_3.delegate = self;
    animationBall_3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.ball_3.layer addAnimation:animationBall_3 forKey:@"rotation"];
    
    
}

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim {
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.ball_1.transform = CGAffineTransformMakeTranslation(-BALL_RADIUS, 0);
        self.ball_1.transform = CGAffineTransformScale(self.ball_1.transform, 0.7, 0.7);
        
        self.ball_3.transform = CGAffineTransformMakeTranslation(BALL_RADIUS, 0);
        self.ball_3.transform = CGAffineTransformScale(self.ball_3.transform, 0.7, 0.7);
        
        self.ball_2.transform = CGAffineTransformScale(self.ball_2.transform, 0.7, 0.7);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.ball_1.transform = CGAffineTransformIdentity;
            self.ball_3.transform = CGAffineTransformIdentity;
            self.ball_2.transform = CGAffineTransformIdentity;
        } completion:NULL];
        
        
    }];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self rotationAnimation];
}

@end
