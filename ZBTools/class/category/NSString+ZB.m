//
//  NSString+ZB.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import "NSString+ZB.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZBJson)

- (id)zb_objFromJson{
    if (self.length<2) {
        return nil;
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves
                                               error:&err];
    if (err) {
        return nil;
    }
    return obj;
}

@end

@implementation NSString (ZBTools)

- (instancetype)zb_trim{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

@end


static NSString * const kZBCharactersGeneralDelimitersToEncode = @":#[]@";
static NSString * const kZBCharactersSubDelimitersToEncode = @"?/!$&'()*+,;=";
@implementation NSString (ZBCoding)

- (instancetype)zb_urlEncoding{
    NSMutableCharacterSet *allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kZBCharactersGeneralDelimitersToEncode stringByAppendingString:kZBCharactersSubDelimitersToEncode]];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
}
- (instancetype)zb_urlEncodingNoRepeat{
    NSString *str = [self zb_urlDecoding];
    return [str zb_urlEncoding];
}
- (instancetype)zb_urlQueryEncoding{
    NSCharacterSet *allowedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
}
- (instancetype)zb_urlQueryEncodingNoRepeat{
    NSString *str = [self zb_urlDecoding];
    return [str zb_urlQueryEncoding];
}
- (instancetype)zb_urlDecoding{
    return [self stringByRemovingPercentEncoding];
}

- (instancetype)zb_md5{
    const char *str = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
