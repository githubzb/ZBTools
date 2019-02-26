//
//  ZBDeviceUUID.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/26.
//  Copyright © 2019 zb. All rights reserved.
//

#import "ZBDeviceUUID.h"
#import <UIKit/UIKit.h>
#import <Security/Security.h>

NSString * const ZBKeychainService = @"com.zb.tools.device.uuid";

@implementation ZBDeviceUUID

+ (NSString *)uuid{
    NSString *uuid = [self readUUID];
    if (uuid.length>0) {
        return uuid;
    }
    uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [self saveUUID:uuid];
    return uuid;
}

#pragma mark - private
//keychain save
+ (void)saveUUID:(NSString *)uuid{
    NSData *uuidData = [uuid dataUsingEncoding:NSUTF8StringEncoding];
    // if uuid was existed, update
    NSString *originUUID = [self readUUID];
    if (originUUID.length > 0) {
        //update
        NSMutableDictionary *updateAttributes = [NSMutableDictionary dictionary];
        updateAttributes[(__bridge id)kSecValueData] = uuidData;
        NSMutableDictionary *query = [self keychainQuery];
        OSStatus statusCode = SecItemUpdate(
                                            (__bridge CFDictionaryRef)query,
                                            (__bridge CFDictionaryRef)updateAttributes);
        NSAssert(statusCode == noErr, @"Couldn't update the Keychain Item." );
    }else{
        //save
        NSMutableDictionary *attributes = [self keychainQuery];
        attributes[(__bridge id)kSecValueData] = uuidData;
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
        NSAssert(status == noErr, @"Couldn't add the Keychain Item.");
    }
}
// keychain read
+ (NSString *)readUUID{
    NSMutableDictionary *attributes = [self keychainQuery];
    attributes[(__bridge id)kSecMatchLimit] = (__bridge id)(kSecMatchLimitOne);
    attributes[(__bridge id)kSecReturnAttributes] = (__bridge id _Nullable)(kCFBooleanTrue);
    attributes[(__bridge id)kSecReturnData] = (__bridge id _Nullable)(kCFBooleanTrue);
    CFMutableDictionaryRef queryResult = nil;
    OSStatus keychainError = noErr;
    keychainError = SecItemCopyMatching((__bridge CFDictionaryRef)attributes,(CFTypeRef *)&queryResult);
    if (keychainError == errSecItemNotFound) {
        if (queryResult) CFRelease(queryResult);
        return nil;
    }else if (keychainError == noErr) {
        if (queryResult == nil){return nil;}
        NSMutableDictionary *resultDict = (__bridge NSMutableDictionary *)queryResult;
        NSData *passwordData = resultDict[(__bridge id)kSecValueData];
        NSString *password = [[NSString alloc] initWithData:passwordData
                                                   encoding:NSUTF8StringEncoding];
        CFRelease(queryResult);
        return password;
    }else {
        NSAssert(NO, @"Serious error.\n");
        if (queryResult) CFRelease(queryResult);
    }
    return nil;
}

+ (NSMutableDictionary *)keychainQuery{
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    query[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    query[(__bridge id)kSecAttrService] = ZBKeychainService;
    query[(__bridge id)kSecAttrAccount] = @"zb.dr.box";
    return query;
}

+ (BOOL)deleteUUID {
    // Delete the existing item from the keychain.
    NSMutableDictionary *query = [self keychainQuery];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != noErr && status != errSecItemNotFound) {
        return NO;
    }
    return YES;
}

@end
