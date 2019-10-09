//
//  SpringBallViewController.m
//  CoreAnimation
//
//  Created by 周飞 on 2019/1/22.
//  Copyright © 2019年 X. All rights reserved.
//

#import "SpringBallViewController.h"
#import "SpringBall.h"

@interface SpringBallViewController ()
@property (nonatomic, strong) SpringBall *upDownBall;
@property (nonatomic, strong) SpringBall *bigSmallBall;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation SpringBallViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self setupUI];
}

#pragma mark - Getter, Setter
- (SpringBall *)upDownBall {
    if (!_upDownBall) {
        _upDownBall = [SpringBall springBall:SpringBallTypeUpDown];
        _upDownBall.backgroundColor = [UIColor blueColor];
    }
    return _upDownBall;
}

- (SpringBall *)bigSmallBall {
    if (!_bigSmallBall) {
        _bigSmallBall = [SpringBall springBall:SpringBallTypeBigSmall];
        _bigSmallBall.backgroundColor = [UIColor purpleColor];
    }
    return _bigSmallBall;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.bigSmallBall.frame), 50, 50)];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor blueColor].CGColor;
        layer.bounds = _maskView.bounds;
        layer.position = CGPointMake(CGRectGetWidth(_maskView.frame)*0.5, CGRectGetHeight(_maskView.frame)*0.5);
        
        UIBezierPath *ber = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(layer.bounds, 10, 10)];
        CAShapeLayer *shape = [CAShapeLayer layer];
        shape.path = ber.CGPath;
        shape.fillColor = [UIColor redColor].CGColor;
        shape.fillRule = kCAFillRuleEvenOdd;
        
        layer.mask = shape;
        
        [_maskView.layer addSublayer:layer];
    }
    return _maskView;
}

#pragma mark - Event

#pragma mark - Public Method

#pragma mark - Private Method
- (void)setupData {
    
}

- (void)setupUI {
    self.upDownBall.frame = CGRectMake(100, 100, 40, 40);
    [self.view addSubview:self.upDownBall];
    
    self.bigSmallBall.frame = CGRectMake(100, 200, 20, 20);
    [self.view addSubview:self.bigSmallBall];
    
    [self.view addSubview:self.maskView];
}

- (void)resetData {
    
}

- (void)resetUI {
    
}

#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject


@end
