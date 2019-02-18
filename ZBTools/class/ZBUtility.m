//
//  ZBUtility.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import "ZBUtility.h"
#import "NSArray+ZB.h"
#import "NSDictionary+ZB.h"
#import "NSString+ZB.h"

@implementation ZBUtility

+ (BOOL)isEmpty:(id)obj{
    if ([obj isKindOfClass:[NSNull class]] || !obj) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]] && ((NSString *)obj).length==0) {
        return YES;
    }
    if ([obj isKindOfClass:[NSArray class]] && ((NSArray *)obj).count==0) {
        return YES;
    }
    if ([obj isKindOfClass:[NSDictionary class]] && ((NSDictionary *)obj).count==0) {
        return YES;
    }
    if ([obj isKindOfClass:[NSData class]] && ((NSData *)obj).length==0) {
        return YES;
    }
    return NO;
}
+ (BOOL)isString:(id)obj{
    return [obj isKindOfClass:[NSString class]];
}
+ (BOOL)isArray:(id)obj{
    return [obj isKindOfClass:[NSArray class]];
}
+ (BOOL)isDictionary:(id)obj{
    return [obj isKindOfClass:[NSDictionary class]];
}
+ (NSArray *)arrayFromJson:(NSString *)json{
    if ([self isString:json]) {
        return [NSArray zb_fromJson:json];
    }
    return nil;
}
+ (NSDictionary *)dictionaryFromJson:(NSString *)json{
    if ([self isString:json]) {
        return [NSDictionary zb_fromJson:json];
    }
    return nil;
}

#pragma mark - File Operation
+ (BOOL)isFileExist:(NSString *)filePath{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}
+ (NSString *)documentPath{
    static NSString *docPath;
    if (!docPath) {
        docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    }
    return docPath;
}
+ (NSString *)cachePath{
    static NSString *caPath;
    if (!caPath) {
        caPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    }
    return caPath;
}
+ (NSString *)libraryPath{
    static NSString *libPath;
    if (!libPath) {
        libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    }
    return libPath;
}

#pragma mark - NSURL
+ (NSDictionary *)parameterWithUrl:(NSString *)urlString{
    if ([self isEmpty:urlString]) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:[urlString zb_urlQueryEncodingNoRepeat]];
    NSString *query = [url query];
    if ([self isEmpty:query]) {
        return nil;
    }
    NSArray *arr = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:arr.count];
    for (NSString *str in arr) {
        NSArray *list = [str componentsSeparatedByString:@"="];
        if (list.count>1) {
            [dic setValue:[list.lastObject zb_urlDecoding]
                   forKey:list.firstObject];
        }
    }
    return [[NSDictionary alloc] initWithDictionary:dic];
}

@end
