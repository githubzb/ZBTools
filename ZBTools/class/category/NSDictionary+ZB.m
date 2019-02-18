//
//  NSDictionary+ZB.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import "NSDictionary+ZB.h"
#import "NSString+ZB.h"
#import "ZBUtility.h"

@implementation NSDictionary (ZBJson)

+ (instancetype)zb_fromJson:(NSString *)json{
    if ([ZBUtility isEmpty:json]) {
        return nil;
    }
    id obj = [json zb_objFromJson];
    if ([ZBUtility isDictionary:obj]) {
        return obj;
    }
    return nil;
}
- (NSString *)zb_JsonString{
    NSError *err = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:&err];
    if (err) {
        return nil;
        
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSString *)zb_JsonFormatString{
    NSError *err = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&err];
    if (err) {
        return nil;
        
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
