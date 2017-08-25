//
//  TransformLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/23.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "TransformLayerVC.h"

#define CG_COLOR(r, g, b, a) [UIColor colorWithRed:r green:g blue:b alpha:a]

@interface TransformLayerVC ()
@property (strong, nonatomic)UIView *containerView;
@property (strong, nonatomic)CATransformLayer *cube2;
@end

@implementation TransformLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self setupUpView];
    [self setupDownView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        CATransform3D c2t = self.cube2.transform;
        c2t = CATransform3DRotate(c2t, M_PI_4, 1, 1, 0);
        self.cube2.transform = c2t;
    }];
    
//    struct CATransform3D {
//        CGFloat m11（x缩放）, m12（y切变）, m13（旋转）,  m14（）;
//        
//        CGFloat m21（x切变）, m22（y缩放）, m23（）,  m24（）;
//        
//        CGFloat m31（旋转）,  m32（ ）, m33（）, m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
//        
//        CGFloat  m41（x平移）,m42（y平移）, m43（z平移）, m44（）;
//    };
}

//上面
- (void)setupUpView {
    CGFloat width0 = self.view.bounds.size.width - 20;
    CGFloat height0 = self.view.bounds.size.height*0.5 - 100;
    
    UIView *containerView = [UIView new];
    containerView.bounds = CGRectMake(0, 0, width0, height0);
    containerView.center = CGPointMake(width0*0.5+10, height0*0.5);
    containerView.backgroundColor = [UIColor whiteColor];
    self.containerView = containerView;
    [self.view addSubview:containerView];
    
    
    //set up the perspective transform
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = pt;
    
    
    //set up the transform for cube 2 and add it
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 0, 0, 0);
    CATransformLayer *cube2 = [self cubeWithTransform:c2t];
    [self.containerView.layer addSublayer:cube2];
    self.cube2 = cube2;
}

- (CATransformLayer *)cubeWithTransform:(CATransform3D)transform
{
    CGFloat width0 = self.view.bounds.size.width - 20;
    CGFloat height0 = self.view.bounds.size.height*0.5 - 100;
    //create cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    cube.bounds = CGRectMake(0, 0, width0-20, height0-20);
    cube.position = CGPointMake(width0*0.5, height0*0.5);
    cube.backgroundColor = [UIColor blueColor].CGColor;
    cube.transform = transform;
    cube.anchorPointZ = 0;
    

    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //apply the transform and return
    
    
    return cube;
}


- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(50, 50, 100, 100);
    
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //apply the transform and return
    face.transform = transform;
    return face;
}

//下面
- (void)setupDownView {

    CGFloat width0 = self.view.bounds.size.width - 20;
    CGFloat height0 = self.view.bounds.size.height*0.5 - 100;
    
    UIView *containerView = [UIView new];
    containerView.bounds = CGRectMake(0, height0+100, width0, height0);
    containerView.center = CGPointMake(width0*0.5+10, height0*1.5+100);
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
    

    // 普通的一个layer
    CALayer *plane        = [CALayer layer];
    plane.anchorPoint = CGPointMake(0.5, 0.5);                         // 锚点
    plane.frame       = CGRectMake(0, 0, 100, 100);       // 尺寸
    plane.position    = CGPointMake(width0*0.5+10, height0*1.5+100);           // 位置
    plane.opacity         = 0.6;                                       // 背景透明度
    plane.backgroundColor = CG_COLOR(1, 0, 0, 1).CGColor;                      // 背景色
    plane.borderWidth     = 3;                                         // 边框宽度
    plane.borderColor     = CG_COLOR(1, 1, 1, 0.5).CGColor;                    // 边框颜色(设置了透明度)
    plane.cornerRadius    = 10;                                        // 圆角值


    [containerView.layer addSublayer:plane];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
        static float degree = 0.f;
        
        // 起始值
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34           = 1.0/ -500;
        fromValue               = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        
        // 结束值
        CATransform3D toValue   = CATransform3DIdentity;
        toValue.m34             = 1.0/ -500;
        toValue                 = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        
        // 添加3d动画
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform3D.duration  = 0.5f;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
        plane.transform = toValue;
        [plane addAnimation:transform3D forKey:@"transform3D"];
    }];
}



@end
