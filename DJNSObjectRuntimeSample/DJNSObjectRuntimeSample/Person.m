//
//  Person.m
//  RunTimeDemo
//
//  Created by xietao on 16/4/20.
//  Copyright © 2016年 xietao3. All rights reserved.
//

#import "Person.h"

@interface Person ()
{
    NSString *addInfo;
}
@end

@implementation Person
@synthesize protocolString = _protocolString;

+ (void)classMethodTest
{
    NSLog(@"classMethodTest");
}

- (void)doBaseAction
{
    NSLog(@"doBaseAction");
}

- (void)runtimeTestAction1
{
    NSLog(@"runtimeTestAction1");
}

- (void)runtimeTestAction2
{
    NSLog(@"runtimeTestAction2");
}

- (void)runtimeTestAction3
{
    NSLog(@"runtimeTestAction3");
}

@end
