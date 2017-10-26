//
//  DJObjectProtocol.m
//  DJNSObjectRuntimeSample
//
//  Created by DJ on 2017/9/22.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "DJObjectProtocol.h"

@implementation DJObjectProtocol

- (instancetype)initWithProtocol:(Protocol *)protocol
{
    if (!protocol)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _protocol = protocol;
        [self freshProtocol];
    }
    return self;
}

- (instancetype)initWithProtocolName:(NSString *)protocolName
{
    if (!protocolName)
    {
        return nil;
    }
    
    Protocol *protocol = objc_getProtocol([protocolName cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    return [self initWithProtocol:protocol];
}

- (void)setProtocol:(Protocol *)protocol
{
    if (_protocol != protocol)
    {
        _protocol = protocol;
        [self freshProtocol];
    }
}

- (void)freshProtocol
{
    const char *name = protocol_getName(self.protocol);
    if (name)
    {
        //_name = @(name);
        _name = [NSString stringWithUTF8String:name];
    }

    NSLog(@"%@", _name);
    
    unsigned int count;
    Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList(self.protocol, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++)
    {
        Protocol *protocol = protocols[i];
        [array addObject:[[DJObjectProtocol alloc] initWithProtocol:protocol]];
    }
    
    free(protocols);
    
    _incorporatedProtocols = array;
    
    NSMutableArray *methodsArray = [[NSMutableArray alloc] initWithCapacity:0];
    [methodsArray addObjectsFromArray:[self methodsRequired:YES instance:YES]];
    [methodsArray addObjectsFromArray:[self methodsRequired:YES instance:NO]];
    [methodsArray addObjectsFromArray:[self methodsRequired:NO instance:YES]];
    [methodsArray addObjectsFromArray:[self methodsRequired:NO instance:NO]];
    
    _methods = methodsArray;
}

- (NSArray *)methodsRequired:(BOOL)isRequiredMethod instance:(BOOL)isInstanceMethod
{
    unsigned int count;
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(self.protocol, isRequiredMethod, isInstanceMethod, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++)
    {
        NSString *signature = [NSString stringWithCString:methods[i].types encoding:[NSString defaultCStringEncoding]];
        NSLog(@"%@", signature);
        [array addObject:[[DJObjectProtocolMethod alloc] initWithSelector:methods[i].name typeEncoding:signature]];
    }
    
    free(methods);
    return array;
}

@end


@implementation DJObjectProtocolMethod

- (instancetype)initWithSelector:(SEL)sel typeEncoding:(NSString *)typeEncoding
{
    self = [self init];
    
    if(self)
    {
        _sel = sel;
        
        const char *name = sel_getName(_sel);
        if (name)
        {
            _name = [NSString stringWithUTF8String:name];
        }
        
        _typeEncoding = typeEncoding;
        
        NSLog(@"%@ : %@", _name, _typeEncoding);
    }
    
    return self;
}

@end
