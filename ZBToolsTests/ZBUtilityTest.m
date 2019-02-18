//
//  ZBUtilityTest.m
//  ZBToolsTests
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZBUtility.h"

@interface ZBUtilityTest : XCTestCase

@end

@implementation ZBUtilityTest

- (void)setUp {
}

- (void)tearDown {
}

- (void)testIsEmpty {
    NSString *str = nil;
    NSAssert([ZBUtility isEmpty:str], @"str is nil, but false");
    str = @"";
    NSAssert([ZBUtility isEmpty:str], @"str length is 0, but false");
    str = @" ";
    NSAssert(![ZBUtility isEmpty:str], @"str length > 0, but true");
    id null = [NSNull null];
    NSAssert([ZBUtility isEmpty:null], @"null is NSNull, but false");
    NSArray *arr = nil;
    NSAssert([ZBUtility isEmpty:arr], @"arr is nil, but false");
    arr = @[];
    NSAssert([ZBUtility isEmpty:arr], @"arr count is 0, but false");
    arr = @[@"1"];
    NSAssert(![ZBUtility isEmpty:arr], @"arr count > 0, but true");
    NSDictionary *dic = nil;
    NSAssert([ZBUtility isEmpty:dic], @"dic is nil, but false");
    dic = @{};
    NSAssert([ZBUtility isEmpty:dic], @"dic count is 0, but false");
    dic = @{@"a":@"b"};
    NSAssert(![ZBUtility isEmpty:dic], @"dic count > 0, but true");
    NSData *data = nil;
    NSAssert([ZBUtility isEmpty:data], @"data is nil, but false");
    data = [[NSData alloc] init];
    NSAssert([ZBUtility isEmpty:data], @"data length is 0, but false");
    data = [@"aaa" dataUsingEncoding:NSUTF8StringEncoding];
    NSAssert(![ZBUtility isEmpty:data], @"data length > 0, but true");
}

- (void)testIsString{
    id obj = nil;
    NSAssert(![ZBUtility isString:obj], @"obj is nil, but true");
    obj = @[];
    NSAssert(![ZBUtility isString:obj], @"obj is NSArray, but true");
    obj = @"";
    NSAssert([ZBUtility isString:obj], @"obj is NSString, but false");
}

- (void)testIsArray{
    id obj = nil;
    NSAssert(![ZBUtility isArray:obj], @"obj is nil, but true");
    obj = @"";
    NSAssert(![ZBUtility isArray:obj], @"obj is NSString, but true");
    obj = @[];
    NSAssert([ZBUtility isArray:obj], @"obj is NSArray, but false");
    obj = [@[] mutableCopy];
    NSAssert([ZBUtility isArray:obj], @"obj is NSMutableArray, but false");
}

- (void)testIsDictionary{
    id obj = nil;
    NSAssert(![ZBUtility isDictionary:obj], @"obj is nil, but true");
    obj = @"";
    NSAssert(![ZBUtility isDictionary:obj], @"obj is NSString, but true");
    obj = @{};
    NSAssert([ZBUtility isDictionary:obj], @"obj is NSDictionary, but false");
    obj = [@{} mutableCopy];
    NSAssert([ZBUtility isDictionary:obj], @"obj is NSMutableDictionary, but false");
}

- (void)testArrayFromJson{
    NSString *str = nil;
    id obj = [ZBUtility arrayFromJson:str];
    NSAssert(!obj, @"str is nil, but obj not nil");
    id myid = @[@"1"];
    obj = [ZBUtility arrayFromJson:myid];
    NSAssert(!obj, @"myid is NSArray, but obj not nil");
    str = @"{\"a\":\"aaaaa\"}";
    obj = [ZBUtility arrayFromJson:str];
    NSAssert(!obj, @"str is dictionary json, but obj not nil");
    str = @"[\"1\",\"2\"]";
    obj = [ZBUtility arrayFromJson:str];
    NSAssert(obj, @"str is array json, but obj is nil");
    NSAssert([obj isKindOfClass:[NSArray class]], @"str is array json, but obj not NSArray");
}

