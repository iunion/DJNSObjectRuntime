//
//  BBB.m
//  OCRuntime
//
//  Created by Nicolas Seriot on 13/05/15.
//  Copyright (c) 2015 Nicolas Seriot. All rights reserved.
//

#import "BBB.h"

@implementation BBB

+ (NSString *)classMethod
{
    return @"a";
}

- (NSString *)bbbbbbbbb {
    return @"b";
}

@end

@implementation BBB (CCCC)

- (NSString *)addString
{
    return @"sss";
}

@end
