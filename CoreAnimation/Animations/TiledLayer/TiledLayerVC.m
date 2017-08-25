//
//  TiledLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/23.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "TiledLayerVC.h"


@interface TiledLayerVC ()<CALayerDelegate>
@property (strong, nonatomic)NSString *path;
@end

@implementation TiledLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cuttingBigPic];
    
    [self setupUpView];
    
    [self setupDownView];
}

- (void)setupUpView {
    
    CGFloat heigh = self.view.bounds.size.height*0.5 - 20;
    CGFloat width = self.view.bounds.size.width;

    UIView *upView = [UIView new];
    [upView setBackgroundColor:[UIColor lightGrayColor]];
    [upView setFrame:CGRectMake(0, 0, width, heigh)];
    [self.view addSubview:upView];
    
    UIImageView *imageV = [UIImageView new];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [imageV setImage:[UIImage imageNamed:@"BigPic2"]];
    [imageV setFrame:upView.bounds];
    [upView addSubview:imageV];
    
}

- (void)setupDownView {
    
    CGFloat heigh = self.view.bounds.size.height*0.5 - 20;
    CGFloat width = self.view.bounds.size.width;
    
    UIView *downView = [UIView new];
    [downView setFrame:CGRectMake(0, heigh+20, width, heigh)];
    [self.view addSubview:downView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:downView.bounds];
    [downView addSubview:scrollView];
    
    //初始化CATiledLayer
    CATiledLayer *tiledLayer = [CATiledLayer layer];
    tiledLayer.frame = CGRectMake(0, 0, 2048, 2048);
    tiledLayer.delegate = self;
    tiledLayer.tileSize = CGSizeMake(50, 50);
    [scrollView.layer addSublayer:tiledLayer];
    
    scrollView.contentSize = tiledLayer.bounds.size;
    [tiledLayer setNeedsDisplay];

}

//切割大图
- (void)cuttingBigPic {

    // 贴图大小
    CGFloat tileSize = 50;
    
    // 输出路径
    NSString *outputPath = [self creatBigPicDir];
    self.path = outputPath;
    
    // 加载图像
    UIImage *image = [UIImage imageNamed:@"BigPic2"];
    
    CGFloat fixelW = CGImageGetWidth(image.CGImage);
    CGFloat fixelH = CGImageGetHeight(image.CGImage);
    
    CGSize size = CGSizeMake(fixelW, fixelH);
    CGImageRef imageRef = [image CGImage];
    
    // 计算行列
    NSInteger rows = ceil(size.height / tileSize);
    NSInteger cols = ceil(size.width / tileSize);
    
    // 创建贴图
    for (int y = 0; y < rows; ++y) {
        for (int x = 0; x < cols; ++x) {
            // 取出贴图图像
            CGRect tileRect = CGRectMake(x * tileSize, y * tileSize, tileSize, tileSize);
            CGImageRef tileImage = CGImageCreateWithImageInRect(imageRef, tileRect);
            UIImage *image = [UIImage imageWithCGImage:tileImage];
            
            // 转换成jpeg数据
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            CGImageRelease(tileImage);
            
            // 存储文件
            NSString *path = [outputPath stringByAppendingFormat: @"/pic_%02i_%02i.jpg", x, y];
            [data writeToFile: path atomically: NO];
        }
    }
}

#pragma mark - Tools

- (NSString *)creatBigPicDir {

    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"BigPic"];
    
    [self createDir:path];
    return path;
}

- (BOOL)createDir:(NSString *)dirPath
{
    BOOL creatingSuccess = NO;
    
    BOOL isDir = NO;
    BOOL isCreated = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
    if ( isCreated == NO || isDir == NO )
    {
        NSError* error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(success == NO) {
            NSLog(@"create dir error: %@",error.debugDescription);
        } else {
            creatingSuccess = YES;
        }
    }
    return creatingSuccess;
}


#pragma mark CALayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {

    CATiledLayer *tiledLayer = (CATiledLayer *)layer;
    // 确定贴图坐标
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger x = floorf(bounds.origin.x/tiledLayer.tileSize.width);
    NSInteger y = floorf(bounds.origin.y/tiledLayer.tileSize.height);

    // 加载贴图
    NSString *imageN = [NSString stringWithFormat:@"pic_%02i_%02i.jpg",x,y];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",self.path,imageN];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

    // 绘制贴图
    UIGraphicsPushContext(ctx);
    [image drawInRect:bounds];
    UIGraphicsPopContext();
    
//    NSLog(@"线程：%@",[NSThread currentThread]);
}

@end
