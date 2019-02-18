//
//  ZBUtility.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBUtility : NSObject

+ (BOOL)isEmpty:(id)obj;
+ (BOOL)isString:(id)obj;
+ (BOOL)isArray:(id)obj;
+ (BOOL)isDictionary:(id)obj;
+ (NSArray *)arrayFromJson:(NSString *)json;
+ (NSDictionary *)dictionaryFromJson:(NSString *)json;

#pragma mark - File Operation
+ (BOOL)isFileExist:(NSString *)filePath;
+ (NSString *)documentPath;
+ (NSString *)cachePath;
+ (NSString *)libraryPath;

#pragma mark - NSURL
+ (NSDictionary *)parameterWithUrl:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
