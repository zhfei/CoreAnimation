//
//  TLImageHelper.h
//  CoreAnimation
//
//  Created by zhoufei on 2020/12/23.
//  Copyright © 2020 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLImageHelper : NSObject
+ (UIImage *)thumbnailWithImagePath:(NSString *)imagePath toPointSize:(CGSize)pointSize scale:(CGFloat)scale;
+ (NSString *)thumbnailPathWithImagePath:(NSString *)imagePath toPointSize:(CGSize)pointSize scale:(CGFloat)scale;
@end

NS_ASSUME_NONNULL_END
