//
//  DJObjectType.h
//  DJNSObjectRuntimeSample
//
//  Created by DJ on 2017/11/23.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJObjectDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface DJObjectType : NSObject

@property (nonatomic, assign, readonly) DJEncodingType type;

@property (nonatomic, strong, readonly) NSString *typeEncoding;

@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols; ///< may nil

@property (nullable, nonatomic, strong, readonly) NSString *objectClassName; ///< objectClass Name (nullable)
@property (nullable, nonatomic, strong, readonly) NSString *structureName;   ///< structure Name (nullable)
@property (nullable, nonatomic, strong, readonly) NSString *unionName;       ///< union Name (nullable)

@property (nullable, nonatomic, strong, readonly) DJObjectType *subType;

- (instancetype)initWithTypeEncoding:(const char *)typeEncoding;

@end

NS_ASSUME_NONNULL_END
