//
//  TextLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/23.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "TextLayerVC.h"

@interface TextLayerVC ()<CAAnimationDelegate>
@property (strong, nonatomic)CATextLayer     *textLayer;
@property (strong, nonatomic)CAGradientLayer *gradientLayer;

@end

@implementation TextLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupGradientLayer];
    [self setupSubVews];
}

- (void)setupSubVews {
    CAGradientLayer * gdLayer  =self.gradientLayer;
    [gdLayer setFrame:CGRectMake(0, 0, 320, 50)];
    gdLayer.position = self.view.center;
    [self.view.layer addSublayer:gdLayer];
    

    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = @"美丽的谎言说过多少遍，说来说去从来没实现";
    textLayer.bounds = CGRectMake(0, 0, 320, 50);
//    textLayer.font = (__bridge CFTypeRef _Nullable)(@"HiraKakuProN-W3");//字体的名字 不是 UIFont
//    textLayer.fontSize = 12.f;//字体的大小
   
    UIFont *font = [UIFont systemFontOfSize:16];
    CFStringRef fontCFString = (__bridge CFStringRef)font.fontName;
       CGFontRef fontRef = CGFontCreateWithFontName(fontCFString);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef); //与CFRelease的功能相当 当字体的null的时候不会引起程序出错
    
    textLayer.wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
    textLayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    textLayer.position = CGPointMake(gdLayer.bounds.size.width*0.5, gdLayer.bounds.size.height*0.5);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
    textLayer.contentsScale = [UIScreen mainScreen].scale;//解决文字模糊 以Retina方式来渲染，防止画出来的文本像素化
    textLayer.foregroundColor =[UIColor redColor].CGColor;//字体的颜色 文本颜色
    self.textLayer = textLayer;
    
    [gdLayer setMask:textLayer];
    
    [self performAnimation];
}

- (void)setupGradientLayer {
    CAGradientLayer *layer = [CAGradientLayer layer];
    [layer setStartPoint:CGPointMake(0.0, 0.5)];
    [layer setEndPoint:CGPointMake(1.0, 0.5)];
    
    // Create colors using hues in +5 increments
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger hue = 0; hue <= 360; hue += 5) {
        
        UIColor *color;
        color = [UIColor colorWithHue:1.0 * hue / 360.0
                           saturation:1.0
                           brightness:1.0
                                alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    [layer setColors:[NSArray arrayWithArray:colors]];
    
    self.gradientLayer = layer;
}

- (void)performAnimation {
    // Move the last color in the array to the front
    // shifting all the other colors.
    CAGradientLayer *layer = self.gradientLayer;
    NSMutableArray *mutable = [[layer colors] mutableCopy];
    id lastColor = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:lastColor atIndex:0];
    
    NSArray *shiftedColors = [NSArray arrayWithArray:mutable];
    
    // Update the colors on the model layer
    [layer setColors:shiftedColors];
    
    // Create an animation to slowly move the gradient left to right.
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:shiftedColors];
    [animation setDuration:0.05];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}


#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [self performAnimation];
}


@end
