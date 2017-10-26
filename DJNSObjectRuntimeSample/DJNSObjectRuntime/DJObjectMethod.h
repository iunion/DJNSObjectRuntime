//
//  DJObjectMethod.h
//  DJkit
//
//  Created by DennisDeng on 2017/3/23.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJObjectDefine.h"

@interface DJObjectMethod : NSObject

// method type
@property (nonatomic, assign) BOOL isClassMethod;
// method opaque struct
@property (nullable, nonatomic, assign) Method method;
// method name
@property (nullable, nonatomic, strong, readonly) NSString *name;
// method's selector
@property (nullable, nonatomic, assign, readonly) SEL sel;
// method's implementation
@property (nullable, nonatomic, assign, readonly) IMP imp;
// method's parameter and return types string
@property (nullable, nonatomic, strong, readonly) NSString *typeEncoding;
// return value's type string
@property (nullable, nonatomic, strong, readonly) NSString *returnTypeEncoding;
// array of arguments' type string
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings;

- (nullable instancetype)initWithMethod:(nullable Method)method;

// dyldInfo
- (nonnull NSDictionary *)dyldInfo;
// dyldInfo file path
- (nullable NSString *)filePath;
// dyldInfo symbol name
- (nullable NSString *)symbolName;
// dyldInfo category name
- (nullable NSString *)categoryName;

@end
