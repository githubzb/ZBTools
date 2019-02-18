//
//  UIImage+ZB.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZB)

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (instancetype)imageWithColorValue:(id)value size:(CGSize)size;
+ (instancetype)imageWithColorHex:(int)hex size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
