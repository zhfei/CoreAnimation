//
//  ShapeLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/22.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "ShapeLayerVC.h"
#import "DownView.h"

@interface ShapeLayerVC ()<CAAnimationDelegate>
@property (strong, nonatomic)DownView *downView0;
@property (strong, nonatomic)DownView *downView1;
@property (strong, nonatomic)DownView *downView2;

@property (strong, nonatomic)CAGradientLayer *spectrumLayer;
@end

@implementation ShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
    [self setupSubViews2];
    
    self.downView0.progress = 0;
    self.downView1.progress = 0.3;
    self.downView2.progress = 0.6;
    
    [self timerAction:self.downView0];
    [self timerAction:self.downView1];
    [self timerAction:self.downView2];
}

- (void)timerAction:(DownView *)downView {
    __block CGFloat temp=downView.progress;
    __block CGFloat state=1;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (state > 0) {
            temp += 0.1;
            if (temp > 1) {
                state = 0;
            }
        } else {
            temp -= 0.1;
            if (temp < 0) {
                state = 1;
            }
        }
        downView.progress =temp;
        
    }];
}

#pragma mark 上图
- (void)setupSubViews {
    
    CGPoint center = self.view.center;
    CGFloat width0 = self.view.bounds.size.width-100;
    CGFloat width1 = width0-10;
    
    UIView *containV = [UIView new];
    [containV setFrame:CGRectMake(50, 0, width0, width0)];
    [self.view addSubview:containV];
    
    center = CGPointMake(width0*0.5, width0*0.5);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:width0*0.5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *layer0 = [CAShapeLayer layer];
    layer0.path = path.CGPath;
    layer0.lineWidth = 2.f;
    layer0.fillColor = [UIColor blackColor].CGColor;
    [containV.layer addSublayer:layer0];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:width1*0.5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = path1.CGPath;
    layer1.lineWidth = 2.f;
    layer1.fillColor = [UIColor lightGrayColor].CGColor;
    [containV.layer addSublayer:layer1];
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    CGFloat x2 = 5;
    CGFloat y2 = width1*0.5;
    [path2 moveToPoint:CGPointMake(x2, y2)];
    [path2 addCurveToPoint:CGPointMake(width0-x2, y2) controlPoint1:CGPointMake(width1*0.25, 0) controlPoint2:CGPointMake(width1*0.75, width1)];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = path2.CGPath;
    layer2.lineWidth = 2.f;
    layer2.strokeColor = [UIColor blackColor].CGColor;
    layer2.fillColor = [UIColor lightGrayColor].CGColor;
    [containV.layer addSublayer:layer2];
    
    
    CABasicAnimation *baseA = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    baseA.fromValue = @(1);
    baseA.toValue = @(0);
    baseA.duration = 2.f;
    [layer2 addAnimation:baseA forKey:nil];
    
}

#pragma mark 下图
- (void)setupSubViews2 {
    CGFloat width0 = self.view.bounds.size.width-100;
    
    UIView *containV = [UIView new];
    containV.backgroundColor = [UIColor blackColor];
    [containV setFrame:CGRectMake(50, width0+50, width0, width0)];
    [self.view addSubview:containV];
    
    DownView *downView0 = [[DownView alloc] initWithFrame:CGRectMake(0, 50, width0, 3)];
    [containV addSubview:downView0];
    self.downView0 = downView0;
    
    DownView *downView1 = [[DownView alloc] initWithFrame:CGRectMake(0, 100, width0, 3)];
    [containV addSubview:downView1];
    self.downView1 = downView1;
    
    DownView *downView2 = [[DownView alloc] initWithFrame:CGRectMake(0, 150, width0, 3)];
    [containV addSubview:downView2];
    self.downView2 = downView2;
}


@end
