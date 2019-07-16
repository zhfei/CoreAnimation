//
//  PhoneCallViewController.m
//  CoreAnimation
//
//  Created by 周飞 on 2019/7/15.
//  Copyright © 2019年 X. All rights reserved.
//

#import "PhoneCallViewController.h"
#import "CallingView.h"



@interface PhoneCallViewController ()
@property (nonatomic, strong) CallingView *leftCallView;
@property (nonatomic, strong) CallingView *rightCallView;
@end

@implementation PhoneCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUI];
}

- (void)setupUI {

    [self.view addSubview:self.leftCallView];
    [self.view addSubview:self.rightCallView];
    
    UILabel *label = [UILabel new];
    label.text = @"拨打电话";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.frame = CGRectMake(CGRectGetMaxX(self.leftCallView.frame), CGRectGetMinY(self.leftCallView.frame), CGRectGetMinX(self.rightCallView.frame)-CGRectGetMaxX(self.leftCallView.frame),40);
    [self.view addSubview:label];
}



- (CallingView *)leftCallView {
    if (!_leftCallView) {
        CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
        CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
        
        CallingView *callView = [[CallingView alloc] initWithFrame:CGRectMake(widthS/2-80, heightS/2, 40, 40)];
        callView.layer.cornerRadius = 5;
        callView.layer.borderWidth = 1;
        callView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        callView.layer.masksToBounds = YES;
        _leftCallView = callView;

    }
    return _leftCallView;
}

- (CallingView *)rightCallView {
    if (!_rightCallView) {
        CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
        CGFloat heightS = [UIScreen mainScreen].bounds.size.height;
        
        CallingView *callView = [[CallingView alloc] initWithFrame:CGRectMake(widthS/2+80, heightS/2, 40, 40)];
        callView.layer.cornerRadius = 5;
        callView.layer.borderWidth = 1;
        callView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        callView.layer.masksToBounds = YES;
        _rightCallView = callView;
        
    }
    return _rightCallView;

}


@end
