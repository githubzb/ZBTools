//
//  UIColor+ZB.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZB)

/**
 实例化UIColor对象
 
 @param value 支持：字符串：#000000 or 000000 or rgb(r,g,b) or rgba(r,g,b,a)或NSNumber
 @return UIColor
 */
+ (instancetype)ZBColor:(id)value;
+ (instancetype)ZBHex:(int)value;

/**
 UIColor十六进制表示值(#000000)

 @return hex String
 */
- (NSString *)zbHexValue;

@end

NS_ASSUME_NONNULL_END
