//
//  CallingView.m
//  CoreAnimation
//
//  Created by 周飞 on 2019/7/15.
//  Copyright © 2019年 X. All rights reserved.
//

#import "CallingView.h"

const CGFloat circleWidthAndHeight = 4;
const CGFloat circleMargin = 6;
const CGFloat animationTime = 1;


@implementation CallingView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - Private Method
- (void)setupUI {
    [self setupDownView];
}

- (void)setupDownView {
    // 1.创建一个重复图层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(circleWidthAndHeight+circleMargin, 0, 0);
    replicatorLayer.instanceDelay = animationTime;
    replicatorLayer.instanceColor = [UIColor colorWithRed:151/255.0 green:188/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    // 2.创建一个图层圆球
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(self.bounds.size.width/4, self.bounds.size.height/2);
    layer.bounds = CGRectMake(0, 0, circleWidthAndHeight, circleWidthAndHeight);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.cornerRadius = circleWidthAndHeight/2;
    layer.masksToBounds = YES;
    
    // 4.创建动画并添加到layer层上
    CABasicAnimation *basicB = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicB.toValue = @(0);
    basicB.repeatCount = MAXFLOAT;
    basicB.duration = animationTime;
    basicB.autoreverses = YES;
    [layer addAnimation:basicB forKey:nil];
    
    // 5.将layer层添加到复制层上
    [replicatorLayer addSublayer:layer];
    [self.layer addSublayer:replicatorLayer];
    
}

#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Getter, Setter

@end
