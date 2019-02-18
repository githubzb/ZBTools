//
//  UIBezierPath+ZB.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (ZB)

/**
 初始化圆角PATH
 
 @param rect    原型区域
 @param tlr     左上角圆角半径
 @param trr     右上角圆角半径
 @param blr     左下角圆角半径
 @param brr     右下角圆角半径
 @return        UIBezierPath
 */
+ (instancetype)zbRoundedRect:(CGRect)rect
                      topLeft:(CGFloat)tlr
                     topRight:(CGFloat)trr
                   bottomLeft:(CGFloat)blr
                  bottomRight:(CGFloat)brr;

@end

NS_ASSUME_NONNULL_END
