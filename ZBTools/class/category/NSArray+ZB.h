//
//  NSArray+ZB.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ZBJson)

+ (instancetype)zb_fromJson:(NSString *)json;
- (NSString *)zb_JsonString;
- (NSString *)zb_JsonFormatString;

@end

NS_ASSUME_NONNULL_END
