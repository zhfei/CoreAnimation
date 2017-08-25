//
//  ReplicatorLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/22.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "ReplicatorLayerVC.h"

@interface ReplicatorLayerVC ()
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;

@end

@implementation ReplicatorLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUpView];
    [self setupDownView];
}

- (void)setupUpView {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = CGRectMake(0, 0, 20, 20);
    shapeLayer.position = self.upView.center;
    shapeLayer.cornerRadius = 10;
    shapeLayer.backgroundColor = [UIColor redColor].CGColor;
    
    CABasicAnimation *basicA = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transf = CATransform3DMakeScale(10, 10, 1);
    NSValue *value = [NSValue valueWithCATransform3D:transf];
    basicA.toValue = value;
    basicA.duration = 2;
    
    CABasicAnimation *basicB = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicB.toValue = @(0);
    basicB.duration = 2;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basicA,basicB];
    group.duration = 2;
    group.repeatCount = INT64_MAX;
    
    [shapeLayer addAnimation:group forKey:nil];
    
    CAReplicatorLayer *replayer = [CAReplicatorLayer layer];
    replayer.instanceCount = 3;
    replayer.instanceDelay = 0.3;
    [replayer addSublayer:shapeLayer];
    [self.upView.layer addSublayer:replayer];
}

- (void)setupDownView {
    
    CGFloat heigh = self.downView.bounds.size.height-40;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = CGRectMake(0, 0, 20, 20);
    shapeLayer.position = self.downView.center;
    shapeLayer.cornerRadius = 10;
    shapeLayer.backgroundColor = [UIColor blueColor].CGColor;
    shapeLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:self.upView.center radius:heigh*0.5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(20, 20)];
    [bezier addLineToPoint:CGPointMake(300, 20)];
    [bezier addLineToPoint:CGPointMake(300, 200)];
    [bezier addLineToPoint:CGPointMake(20, 20)];
    
    
    CAKeyframeAnimation *basicA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    basicA.path=bezier.CGPath;
    basicA.duration = 3;
    
    
    CABasicAnimation *basicB = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicB.duration = 3;
    basicB.repeatCount = HUGE;
    basicB.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    basicB.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    
    CABasicAnimation *basicC = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicC.toValue = @(0);
    basicC.duration = 3;
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basicA,basicB,basicC];
    group.duration = 3;
    group.repeatCount = INT64_MAX;
    
    [shapeLayer addAnimation:group forKey:nil];
    
    CAReplicatorLayer *replayer = [CAReplicatorLayer layer];
    replayer.instanceCount = 14;
    replayer.instanceDelay = 0.2;
    replayer.instanceAlphaOffset = -0.05;
    [replayer addSublayer:shapeLayer];
    [self.downView.layer addSublayer:replayer];

}

@end
