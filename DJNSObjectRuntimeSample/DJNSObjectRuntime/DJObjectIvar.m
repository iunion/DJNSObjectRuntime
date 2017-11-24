//
//  DJObjectIvar.m
//  DJkit
//
//  Created by DennisDeng on 2017/3/23.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "DJObjectIvar.h"

#import "DJObjectManager.h"

@implementation DJObjectIvar

- (instancetype)initWithIvar:(Ivar)ivar
{
    if (!ivar)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _ivar = ivar;
        [self freshIvar];
    }
    return self;
}

- (void)setIvar:(Ivar)aivar
{
    if (_ivar != aivar)
    {
        _ivar = aivar;
        [self freshIvar];
    }
}

- (void)freshIvar
{
    const char *name = ivar_getName(self.ivar);
    if (name)
    {
        _name = [NSString stringWithUTF8String:name];
        
        NSLog(@"ivarName: %@", _name);
    }
    _offset = ivar_getOffset(self.ivar);
    const char *typeEncoding = ivar_getTypeEncoding(self.ivar);
    if (typeEncoding)
    {
        //NSLog(@"typeEncoding: %@, name: %@", _typeEncoding, _name);
        _type = [[DJObjectType alloc] initWithTypeEncoding:typeEncoding];
    }
}

- (NSArray<NSString *> *)protocols
{
    return self.type.protocols;
}

- (NSString *)typeEncoding
{
    return self.type.typeEncoding;
}

- (Class)cls
{
    if (self.objectClassName)
    {
        return objc_getClass(self.objectClassName.UTF8String);
    }
    
    return nil;
}

- (NSString *)objectClassName
{
    return self.type.objectClassName;
}

- (NSString *)structureName
{
    return self.type.structureName;
}

- (NSString *)unionName
{
    return self.type.unionName;
}

@end
