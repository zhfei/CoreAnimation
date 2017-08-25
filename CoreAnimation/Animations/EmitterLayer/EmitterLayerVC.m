//
//  EmitterLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/21.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "EmitterLayerVC.h"

@interface EmitterLayerVC ()
@property (strong, nonatomic)CAEmitterLayer *caEmitterLayer;
@end

@implementation EmitterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *model = [[UIImageView alloc] initWithFrame:self.view.frame];
    model.image = [UIImage imageNamed:@"model.jpg"];
    [self.view addSubview:model];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.frame];
    bg.image = [UIImage imageNamed:@"blur.png"];
    [self.view addSubview:bg];

    
    [self addEmitterLayerWithImageName:@"circle"];
    [self addEmitterLayerWithImageName:@"flower"];

}

//添加粒子引擎
- (void)addEmitterLayerWithImageName:(NSString *)name {
    _caEmitterLayer = [CAEmitterLayer layer];
    _caEmitterLayer.frame = self.view.frame;
    _caEmitterLayer.renderMode = kCAEmitterLayerAdditive; // 粒子如何混合, 这里是直接重叠
    CGPoint position =CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds)-100, CGRectGetMaxY([UIScreen mainScreen].bounds)-100);
    _caEmitterLayer.emitterPosition = position; // 发射点的位置
    [self.view.layer addSublayer:_caEmitterLayer];
    
    [self addEmitterCellWithImageName:name];
}

//添加粒子
- (void)addEmitterCellWithImageName:(NSString *)name  {

    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:name].CGImage; // 粒子中的图片
    cell.yAcceleration = -10.f;     // 粒子的初始加速度
    cell.xAcceleration = -110.f;
    cell.birthRate = 5.f;           // 每秒生成粒子的个数
    cell.lifetime = 6.f;            // 粒子存活时间
    cell.alphaSpeed = -0.3f;        // 粒子消逝的速度
    cell.velocity = 30.f;           // 粒子运动的速度均值
    cell.velocityRange = 60.f;      // 粒子运动的速度扰动范围
    cell.emissionRange = M_PI * 2.f; // 粒子发射角度, 这里是一个扇形.
//    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    
    // add particle template to emitter
    _caEmitterLayer.emitterCells = @[cell]; // 将粒子组成的数组赋值给CAEmitterLayer的emitterCells属性即可.
    
}



@end
