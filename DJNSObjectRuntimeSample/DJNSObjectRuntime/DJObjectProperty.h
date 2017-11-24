//
//  DJObjectProperty.h
//  DJkit
//
//  Created by DennisDeng on 2017/3/22.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJObjectDefine.h"
#import "DJObjectType.h"

@interface DJObjectProperty : NSObject

// property
@property (nullable, nonatomic, assign) objc_property_t property;
// property's name
@property (nonnull, nonatomic, strong, readonly) NSString *name;
// property's type
@property (nonatomic, assign, readonly) DJEncodingType fullType;
// property's type
@property (nullable, nonatomic, strong, readonly) DJObjectType *type;
// property's ivar name
@property (nonnull, nonatomic, strong, readonly) NSString *ivarName;
// readonly
@property (nonatomic, assign, readonly) BOOL isReadonly;
// getter (nonnull)
@property (nonnull, nonatomic, assign, readonly) SEL getter;
// setter (nonnull)
@property (nonnull, nonatomic, assign, readonly) SEL setter;
// getterName (nonnull)
@property (nonnull, nonatomic, strong, readonly) NSString *getterName;
// setterName (nonnull)
@property (nonnull, nonatomic, strong, readonly) NSString *setterName;

// property's encoding value
@property (nonnull, nonatomic, strong, readonly) NSString *typeEncoding;
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

- (nullable instancetype)initWithProperty:(nullable objc_property_t)property;

@end
