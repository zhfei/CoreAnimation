//
//  TransitionVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/21.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "TransitionVC.h"

@interface TransitionVC ()<UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView *scrollView;
@end

@implementation TransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"转场动画";
    
    [self resetSubViews];
}

- (void)resetSubViews {

    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 200)];
    scroll.contentSize = CGSizeMake(ScreenWidth*6, 200);
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    self.scrollView = scroll;
    
    for (NSInteger i = 0; i<6; i++)
    {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, 200)];
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%ld.jpg",(long)i]];
        
        [scroll addSubview:imageView];
    }
    [self.view addSubview:scroll];
    
}

- (void)resetTransition {

    CATransition *animation = [CATransition animation];
    
    [animation setDuration:1.0f];
    //当动画结束后,layer会一直保持着动画最后的状态
    [animation setFillMode:kCAFillModeForwards];
    //计时函数,设置动画节奏
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    //转场动画类型
    [animation setType:@"pageCurl"];// rippleEffect
    //转场动画将去的方向
    [animation setSubtype:kCATransitionFromTop];
    
    [self.scrollView.layer addAnimation:animation forKey:nil];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    1.动画节奏常量
//    kCATransitionFade 交叉淡化过渡
//    kCATransitionMoveIn 新视图移到旧视图上面
//    kCATransitionPush 新视图把旧视图推出去
//    kCATransitionReveal 将旧视图移开,显示下面的新视图
//    2.动画类型
//    pageCurl 向上翻一页
//    pageUnCurl 向下翻一页
//    rippleEffect 滴水效果
//    suckEffect 收缩效果，如一块布被抽走
//    cube 立方体效果
//    oglFlip 上下翻转效果
    [self resetTransition];
}

@end
