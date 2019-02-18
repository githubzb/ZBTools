//
//  UIImage+ZB.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import "UIImage+ZB.h"
#import "UIColor+ZB.h"

@implementation UIImage (ZB)

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}
+ (instancetype)imageWithColorValue:(id)value size:(CGSize)size{
    return [self imageWithColor:[UIColor ZBColor:value] size:size];
}
+ (instancetype)imageWithColorHex:(int)hex size:(CGSize)size{
    return [self imageWithColorValue:@(hex) size:size];
}

@end
