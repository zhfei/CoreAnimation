//
//  WaterWaveBallViewController.m
//  CoreAnimation
//
//  Created by 周飞 on 2019/1/16.
//  Copyright © 2019年 X. All rights reserved.
//

#import "WaterWaveBallViewController.h"
#import "WaterWaveBall.h"

@interface WaterWaveBallViewController ()
@property (weak, nonatomic) IBOutlet WaterWaveBall *waterBall;
- (IBAction)sliderAction:(UISlider *)sender;

@end

@implementation WaterWaveBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    
    [self.waterBall startWaveToPercent:0.7];
}

- (void)setupUI {
    [self.waterBall.layer setCornerRadius:self.waterBall.bounds.size.height*0.5];
    [self.waterBall.layer setMasksToBounds:YES];
}


@end
