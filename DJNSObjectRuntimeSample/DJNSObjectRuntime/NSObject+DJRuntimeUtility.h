//
//  NSObject+DJRuntimeUtility.h
//  DJNSObjectRuntimeSample
//
//  Created by DJ on 2017/11/9.
//Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DJRuntimeUtility)

+ (NSString *)className;
- (NSString *)className;

// 获取实例大小
- (size_t)getInstanceSize;

// 获取类实例中指定名称成员变量的信息
- (nullable Ivar)getInstanceVariableWithIvarName:(NSString *)ivarname;
- (nullable Ivar)getInstanceVariableWithName:(const char *)name;

// 获取类实例中指定名称属性的信息
- (nullable objc_property_t)getPropertyWithPropertyName:(NSString *)propertyname;
- (nullable objc_property_t)getPropertyWithName:(const char *)name;

// 获取类方法的信息
+ (nullable Method)getClassMethodWithSelector:(SEL)selector;
// 获取实例方法的信息
- (nullable Method)getInstanceMethodWithSelector:(SEL)selector;

// 获取类方法具体实现
+ (nullable IMP)getClassMethodImplementationWithSelector:(SEL)selector;
+ (nullable IMP)getClassMethodImplementation_stretWithSelector:(SEL)selector;
// 获取实例方法具体实现
- (nullable IMP)getMethodImplementationWithSelector:(SEL)selector;
- (nullable IMP)getMethodImplementation_stretWithSelector:(SEL)selector;

// 获取实例的成员变量
- (nullable Ivar)getInstanceVariableWithIvarName:(NSString *)ivarname outValue:(void * _Nullable * _Nullable)outValue;
- (nullable Ivar)getInstanceVariableWithName:(const char *)name outValue:(void * _Nullable * _Nullable)outValue;
- (nullable id)getInstanceVariableWithIvar:(Ivar)ivar;

// 设置对象的成员变量的值
- (nullable Ivar)setInstanceVariableWithIvarName:(NSString *)ivarname value:(nullable void *)value;
- (nullable Ivar)setInstanceVariableWithName:(const char *)name value:(nullable void *)value;
- (void)setIvarValue:(Ivar)ivar value:(nullable void *)value;

@end

NS_ASSUME_NONNULL_END
