//
//  Person.m
//  RunTimeDemo
//
//  Created by xietao on 16/4/20.
//  Copyright © 2016年 xietao3. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

static char NEWNAME_KEY;

@interface Person ()
{
    NSString *addInfo;
}
@end

@implementation Person
@synthesize protocolString = _protocolString;

+ (const char *)classMethodTest:(oneway char)xx
{
    NSLog(@"classMethodTest");
    
    return "xx";
}

- (void)doBaseAction
{
    NSLog(@"doBaseAction");
}

- (void)runtimeTestAction1
{
    NSLog(@"runtimeTestAction1 %p", self.name);
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

@implementation Person (one)
@dynamic newname;

- (NSString *)newname
{
    return (NSString *)objc_getAssociatedObject(self, &NEWNAME_KEY);
}

- (void)setNewname:(NSString *)name
{
    [self willChangeValueForKey:@"newname"];
    objc_setAssociatedObject(self, &NEWNAME_KEY, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"newname"];
}

- (void)runtimeTestAction4
{
    NSLog(@"runtimeTestAction4");
}

@end
