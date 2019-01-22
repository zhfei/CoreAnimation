//
//  SpringBall.m
//  CoreAnimation
//
//  Created by 周飞 on 2019/1/22.
//  Copyright © 2019年 X. All rights reserved.
//

#import "SpringBall.h"

@interface SpringBall ()
@property (nonatomic, strong) CAShapeLayer *caLayer;
@end

@implementation SpringBall
+ (SpringBall *)springBall:(SpringBallType)type {
    SpringBall *ball = [SpringBall new];
    if (SpringBallTypeUpDown == type) {
        [ball setupUpDownUI];
    } else if (SpringBallTypeBigSmall == type) {
        [ball setupBigSmallUI];
    }
    return ball;
}

- (CALayer *)caLayer {
    if (!_caLayer) {
        _caLayer = [CAShapeLayer layer];
        _caLayer.fillColor = [UIColor redColor].CGColor;
        
        _caLayer.frame = CGRectMake(10, 0, 0, 0);
        UIBezierPath *bez = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 20, 20)];
        _caLayer.path = bez.CGPath;
    }
    return _caLayer;
}
//上下弹跳动画
- (void)setupUpDownUI {
    self.backgroundColor = [UIColor whiteColor];
    [self.layer addSublayer:self.caLayer];
    
    //移动：position
    //移动：transform.translation.y
    //旋转：transform.rotation.z
    //缩放：transform.scale
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    base.fromValue = [NSNumber numberWithInteger:0];
    base.toValue = [NSNumber numberWithInteger:20];
    base.repeatCount = NSIntegerMax;
    base.autoreverses = YES;//依动画的方式返回原位置
    base.duration = 1;
    [self.caLayer addAnimation:base forKey:@"move"];
}

//缩放动画
- (void)setupBigSmallUI {
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    //移动：position
    //移动：transform.translation.y
    //旋转：transform.rotation.z
    //缩放：transform.scale
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    base.fromValue = [NSNumber numberWithInteger:1];
    base.toValue = [NSNumber numberWithInteger:2];
    base.repeatCount = NSIntegerMax;
    base.autoreverses = YES;//依动画的方式返回原位置
    base.duration = 1;
    [self.layer addAnimation:base forKey:@"move2"];
}

@end
