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
}

- (void)resetData {
    
}

- (void)resetUI {
    
}

#pragma mark - Delegate

#pragma mark - NSCopying

#pragma mark - NSObject


@end
