//
//  NSObject+Category.m
//  DJkit
//
//  Created by DennisDeng on 12-8-7.
//  Copyright (c) 2012年 DennisDeng. All rights reserved.
//

#import "NSObject+Category.h"
#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif

@implementation NSObject (Category)

- (BOOL)isValided
{
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}

- (BOOL)isNotNSNull
{
	return ![self isKindOfClass:[NSNull class]];
}

- (BOOL)isNotEmpty
{
    return !(self == nil
             || [self isKindOfClass:[NSNull class]]
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
}


- (BOOL)isNotEmptyDictionary
{
    if ([self isNotEmpty])
    {
        return [self isKindOfClass:[NSDictionary class]];
    }
    
    return NO;
}


@end


@implementation NSObject (Boolean)

- (BOOL)isNotProxy
{
    return ![self isProxy];
}

- (BOOL)isNotKindOfClass:(Class)aClass
{
    return ![self isKindOfClass:aClass];
}

- (BOOL)isNotMemberOfClass:(Class)aClass
{
    return ![self isMemberOfClass:aClass];
}

- (BOOL)notConformsToProtocol:(Protocol *)aProtocol
{
    return ![self conformsToProtocol:aProtocol];
}

- (BOOL)notRespondsToSelector:(SEL)aSelector
{
    return ![self respondsToSelector:aSelector];
}

@end
