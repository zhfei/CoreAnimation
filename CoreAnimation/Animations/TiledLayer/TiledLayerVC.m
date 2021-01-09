//
//  TiledLayerVC.m
//  CoreAnimation
//
//  Created by zhoufei on 2017/8/23.
//  Copyright © 2017年 ChenDao. All rights reserved.
//

#import "TiledLayerVC.h"
#import "TLImageHelper.h"
// 贴图大小
CGFloat tileSizeWidth = 300;
CGFloat tileSizeHeigh = 300;
NSString *kBigPicName = @"BigPic3.jpg";

CGFloat redBorderWidth = 60;
CGFloat redBorderHight = 50;
CGFloat redBorderLineWidth = 2;

CGFloat upContainerHeight = 300;


@interface TiledLayerVC ()<CALayerDelegate, UIScrollViewDelegate>
@property (strong, nonatomic)NSString *path;
@property (strong, nonatomic)CAShapeLayer *redLayer;

@property (assign, nonatomic)CGSize orginImageSize;
@property (assign, nonatomic)CGSize thumbnailSize;
@property (strong, nonatomic)UIView *upOriginView;

@end

@implementation TiledLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self cuttingBigPic];
    });
    [self setupData];
    
    [self setupUpView];
    [self setupDownView];
    
    [self updateRedLayerPositionWithScrollView:nil];
}

- (void)setupUpView {
    [self.view addSubview:self.upOriginView];
    
    UIImageView *imageV = [UIImageView new];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [imageV setFrame:self.upOriginView.bounds];
    [self.upOriginView addSubview:imageV];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:kBigPicName ofType:nil];
    CGSize pointSize = self.upOriginView.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *thumbnailPath = [TLImageHelper thumbnailPathWithImagePath:imagePath toPointSize:pointSize scale:scale];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:thumbnailPath];
    [imageV setImage:image];
    
    [self.upOriginView.layer addSublayer:self.redLayer];
}

- (void)setupDownView {
    CGFloat heigh = self.view.bounds.size.height*0.5 - 20;
    CGFloat width = self.view.bounds.size.width;
    
    UIView *downView = [UIView new];
    [downView setFrame:CGRectMake(0, heigh+20, width, heigh)];
    [self.view addSubview:downView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:downView.bounds];
    scrollView.delegate = self;
    [downView addSubview:scrollView];
    
    //初始化CATiledLayer
    CATiledLayer *tiledLayer = [CATiledLayer layer];
    tiledLayer.frame = CGRectMake(0, 0, self.orginImageSize.width, self.orginImageSize.height);
    tiledLayer.delegate = self;
    tiledLayer.tileSize = CGSizeMake(tileSizeWidth, tileSizeWidth);
    [scrollView.layer addSublayer:tiledLayer];
    
    scrollView.contentSize = tiledLayer.bounds.size;
    [tiledLayer setNeedsDisplay];

}

- (void)setupData {
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"BigPic"];
    self.path = path;
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:kBigPicName ofType:nil];
    UIImage *imageOri = [[UIImage alloc] initWithContentsOfFile:imagePath];
    self.orginImageSize = imageOri.size;
    
    CGSize pointSize = self.upOriginView.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *thumbnailPath = [TLImageHelper thumbnailPathWithImagePath:imagePath toPointSize:pointSize scale:scale];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:thumbnailPath];
    self.thumbnailSize = image.size;
}

//切割大图
- (void)cuttingBigPic {

    // 贴图大小
    CGSize tileSize = CGSizeMake(tileSizeWidth, tileSizeHeigh);
    
    // 输出路径
    NSString *outputPath = [self creatBigPicDir];
    self.path = outputPath;
    
    // 加载图像
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:kBigPicName ofType:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    CGFloat fixelW = CGImageGetWidth(image.CGImage);
    CGFloat fixelH = CGImageGetHeight(image.CGImage);
    
    CGSize size = CGSizeMake(fixelW, fixelH);
    CGImageRef imageRef = [image CGImage];
    
    // 计算行列
    NSInteger rows = ceil(size.height / tileSize.height);
    NSInteger cols = ceil(size.width / tileSize.width);
    
    // 创建贴图
    for (int y = 0; y < rows; ++y) {
        for (int x = 0; x < cols; ++x) {
            // 取出贴图图像
            CGRect tileRect = CGRectMake(x * tileSize.width, y * tileSize.height, tileSize.width, tileSize.height);
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
    [[NSFileManager defaultManager] removeItemAtPath:dirPath error:nil];
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

- (void)updateRedLayerPositionWithScrollView:(UIScrollView *)scrollView {
    //原始尺寸
    CGFloat thumbnailImageWidth = self.thumbnailSize.width;
    CGFloat thumbnailImageHeight = self.thumbnailSize.height;
    CGFloat thumbnailContionerWidth = CGRectGetWidth(self.upOriginView.frame);
    CGFloat thumbnailContionerHeight = CGRectGetHeight(self.upOriginView.frame);
    
    //按比例缩放展示时缩放因子
    CGFloat changeScale = thumbnailContionerWidth/thumbnailImageWidth;
    CGFloat changeWidth = thumbnailContionerWidth;
    CGFloat changeHeight = thumbnailImageHeight*changeScale;
    
    //红框初始位置
    CGFloat initX = (thumbnailContionerWidth - changeWidth)/2;
    CGFloat initY = (thumbnailContionerHeight - changeHeight)/2;
    
    //原图与缩略图缩放因子
    CGFloat widthScale = changeWidth/self.orginImageSize.width;
    CGFloat heightScale = changeHeight/self.orginImageSize.height;
    
    if (scrollView) {
        CGFloat mapX = widthScale*scrollView.contentOffset.x + initX;
        CGFloat mapY = heightScale*scrollView.contentOffset.y + initY;
        if (mapX+redBorderWidth > changeWidth+initX) {
            mapX = changeWidth+initX - redBorderWidth;
        }
        
        if (mapY+redBorderHight > changeHeight+initY) {
            mapY = changeHeight+initY - redBorderHight;
        }
        
        self.redLayer.frame = CGRectMake(mapX, mapY, redBorderWidth, redBorderHight);
    } else {
        self.redLayer.frame = CGRectMake(initX, initY, redBorderWidth, redBorderHight);
    }
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

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //更新地图位置
    [self updateRedLayerPositionWithScrollView:scrollView];
}

#pragma mark Getter、Setter
- (CAShapeLayer *)redLayer {
    if (!_redLayer) {
        UIBezierPath *bp = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, redBorderWidth, redBorderHight) cornerRadius:5];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = bp.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = redBorderLineWidth;
        layer.strokeColor = [UIColor redColor].CGColor;
        _redLayer = layer;
    }
    return _redLayer;
}

- (UIView *)upOriginView {
    if (!_upOriginView) {
        _upOriginView = [UIView new];
        CGFloat heigh = upContainerHeight;
        CGFloat width = self.view.bounds.size.width;
        [_upOriginView setBackgroundColor:[UIColor lightGrayColor]];
        [_upOriginView setFrame:CGRectMake(0, 0, width, heigh)];
    }
    return _upOriginView;
}

@end
