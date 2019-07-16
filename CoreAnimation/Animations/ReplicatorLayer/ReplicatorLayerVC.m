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

- (void)music {
    // 1.创建一个复制图层对象，设置复制层的属性
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    // 1.1.设置复制图层中子层总数：这里包含原始层
    replicatorLayer.instanceCount = 8;
    // 1.2.设置复制子层偏移量，不包含原始层，这里是相对于原始层的x轴的偏移量
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    // 1.3.设置复制层的动画延迟事件
    replicatorLayer.instanceDelay = 0.1;
    // 1.4.设置复制层的背景色，如果原始层设置了背景色，这里设置就失去效果
    replicatorLayer.instanceColor = [UIColor greenColor].CGColor;
    // 1.5.设置复制层颜色的偏移量
    replicatorLayer.instanceGreenOffset = -0.1;
    
    // 2.创建一个图层对象  单条柱形 (原始层)
    CALayer *layer = [CALayer layer];
    // 2.1.设置layer对象的位置
    layer.position = CGPointMake(15, self.view.bounds.size.height);
    // 2.2.设置layer对象的锚点
    layer.anchorPoint = CGPointMake(0, 1);
    // 2.3.设置layer对象的位置大小
    layer.bounds = CGRectMake(0, 0, 30, 150);
    // 2.5.设置layer对象的颜色
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    // 3.创建一个基本动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    // 3.1.设置动画的属性
    basicAnimation.keyPath = @"transform.scale.y";
    // 3.2.设置动画的属性值
    basicAnimation.toValue = @0.1;
    // 3.3.设置动画的重复次数
    basicAnimation.repeatCount = MAXFLOAT;
    // 3.4.设置动画的执行时间
    basicAnimation.duration = 0.5;
    // 3.5.设置动画反转
    basicAnimation.autoreverses = YES;
    
    // 4.将动画添加到layer层上
    [layer addAnimation:basicAnimation forKey:nil];
    
    // 5.将layer层添加到复制层上
    [replicatorLayer addSublayer:layer];
    
    // 6.将复制层添加到view视图层上
    [self.view.layer addSublayer:replicatorLayer];
}


@end
