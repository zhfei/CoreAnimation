//
//  DisplayLinkVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/21.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "DisplayLinkVC.h"

@interface DisplayLinkVC ()
@property (strong, nonatomic)CADisplayLink *displayLink;
@property (assign, nonatomic)CFTimeInterval lastTime;
@property (assign, nonatomic)NSInteger      count;
@property (weak, nonatomic) IBOutlet UILabel *refreshRate;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)checkBtnAction:(UIButton *)sender;

@end

@implementation DisplayLinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"屏幕刷新监听器";
    self.view.layer.contents = @"点我";
    [self resetDisplayLink];
    

}


- (void)resetDisplayLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDisplayLink:)];
    //selector触发间隔（默认屏幕刷新一次，调用一次）
//    self.displayLink.frameInterval = 1;
    //30相当于屏幕刷新二次，调用一次）
    self.displayLink.preferredFramesPerSecond = 30;
    self.displayLink.paused = YES;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateDisplayLink:(CADisplayLink*)link{
    
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    NSString *fpsString = [NSString stringWithFormat:@"%zd FPS",(int)round(fps)];
    self.refreshRate.text = fpsString;
    
    
    //模拟耗时
    while (1) {
        NSInteger count = 1;
        NSInteger maxCount = arc4random_uniform(1000000);
        for (NSInteger i=1; i<maxCount; i++) {
            NSString *countString = [NSString stringWithFormat:@"%d",count];
            count = [countString doubleValue];
            count = (count + i)*count/(count+1);
        }
        break;
    }
}

- (void)startAnimation{
    
    self.displayLink.paused = NO;
    
}

- (void)stopAnimation{
    
    self.displayLink.paused = YES;
    
    [self.displayLink invalidate];
    
    self.displayLink = nil;
}


- (IBAction)checkBtnAction:(UIButton *)sender {
    
    if (!self.displayLink) {
        NSLog(@"监听服务已销毁");
        return;
    }
    
    if (self.displayLink.paused) {
        [sender setTitle:@"监听器持续监听中..." forState:UIControlStateNormal];
        [self startAnimation];
    } else {
        [self stopAnimation];
        [sender setTitle:@"监听器被销毁" forState:UIControlStateNormal];
        sender.enabled = YES;
    }
}
@end
