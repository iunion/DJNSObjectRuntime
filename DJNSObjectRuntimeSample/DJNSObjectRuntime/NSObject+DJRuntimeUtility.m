//
//  NSObject+DJRuntimeUtility.m
//  DJNSObjectRuntimeSample
//
//  Created by DJ on 2017/11/9.
//Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "NSObject+DJRuntimeUtility.h"


@implementation NSObject (DJRuntimeUtility)

+ (NSString *)className
{
    return NSStringFromClass(self);
}

- (NSString *)className
{
    return [NSString stringWithUTF8String:class_getName([self class])];
}

- (size_t)getInstanceSize
{
    // 获取实例大小
    size_t size = class_getInstanceSize([self class]);
    NSLog(@"instanceSize: %zu", size);
    return size;
}

// 获取类成员变量的信息（ 无作用，官方解释:http://lists.apple.com/archives/objc-language/2008/Feb/msg00021.html )
- (Ivar)getClassVariableWithName:(const char *)name
{
    Ivar ivar = class_getClassVariable([self class], name);
    return ivar;
}

- (Ivar)getInstanceVariableWithIvarName:(NSString *)ivarname
{
    return [self getInstanceVariableWithName:[ivarname cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (Ivar)getInstanceVariableWithName:(const char *)name
{
    // 获取类实例中指定名称成员变量的信息
    Ivar ivar = class_getInstanceVariable([self class], name);
    return ivar;
}

- (objc_property_t)getPropertyWithPropertyName:(NSString *)propertyname
{
    return [self getPropertyWithName:[propertyname cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (objc_property_t)getPropertyWithName:(const char *)name
{
    // 获取类实例中指定名称属性的信息
    objc_property_t property = class_getProperty([self class], name);
    return property;
}

+ (Method)getClassMethodWithSelector:(SEL)selector
{
    // 获取类方法的信息
    Method method = class_getClassMethod([self class], selector);
    return method;
}

- (Method)getInstanceMethodWithSelector:(SEL)selector
{
    // 获取实例方法的信息
    Method method = class_getInstanceMethod([self class], selector);
    return method;
}

+ (IMP)getClassMethodImplementationWithSelector:(SEL)selector
{
    // 查看类是否相应指定方法
    if (class_respondsToSelector([self class], selector))
    {
        // 获取类方法具体实现
        IMP imp = class_getMethodImplementation([self class], selector);
        return imp;
    }
    
    return nil;
}

+ (IMP)getClassMethodImplementation_stretWithSelector:(SEL)selector
{
    if (class_respondsToSelector([self class], selector))
    {
        IMP imp = class_getMethodImplementation_stret([self class], selector);
        return imp;
    }
    
    return nil;
}

- (IMP)getMethodImplementationWithSelector:(SEL)selector
{
    // 查看实例是否相应指定方法
    if (class_respondsToSelector([self class], selector))
    {
        // 获取实例方法具体实现
        IMP imp = class_getMethodImplementation([self class], selector);
        return imp;
    }
    
    return nil;
}

- (IMP)getMethodImplementation_stretWithSelector:(SEL)selector
{
    if (class_respondsToSelector([self class], selector))
    {
        IMP imp = class_getMethodImplementation_stret([self class], selector);
        return imp;
    }
    
    return nil;
}

- (Ivar)getInstanceVariableWithIvarName:(NSString *)ivarname outValue:(void **)outValue
{
    return [self getInstanceVariableWithName:[ivarname cStringUsingEncoding:NSUTF8StringEncoding] outValue:outValue];
}

- (Ivar)getInstanceVariableWithName:(const char *)name outValue:(void **)outValue
{
    // 获取对象实例变量
    Ivar ivar = object_getInstanceVariable(self, name, outValue);
    //ivar_getName(ivar);
    return ivar;
}

- (id)getInstanceVariableWithIvar:(Ivar)ivar;
{
    // 获取对象中实例变量的值
    id value = object_getIvar (self, ivar);
    
    return value;
}

- (Ivar)setInstanceVariableWithIvarName:(NSString *)ivarname value:(void *)value
{
    return [self setInstanceVariableWithName:[ivarname cStringUsingEncoding:NSUTF8StringEncoding] value:value];
}

- (Ivar)setInstanceVariableWithName:(const char *)name value:(void *)value
{
    // 设置对象的成员变量的值
    Ivar ivar = object_setInstanceVariable(self, name, value);
    
    return ivar;
}

- (void)setIvarValue:(Ivar)ivar value:(void *)value
{
    //设置对象中实例变量的值
    object_setIvar(self, ivar, value);
}

/*
- (BOOL)tryAddPropertyWithPropertyName:(NSString *)propertyname attributes:(NSDictionary *)attributePairs
{
    return [self tryAddPropertyWithName:[propertyname cStringUsingEncoding:NSUTF8StringEncoding] attributes:attributePairs];
}

- (BOOL)tryAddPropertyWithName:(const char *)name attributes:(NSDictionary *)attributePairs
{
    BOOL added = NO;
    objc_property_t property = class_getProperty([self class], name);
    if (!property)
    {
        unsigned int totalAttributesCount = (unsigned int)[attributePairs count];
        objc_property_attribute_t *attributes = malloc(sizeof(objc_property_attribute_t) * totalAttributesCount);
        if (attributes)
        {
            unsigned int attributeIndex = 0;
            for (NSString *attributeName in [attributePairs allKeys])
            {
                objc_property_attribute_t attribute;
                attribute.name = [attributeName UTF8String];
                attribute.value = [attributePairs[attributeName] UTF8String];
                attributes[attributeIndex++] = attribute;
            }
            
            added = class_addProperty([self class], name, attributes, totalAttributesCount);
            free(attributes);
        }
    }
    
    return added;
}
*/
 
@end
