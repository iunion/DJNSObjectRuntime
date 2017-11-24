//
//  DJObjectIvar.h
//  DJkit
//
//  Created by DennisDeng on 2017/3/23.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJObjectDefine.h"
#import "DJObjectType.h"

@interface DJObjectIvar : NSObject

// ivar opaque struct
@property (nullable, nonatomic, assign) Ivar ivar;
// Ivar's name
@property (nullable, nonatomic, strong, readonly) NSString *name;
// Ivar's offset
@property (nonatomic, assign, readonly) ptrdiff_t offset;
// Ivar's type
@property (nullable, nonatomic, strong, readonly) DJObjectType *type;

// Ivar's type encoding
@property (nullable, nonatomic, strong, readonly) NSString *typeEncoding;
// protocol array may nil
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols;
// Class may be nil
@property (nullable, nonatomic, assign, readonly) Class cls;
// objectClass Name (nullable)
@property (nullable, nonatomic, strong, readonly) NSString *objectClassName;
// structure Name (nullable)
@property (nullable, nonatomic, strong, readonly) NSString *structureName;
// union Name (nullable)
@property (nullable, nonatomic, strong, readonly) NSString *unionName;

- (nullable instancetype)initWithIvar:(nullable Ivar)ivar;

@end
