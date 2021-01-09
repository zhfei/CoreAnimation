//
//  TLImageHelper.m
//  CoreAnimation
//
//  Created by zhoufei on 2020/12/23.
//  Copyright © 2020 X. All rights reserved.
//

#import "TLImageHelper.h"

@implementation TLImageHelper
+ (UIImage *)thumbnailWithImagePath:(NSString *)imagePath toPointSize:(CGSize)pointSize scale:(CGFloat)scale {
    
    //获取imageSourceRef
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:imagePath], 0);
    
    //缩略图配置
    CGFloat maxDimensionInPixels = MIN(pointSize.width, pointSize.height) * scale;
    CFDictionaryRef options = (__bridge CFDictionaryRef)@{
        (id)kCGImageSourceCreateThumbnailWithTransform:@(YES),
        (id)kCGImageSourceThumbnailMaxPixelSize:@(maxDimensionInPixels),
        (id)kCGImageSourceCreateThumbnailFromImageAlways:@(YES),
        (id)kCGImageSourceShouldCacheImmediately:@(YES)
    };
    
    //生成缩略图
    CGImageRef thumbnailRef = CGImageSourceCreateThumbnailAtIndex(imageSourceRef, 0, options);
    CFRelease(imageSourceRef);
    
    UIImage *thumbnailImage = [UIImage imageWithCGImage:thumbnailRef];
    CFRelease(thumbnailRef);
    
    return thumbnailImage;
}

+ (NSString *)thumbnailPathWithImagePath:(NSString *)imagePath toPointSize:(CGSize)pointSize scale:(CGFloat)scale {
    NSArray<NSString *> *components = [imagePath componentsSeparatedByString:@"."];
    NSString *comFirst = [components.firstObject stringByAppendingString:@"_thumbnail"];
    NSString *thumbnailPath = [NSString stringWithFormat:@"%@.%@",comFirst,components.lastObject];
    
    UIImage *image = [self thumbnailWithImagePath:imagePath toPointSize:pointSize scale:scale];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [imageData writeToFile:thumbnailPath atomically:YES];
    
    return thumbnailPath;
}
@end
