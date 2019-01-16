//
//  WaterWaveBall.m
//  CoreAnimation
//
//  Created by 周飞 on 2019/1/16.
//  Copyright © 2019年 X. All rights reserved.
//
/*
 绘制波形的变量定义，使用波形曲线y=Asin(ωx+φ)+k进行绘制
 
 waveAmplitude，波纹振幅，A
 
 waveCycle波纹周期，T = 2π/ω
 
 offsetX，波浪x位移，φ
 
 currentWavePointY，当前波浪高度，k
 */

#import "WaterWaveBall.h"

@interface WaterWaveBall ()
//UI
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) CGFloat percent;

@property (nonatomic, assign) CGFloat waveAmplitude;        //振幅
@property (nonatomic, assign) CGFloat waveCycle;            //周期
@property (nonatomic, assign) CGFloat offsetX;              //x位移
@property (nonatomic, assign) CGFloat currentWavePointY;    //当前浪高度

@property (nonatomic, assign) CGFloat waveSpeed;            //浪水平速度
@property (nonatomic, assign) CGFloat waveGrowth;           //浪垂直上升速度

@property (nonatomic, assign) BOOL bWaveFinished;
@property (nonatomic, assign) BOOL increase;
@property (nonatomic, assign) CGFloat variable;
@end

@implementation WaterWaveBall
- (void)awakeFromNib {
    [self setupUI];
}

- (void)setupUI {
    [self defaultConfig];
}

- (void)defaultConfig
{
    self.waveCycle = 1.66 * M_PI / CGRectGetWidth(self.frame);
    self.currentWavePointY = CGRectGetHeight(self.frame);
    
    self.waveGrowth = 1.0;
    self.waveSpeed = 0.4 / M_PI;
    
    self.offsetX = 0;
}

- (void)startWaveToPercent:(CGFloat)percent
{
    self.percent = percent;
    
    [self resetProperty];
    [self resetLayer];
    
    if (self.displayLink)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    
    self.bWaveFinished = NO;
    
    // 启动同步渲染绘制波纹
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setCurrentWave:)];
    self.displayLink.preferredFramesPerSecond = 60;
//    self.displayLink.paused = YES;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)resetProperty
{
    self.currentWavePointY = CGRectGetHeight(self.frame);
    self.offsetX = 0;
    
    self.variable = 1.6;
    self.increase = NO;
}

- (void)resetLayer
{
    if (self.waveLayer)
    {
        [self.waveLayer removeFromSuperlayer];
        self.waveLayer = nil;
    }
    self.waveLayer = [CAShapeLayer layer];
    
    // 设置渐变
    if (self.gradientLayer)
    {
        [self.gradientLayer removeFromSuperlayer];
        self.gradientLayer = nil;
    }
    self.gradientLayer = [CAGradientLayer layer];
    
    self.gradientLayer.frame = [self gradientLayerFrame];
    [self setupGradientColor];
    
    [self.gradientLayer setMask:self.waveLayer];
    [self.layer addSublayer:self.gradientLayer];
}

- (void)setupGradientColor
{
    // gradientLayer设置渐变色
    if ([self.colors count] < 1)
    {
        self.colors = [self defaultColors];
    }
    
    self.gradientLayer.colors = self.colors;
    
    NSInteger count = [self.colors count];
    CGFloat d = 1.0 / count;
    
    NSMutableArray *locations = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++)
    {
        NSNumber *num = @(d + d * i);
        [locations addObject:num];
    }
    NSNumber *lastNum = @(1.0f);
    [locations addObject:lastNum];
    
    self.gradientLayer.locations = locations;
    
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
}

- (NSArray *)defaultColors
{
    UIColor *color0 = [UIColor colorWithRed:164 / 255.0 green:216 / 255.0 blue:222 / 255.0 alpha:1];
    UIColor *color1 = [UIColor colorWithRed:105 / 255.0 green:192 / 255.0 blue:154 / 255.0 alpha:1];
    
    NSArray *colors = @[(__bridge id)color0.CGColor, (__bridge id)color1.CGColor];
    return colors;
}

- (CGRect)gradientLayerFrame
{
    CGFloat gradientLayerHeight = CGRectGetHeight(self.frame) * self.percent + 20;  // 加上20保证gradientLayer高度比waveLayer达到波峰时高度要高
    
    if (gradientLayerHeight > CGRectGetHeight(self.frame))
    {
        gradientLayerHeight = CGRectGetHeight(self.frame);
    }
    
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.frame) - gradientLayerHeight, CGRectGetWidth(self.frame), gradientLayerHeight);
    
    return frame;
}

- (void)setCurrentWave:(CADisplayLink *)displayLink
{
    if ([self waveFinished])
    {
        self.bWaveFinished = YES;
        [self amplitudeReduce];
        
        if (self.waveAmplitude <= 0)
        {
            [self stopWave];
            return;
        }
    }
    else
    {
        [self amplitudeChanged];
        self.currentWavePointY -= self.waveGrowth;
    }
    
    self.offsetX += self.waveSpeed;
    [self setCurrentWaveLayerPath];
}


- (BOOL)waveFinished
{
    return self.currentWavePointY <= (CGRectGetHeight(self.frame) * (1 - self.percent));
}

- (void)amplitudeReduce
{
    self.waveAmplitude -= 0.066;
}

- (void)stopWave
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)amplitudeChanged
{
    if (self.increase)
    {
        self.variable += 0.01;
    }
    else
    {
        self.variable -= 0.01;
    }
    // 变化的范围
    if (self.variable <= 1)
    {
        self.increase = YES;
    }
    
    if (self.variable >= 1.6)
    {
        self.increase = NO;
    }
    
    self.waveAmplitude = self.variable * 5;
}

- (void)setCurrentWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = self.currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    CGFloat width = CGRectGetWidth(self.frame);
    for (float x = 0.0f; x <= width; x++)
    {
        // 正弦曲线公式
        y = self.waveAmplitude * sin(self.waveCycle * x + self.offsetX) + self.currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, width, CGRectGetHeight(self.frame));
    CGPathAddLineToPoint(path, nil, 0, CGRectGetHeight(self.frame));
    CGPathCloseSubpath(path);
    
    self.waveLayer.path = path;
    CGPathRelease(path);
}


@end
