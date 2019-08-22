//
//  GradientLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/21.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "GradientLayerVC.h"

@interface GradientLayerVC ()
@property (strong, nonatomic) UIView *upView;
@property (strong, nonatomic) UIView *downView;
@end

@implementation GradientLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubViews];
    [self resetUpViewLayer];
    [self resetDownViewLayer];
}

- (void)setupSubViews {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat heigh = [UIScreen mainScreen].bounds.size.height;

    UIView *up = [UIView new];
    [up setFrame:CGRectMake(0, 0, width, heigh*0.5)];
    [self.view addSubview:up];
    self.upView = up;
    
    UIView *down = [UIView new];
    [down setFrame:CGRectMake(0, heigh*0.5, width, heigh*0.5)];
    [self.view addSubview:down];
    self.downView = down;
}

- (void)resetUpViewLayer {

    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds=self.upView.bounds;
    layer.position = self.upView.center;
    layer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor grayColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    layer.locations= @[@(0.2),@(0.5),@(0.6),@(0.9)];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    [self.upView.layer addSublayer:layer];
    
    __block CGFloat temp=0;
    __block CGFloat state=1;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        if (state > 0) {
            temp += 0.1;
            if (temp > 0.3) {
                state = 0;
            }
        } else {
            temp -= 0.1;
            if (temp < 0) {
                state = 1;
            }
        }
        
//        layer.locations = @[@(0.1+temp),@(0.2+temp),@(0.6+temp),@(0.9+temp)];
    }];
    
}

- (void)resetDownViewLayer {
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds=self.downView.bounds;
    layer.position = self.downView.center;
    layer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor grayColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    [self.upView.layer addSublayer:layer];
    
    __block CGFloat temp=0;
    __block CGFloat state=1;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        if (state > 0) {
            temp += 0.1;
            if (temp > 0.3) {
                state = 0;
            }
        } else {
            temp -= 0.1;
            if (temp < 0) {
                state = 1;
            }
        }
        
//        layer.locations = @[@(0.1+temp),@(0.2+temp),@(0.6+temp),@(0.9+temp)];
    }];
    
}




@end
