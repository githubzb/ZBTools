//
//  NSObject+ZB.h
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZBProperty)

/**
 动态添加对象属性，并赋予值
 
 @param value   属性值
 @param key     属性名
 */
- (void)setNONATOMICCopyValue:(id)value key:(const void *)key;
/**
 动态添加对象属性，并赋予值
 
 @param value   属性值
 @param key     属性名
 */
- (void)setNONATOMICRetainValue:(id)value key:(const void *)key;
/**
 动态添加对象属性，并赋予值
 
 @param value   属性值
 @param key     属性名
 */
- (void)setASSIGNValue:(id)value key:(const void *)key;

/**
 获取属性值
 
 @param key 属性名
 @return    属性值
 */
- (nullable id)propertyValueForKey:(const void *)key;

@end


@interface NSObject (ZBSwizzle)

+ (BOOL)swizzleClass:(Class)originalClass
              method:(SEL)originalSelector
          withMethod:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
