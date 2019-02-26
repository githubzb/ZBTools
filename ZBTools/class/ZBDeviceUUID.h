//
//  ZBDeviceUUID.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/26.
//  Copyright © 2019 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBDeviceUUID : NSObject

/**
 获取设备唯一标示符（长度：36，存储在keychain中，UUID生成方式：Vendor）

 @return uuid字符串
 */
+ (NSString *)uuid;

@end

NS_ASSUME_NONNULL_END
