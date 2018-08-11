//
//  CompleteViewController.m
//  CoreAnimation
//
//  Created by 周飞 on 2018/8/10.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

#import "CompleteViewController.h"

static CGPoint center = {0,0};
static CGFloat width0 = 0;
static CGFloat width1 = 0;

@interface CompleteViewController ()
@property (strong,nonatomic)UIView *containV;
@property (strong,nonatomic)UIBezierPath *circlePath;
@property (strong,nonatomic)UIBezierPath *checkPath;


@end

@implementation CompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    center = self.view.center;
    width0 = self.view.bounds.size.width-100;
    width1 = width0-10;
    
    self.containV = [UIView new];
    self.containV.backgroundColor = [UIColor whiteColor];
    [self.containV setFrame:CGRectMake(50, 50, width0, width0)];
    [self.view addSubview:self.containV];
    
    [self resetViewBG1];
    [self resetView1];
    [self resutViewBG2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self resutView2];
    });
}

- (UIBezierPath *)circlePath {
    if (!_circlePath) {
        center = CGPointMake(width0*0.5, width0*0.5);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:60 startAngle:M_PI*1.5 endAngle:-M_PI*0.5 clockwise:NO];
        _circlePath = circlePath;
    }
    return _circlePath;
}

- (UIBezierPath *)checkPath {
    if (!_checkPath) {
        UIBezierPath *checkPath = [UIBezierPath bezierPath];
        CGFloat x0 = center.x - 15;
        CGFloat y0 = center.y;
        
        CGFloat x1 = x0+12;
        CGFloat y1 = y0+15;
        
        CGFloat x2 = x1+25;
        CGFloat y2 = y1-25;
        
        [checkPath moveToPoint:CGPointMake(x2, y2)];
        [checkPath addLineToPoint:CGPointMake(x1, y1)];
        [checkPath addLineToPoint:CGPointMake(x0, y0)];
        _checkPath = checkPath;
    }
    return _checkPath;
}


- (void)resetViewBG1 {
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.path = self.circlePath.CGPath;
    bgLayer.lineWidth = 4.f;
    bgLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgLayer.fillColor = nil;
    [self.containV.layer addSublayer:bgLayer];
}

- (void)resutViewBG2 {
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.path = self.checkPath.CGPath;
    bgLayer.lineWidth = 7.f;
    bgLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgLayer.fillColor = nil;
    [self.containV.layer addSublayer:bgLayer];
}

- (void)resetView1 {
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = self.circlePath.CGPath;
    layer2.lineWidth = 4.f;
    layer2.strokeColor = [UIColor colorWithRed:0 green:198/255.0 blue:206/255.0 alpha:1].CGColor;
    layer2.fillColor = nil;
    [self.containV.layer addSublayer:layer2];
    
    CABasicAnimation *baseA = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    baseA.fromValue = @(1);
    baseA.toValue = @(0);
    baseA.duration = 3.f;
    [layer2 addAnimation:baseA forKey:nil];
}

- (void)resutView2 {
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = self.checkPath.CGPath;
    layer2.lineWidth = 7.f;
    layer2.strokeColor = [UIColor colorWithRed:0 green:198/255.0 blue:206/255.0 alpha:1].CGColor;
    layer2.fillColor = nil;
    [self.containV.layer addSublayer:layer2];
    
    CABasicAnimation *baseA = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    baseA.fromValue = @(1);
    baseA.toValue = @(0);
    baseA.duration = 1.f;
    [layer2 addAnimation:baseA forKey:nil];
}

@end
