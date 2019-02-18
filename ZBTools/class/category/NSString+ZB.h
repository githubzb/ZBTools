//
//  NSString+ZB.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZBJson)

- (id)zb_objFromJson;

@end

@interface NSString (ZBTools)

- (instancetype)zb_trim;

@end

@interface NSString (ZBCoding)

- (instancetype)zb_urlEncoding;
- (instancetype)zb_urlEncodingNoRepeat;
- (instancetype)zb_urlQueryEncoding;
- (instancetype)zb_urlQueryEncodingNoRepeat;
- (instancetype)zb_urlDecoding;

- (instancetype)zb_md5;

@end

NS_ASSUME_NONNULL_END
