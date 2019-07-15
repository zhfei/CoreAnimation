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

@end

@implementation PhoneCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CallingView *callView = [[CallingView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];
    
    callView.layer.cornerRadius = 5;
    callView.layer.borderWidth = 1;
    callView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    callView.layer.masksToBounds = YES;
    
    
    [self.view addSubview:callView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
