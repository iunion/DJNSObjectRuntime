//
//  BBB.h
//  OCRuntime
//
//  Created by Nicolas Seriot on 13/05/15.
//  Copyright (c) 2015 Nicolas Seriot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AAA.h"

typedef void (^blockHandler)(NSString *item);

@interface BBB : AAA

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *nameArray;
@property (nonatomic, copy) blockHandler block;

+ (NSString *)classMethod;

@end

@interface BBB (CCCC)

- (NSString *)addString;

@end
