//
//  UIBezierPath+ZB.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import "UIBezierPath+ZB.h"

// Approximation of control point positions on a bezier to simulate a quarter of a circle.
// This is 1-kappa, where kappa = 4 * (sqrt(2) - 1) / 3
static const float zb_kCircleControlPoint = 0.447715;

@implementation UIBezierPath (ZB)

+ (instancetype)zbRoundedRect:(CGRect)rect
                      topLeft:(CGFloat)tlr
                     topRight:(CGFloat)trr
                   bottomLeft:(CGFloat)blr
                  bottomRight:(CGFloat)brr{
    UIBezierPath *path = [UIBezierPath bezierPath];
    if(isnan(tlr) || isnan(trr) || isnan(blr) || isnan(brr)) {
        return path;
    }
    if (![self zb_isValidPoint:rect.origin] || isnan(rect.size.height) || isnan(rect.size.width)) {
        return path;
    }
    CGPoint topLeftPoint = CGPointMake(rect.origin.x + tlr, rect.origin.y);
    if (![self zb_isValidPoint:topLeftPoint]) {
        return path;
    }
    [path moveToPoint:topLeftPoint];
    
    // +------------------+
    //  \\      top     //
    //   \\+----------+//
    CGPoint topRightPoint = CGPointMake(CGRectGetMaxX(rect) - trr, rect.origin.y);
    if (![self zb_isValidPoint:topRightPoint]) {
        return path;
    }
    [path addLineToPoint:topRightPoint];
    if (trr > 0) {
        [path addCurveToPoint:CGPointMake(CGRectGetMaxX(rect), rect.origin.y + trr)
                controlPoint1:CGPointMake(CGRectGetMaxX(rect) - trr * zb_kCircleControlPoint, rect.origin.y)
                controlPoint2:CGPointMake(CGRectGetMaxX(rect), rect.origin.y + trr * zb_kCircleControlPoint)];
    }
    
    // +------------------+
    //  \\     top      //|
    //   \\+----------+// |
    //                |   |
    //                |rig|
    //                |ht |
    //                |   |
    //                 \\ |
    //                  \\|
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - brr)];
    if (brr > 0) {
        [path addCurveToPoint:CGPointMake(CGRectGetMaxX(rect) - brr, CGRectGetMaxY(rect))
                controlPoint1:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - brr * zb_kCircleControlPoint)
                controlPoint2:CGPointMake(CGRectGetMaxX(rect) - brr * zb_kCircleControlPoint, CGRectGetMaxY(rect))];
    }
    
    // +------------------+
    //  \\     top      //|
    //   \\+----------+// |
    //                |   |
    //                |rig|
    //                |ht |
    //                |   |
    //   //+----------+\\ |
    //  //    bottom    \\|
    // +------------------+
    [path addLineToPoint:CGPointMake(rect.origin.x + blr, CGRectGetMaxY(rect))];
    if (blr > 0) {
        [path addCurveToPoint:CGPointMake(rect.origin.x, CGRectGetMaxY(rect) - blr)
                controlPoint1:CGPointMake(rect.origin.x + blr * zb_kCircleControlPoint, CGRectGetMaxY(rect))
                controlPoint2:CGPointMake(rect.origin.x, CGRectGetMaxY(rect) - blr * zb_kCircleControlPoint)];
    }
    
    // +------------------+
    // |\\     top      //|
    // | \\+----------+// |
    // |   |          |   |
    // |lef|          |rig|
    // |t  |          |ht |
    // |   |          |   |
    // | //+----------+\\ |
    // |//    bottom    \\|
    // +------------------+
    [path addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y + tlr)];
    if (tlr > 0) {
        [path addCurveToPoint:CGPointMake(rect.origin.x + tlr, rect.origin.y)
                controlPoint1:CGPointMake(rect.origin.x, rect.origin.y + tlr * zb_kCircleControlPoint)
                controlPoint2:CGPointMake(rect.origin.x + tlr * zb_kCircleControlPoint, rect.origin.y)];
    }
    return path;
}

#pragma mark - assist
+ (BOOL)zb_isValidPoint:(CGPoint)point{
    return !(isnan(point.x)) && !(isnan(point.y));
}

@end