- (void)testDictionaryFromJson{
    NSString *str = nil;
    id obj = [ZBUtility dictionaryFromJson:str];
    NSAssert(!obj, @"str is nil, but obj not nil");
    id myid = @[@"1"];
    obj = [ZBUtility dictionaryFromJson:myid];
    NSAssert(!obj, @"myid is NSArray, but obj not nil");
    str = @"[\"1\",\"2\"]";
    obj = [ZBUtility dictionaryFromJson:str];
    NSAssert(!obj, @"str is array json, but obj not nil");
    str = @"{\"a\":\"aaaaa\"}";
    obj = [ZBUtility dictionaryFromJson:str];
    NSAssert(obj, @"str is dictionary json, but obj is nil");
    NSAssert([obj isKindOfClass:[NSDictionary class]], @"str is dictionary json, but obj not NSDictionary");
    
}

- (void)testDocumentPath{
    NSString *path = [ZBUtility documentPath];
    NSAssert(![ZBUtility isEmpty:path], @"document path is nil");
}

- (void)testCachePath{
    NSString *path = [ZBUtility cachePath];
    NSAssert(![ZBUtility isEmpty:path], @"cache path is nil");
}

- (void)testLibraryPath{
    NSString *path = [ZBUtility libraryPath];
    NSAssert(![ZBUtility isEmpty:path], @"library path is nil");
}

- (void)testIsFileExist{
    NSString *path = [ZBUtility cachePath];
    path = [path stringByAppendingPathComponent:@"test.txt"];
    NSError *err;
    [@"aaaaaa" writeToFile:path
                atomically:YES
                  encoding:NSUTF8StringEncoding
                     error:&err];
    NSAssert(!err, @"writeToFile fail, error:%@", err);
    NSAssert([ZBUtility isFileExist:path], @"test.txt exist return false");
    path = [[ZBUtility cachePath] stringByAppendingPathComponent:@"unexist.txt"];
    NSAssert(![ZBUtility isFileExist:path], @"unexist.txt exist return true");
}

- (void)testParameterWithUrl{
    NSString *str = @"dfvdvdf";
    NSDictionary *dic = [ZBUtility parameterWithUrl:str];
    NSAssert(dic==nil, @"str not url, but parameter not nil, %@", dic);
    str = @"https://abc.com/aaa";
    dic = [ZBUtility parameterWithUrl:str];
    NSAssert(dic==nil, @"str is no parameter url, but parameter not nil, %@", dic);
    str = @"https://abc.com/aaa?key=";
    dic = [ZBUtility parameterWithUrl:str];
    NSAssert(dic!=nil&&[dic[@"key"] isEqualToString:@""], @"url不存在参数key,%@", dic);
    str = @"https://abc.com/aaa?key=&k2";
    dic = [ZBUtility parameterWithUrl:str];
    NSAssert(dic!=nil&&[dic[@"key"] isEqualToString:@""]&&dic.count==1, @"url参数应该存在一个,%@", dic);
    str = @"https://abc.com/aaa?key=&k2=123";
    dic = [ZBUtility parameterWithUrl:str];
    BOOL res = dic!=nil&&[dic[@"key"] isEqualToString:@""]&&dic.count==2;
    NSAssert(res&&[dic[@"k2"] isEqualToString:@"123"], @"url参数不正确,%@", dic);
    str = @"https://abc.com/aaa?key=中国";
    dic = [ZBUtility parameterWithUrl:str];
    NSAssert([dic[@"key"] isEqualToString:@"中国"], @"url参数key，不等于中国，%@", dic);
    str = @"https://abc.com/aaa?key=%e4%b8%ad%e5%9b%bd";
    dic = [ZBUtility parameterWithUrl:str];
    NSAssert([dic[@"key"] isEqualToString:@"中国"], @"url参数不对,%@", dic);
}

@end
