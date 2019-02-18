//
//  NSObject+ZB.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/15.
//  Copyright © 2019 zb. All rights reserved.
//

#import "NSObject+ZB.h"
#import <objc/runtime.h>

@implementation NSObject (ZBProperty)

- (void)setNONATOMICCopyValue:(id)value key:(const void *)key{
    if (key == NULL || value == nil) {
        return;
    }
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setNONATOMICRetainValue:(id)value key:(const void *)key{
    if (key == NULL || value == nil) {
        return;
    }
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setASSIGNValue:(id)value key:(const void *)key{
    if (key == NULL || value == nil) {
        return;
    }
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}
- (id)propertyValueForKey:(const void *)key{
    if (key == NULL) {
        return nil;
    }
    return objc_getAssociatedObject(self, key);
}

@end

@implementation NSObject (ZBSwizzle)

+ (BOOL)swizzleClass:(Class)originalClass
              method:(SEL)originalSelector
          withMethod:(SEL)swizzledSelector{
    if (!(originalClass && originalSelector && swizzledSelector)) {
        return NO;
    }
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

@end
