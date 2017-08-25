//
//  ScrollLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/22.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "ScrollLayerVC.h"

@interface ScrollLayerVC ()
@property (strong, nonatomic)CAScrollLayer *scrollLayer;
@end

@implementation ScrollLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)setupSubViews {

    CALayer *layer0 = [CALayer layer];
    layer0.contents = (__bridge id _Nullable)([UIImage imageNamed:@"timg"].CGImage);
    layer0.frame = [UIScreen mainScreen].bounds;
    
    CAScrollLayer *scrollLayer = [CAScrollLayer layer];
    
    scrollLayer.frame = (CGRect){60,60,CGSizeMake(200, 200)};
    scrollLayer.scrollMode = kCAScrollBoth;
    [scrollLayer addSublayer:layer0];
    self.scrollLayer = scrollLayer;
    [self.view.layer addSublayer:scrollLayer];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //locationInView:获取到的是手指点击屏幕实时的坐标点；
    //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
    CGPoint trans = [pan translationInView:self.view];
    CGPoint origin = self.scrollLayer.bounds.origin;
    
    origin = CGPointMake(trans.x-origin.x, trans.y-origin.y);
    [self.scrollLayer scrollToPoint:origin];
    [pan setTranslation:CGPointZero inView:self.view];

}

@end
