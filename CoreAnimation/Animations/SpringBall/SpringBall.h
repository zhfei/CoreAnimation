//
//  UpDownBall.h
//  CoreAnimation
//
//  Created by 周飞 on 2019/1/22.
//  Copyright © 2019年 X. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SpringBallType) {
    SpringBallTypeUpDown = 0,
    SpringBallTypeBigSmall = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface SpringBall : UIView
+ (SpringBall *)springBall:(SpringBallType)type;
@end

NS_ASSUME_NONNULL_END
