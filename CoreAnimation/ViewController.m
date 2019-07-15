//
//  ViewController.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/21.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "ViewController.h"
#import "TransitionVC.h"
#import "DisplayLinkVC.h"
#import "EAGLLayerVC.h"
#import "EmitterLayerVC.h"
#import "GradientLayerVC.h"
#import "ReplicatorLayerVC.h"
#import "ScrollLayerVC.h"
#import "ShapeLayerVC.h"
#import "TextLayerVC.h"
#import "TiledLayerVC.h"
#import "TransformLayerVC.h"
#import "CompleteViewController.h"
#import "CoreAnimation-Swift.h"
#import "WaterWaveBallViewController.h"
#import "SpringBallViewController.h"
#import "PhoneCallViewController.h"

static NSString *cellID =@"myCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:212/255.0 green:239/255.0 blue:212/255.0 alpha:1];
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.dataSource = @[@"转场动画",@"屏幕刷新监听器",@"OpenGL",@"粒子引擎",@"渐变色",@"重复动画",@"滚动图层",@"ShapeLayer",@"文本图层",@"贴图切割",@"3D动画",@"加载完成动画",@"镂空效果",@"进度条",@"水波纹",@"弹性球",@"电话拨打电话"];
}


#pragma mark UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = tableView.backgroundColor;
    cell.contentView.backgroundColor = tableView.backgroundColor;
    cell.textLabel.backgroundColor = tableView.backgroundColor;
    
    
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            
            CATransition *pushTS = [CATransition animation];
            pushTS.duration = 0.5;
            pushTS.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            pushTS.type = @"cube";
            pushTS.subtype = kCATransitionFromRight;
            
            //将动画添加到navigationController.view.layer上
            [self.navigationController.view.layer addAnimation:pushTS forKey:@"pushanimation"];
            
            
            TransitionVC *tvc = [[TransitionVC alloc] init];
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;
        case 1:
        {
            DisplayLinkVC *dlvc = [[DisplayLinkVC alloc] init];
            [self.navigationController pushViewController:dlvc animated:YES];
        }
            break;
        case 2:
        {
            EAGLLayerVC *evc = [[EAGLLayerVC alloc] init];
            [self.navigationController pushViewController:evc animated:YES];
        }
            break;
        case 3:
        {
            EmitterLayerVC *elvc = [[EmitterLayerVC alloc] init];
            [self.navigationController pushViewController:elvc animated:YES];
        }
            break;
        case 4:
        {
            GradientLayerVC *glvc = [[GradientLayerVC alloc] init];
            [self.navigationController pushViewController:glvc animated:YES];
        }
            break;
        case 5:
        {
            ReplicatorLayerVC *rlvc = [[ReplicatorLayerVC alloc] init];
            [self.navigationController pushViewController:rlvc animated:YES];
        }
            break;
        case 6:
        {
            ScrollLayerVC *slvc = [[ScrollLayerVC alloc] init];
            [self.navigationController pushViewController:slvc animated:YES];
        }
            break;
        case 7:
        {
            ShapeLayerVC *slvc = [[ShapeLayerVC alloc] init];
            [self.navigationController pushViewController:slvc animated:YES];
        }
            break;
        case 8:
        {
            TextLayerVC *tlvc = [[TextLayerVC alloc] init];
            [self.navigationController pushViewController:tlvc animated:YES];
        }
            break;
        case 9:
        {
            TiledLayerVC *tlvc = [[TiledLayerVC alloc] init];
            [self.navigationController pushViewController:tlvc animated:YES];
        }
            break;
        case 10:
        {
            TransformLayerVC *tlvc = [[TransformLayerVC alloc] init];
            [self.navigationController pushViewController:tlvc animated:YES];
        }
            break;
        case 11:
        {
            CompleteViewController *ctvc = [[CompleteViewController alloc] init];
            [self.navigationController pushViewController:ctvc animated:YES];
        }
            break;
            case 12:
        {
            HollowOutVC *hovc = [[HollowOutVC alloc] init];
            [self.navigationController pushViewController:hovc animated:YES];
        }
            break;
        case 13:
        {
            ProgressBarVC *pbvc = [[ProgressBarVC alloc] init];
            [self.navigationController pushViewController:pbvc animated:YES];
        }
            break;
            
        case 14:
        {
            WaterWaveBallViewController *pbvc = [[WaterWaveBallViewController alloc] init];
            [self.navigationController pushViewController:pbvc animated:YES];
        }
            break;
        case 15:
        {
            SpringBallViewController *sbvc = [[SpringBallViewController alloc] init];
            [self.navigationController pushViewController:sbvc animated:YES];
        }
            break;
        case 16:
        {
            PhoneCallViewController *sbvc = [[PhoneCallViewController alloc] init];
            [self.navigationController pushViewController:sbvc animated:YES];
        }
            break;
            
        default:
            break;
    }
}



@end

