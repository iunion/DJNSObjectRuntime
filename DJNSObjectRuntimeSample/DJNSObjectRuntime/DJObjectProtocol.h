//
//  DJObjectProtocol.h
//  DJNSObjectRuntimeSample
//
//  Created by DJ on 2017/9/22.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJObjectDefine.h"

@interface DJObjectProtocol : NSObject

@property (nonnull, nonatomic, strong) Protocol *protocol;
@property (nullable, nonatomic, strong, readonly) NSString *name;                 ///< protocol name
@property (nullable, nonatomic, strong, readonly) NSArray *incorporatedProtocols;
@property (nullable, nonatomic, strong, readonly) NSArray *methods;

- (nullable instancetype)initWithProtocol:(nullable Protocol *)protocol;
- (nullable instancetype)initWithProtocolName:(nullable NSString *)protocolName;

- (nullable NSArray *)methodsRequired:(BOOL)isRequiredMethod instance:(BOOL)isInstanceMethod;

@end

@interface DJObjectProtocolMethod : NSObject
//{
//    struct objc_method_description *methods;
//}

@property (nullable, nonatomic, assign, readonly) SEL sel;                        ///< method's selector
@property (nullable, nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nullable, nonatomic, strong, readonly) NSString *typeEncoding;         ///< method's parameter and return types

- (nonnull instancetype)initWithSelector:(nonnull SEL)sel typeEncoding:(nonnull NSString *)typeEncoding;

@end

