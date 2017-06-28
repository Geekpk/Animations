//
//  CAReplicatorLayerView.m
//  Animations
//
//  Created by Arvin on 2017/6/28.
//  Copyright © 2017年 Arvin. All rights reserved.
//
#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#import "CAReplicatorLayerView.h"
@interface CAReplicatorLayerView ()

@end
@implementation CAReplicatorLayerView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}
- (void)setUp {
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 200)];
    [tPath addQuadCurveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 400) controlPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0 + 300, 20)];
    [tPath addQuadCurveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 200) controlPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0 - 300, 20)];
    [tPath closePath];
    
    // 具体的layer
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 10, 10)];
    tView.center = CGPointMake(SYS_DEVICE_WIDTH/2.0, 200);
    tView.layer.cornerRadius = 5;
    tView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    // 动作效果
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = tPath.CGPath;
    loveAnimation.duration = 1.5 ;
    loveAnimation.repeatCount = MAXFLOAT;
    [tView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    
    _love = [CAReplicatorLayer layer];
    _love.instanceCount = 60;                // 40个layer
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 10, 0);
    transform = CATransform3DRotate(transform, M_PI / 6, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -10, 0);
//    _loveLayer.instanceTransform = transform;
    _love.instanceDelay = 1/24.;               // 每隔xs出现一个layer
    _love.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
//    _loveLayer.instanceGreenOffset = -0.06;       // 颜色值递减。
    _love.instanceRedOffset = -0.04;         // 颜色值递减。
//    _loveLayer.instanceBlueOffset = -0.02;        // 颜色值递减。
    [_love addSublayer:tView.layer];
    [self.layer addSublayer:_love];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}
@end
