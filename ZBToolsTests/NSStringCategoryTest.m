//
//  NSStringCategoryTest.m
//  ZBToolsTests
//
//  Created by 张宝 on 2019/2/18.
//  Copyright © 2019 zb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+ZB.h"

@interface NSStringCategoryTest : XCTestCase

@end

@implementation NSStringCategoryTest

- (void)testObjFromJson{
    NSString *str = @"";
    id obj = [str zb_objFromJson];
    NSAssert(obj==nil, @"str length is 0, but obj not nil,%@", obj);
    str = @"sdsrerereere";
    obj = [str zb_objFromJson];
    NSAssert(obj==nil, @"str is unvalid json, but obj not nil, %@", obj);
    str = @"{'a':'b'}";
    obj = [str zb_objFromJson];
    NSAssert(obj==nil, @"str is nonstandard json, but obj not nil, %@", obj);
    str = @"{\"a\":\"b\"}";
    obj = [str zb_objFromJson];
    NSAssert(obj, @"str is valid dictionary json, but obj is nil");
    NSAssert([obj isKindOfClass:[NSDictionary class]], @"str is valid dictionary json, but obj not NSDictionary, %@", obj);
}

- (void)testTrim{
    NSString *str = @" abc ";
    str = [str zb_trim];
    NSAssert(str.length==3, @"str length not 3, is %@", @(str.length));
    str = @"   abc      ";
    str = [str zb_trim];
    NSAssert(str.length==3, @"str length not 3, is %@", @(str.length));
}

@end
