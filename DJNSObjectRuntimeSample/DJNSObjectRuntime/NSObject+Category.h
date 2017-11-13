//
//  NSObject+Category.h
//  DJkit
//
//  Created by DennisDeng on 12-8-7.
//  Copyright (c) 2012年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

- (BOOL)isValided;
- (BOOL)isNotNSNull;
- (BOOL)isNotEmpty;
- (BOOL)isNotEmptyDictionary;

@end

@interface NSObject (Boolean)

- (BOOL)isNotProxy;

- (BOOL)isNotKindOfClass:(nonnull Class)aClass;
- (BOOL)isNotMemberOfClass:(nonnull Class)aClass;
- (BOOL)notConformsToProtocol:(nonnull Protocol *)aProtocol;

- (BOOL)notRespondsToSelector:(nonnull SEL)aSelector;

@end
