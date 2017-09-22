//
//  DJObjectMethod.m
//  DJkit
//
//  Created by DennisDeng on 2017/3/23.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "DJObjectMethod.h"
#include "dlfcn.h"

@implementation DJObjectMethod

- (instancetype)initWithMethod:(Method)method
{
    if (!method)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _method = method;
        [self freshMethod];
    }
    return self;
}

- (void)setMethod:(Method)amethod
{
    if (_method != amethod)
    {
        _method = amethod;
        [self freshMethod];
    }
}

- (void)freshMethod
{
    _sel = method_getName(self.method);
    _imp = method_getImplementation(self.method);
    
    const char *name = sel_getName(_sel);
    if (name)
    {
        _name = [NSString stringWithUTF8String:name];
    }
    
    NSLog(@"%@", _name);
    
    const char *typeEncoding = method_getTypeEncoding(self.method);
    if (typeEncoding)
    {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    }
    
    char *returnType = method_copyReturnType(self.method);
    if (returnType)
    {
        _returnTypeEncoding = [NSString stringWithUTF8String:returnType];
        free(returnType);
    }
    
    unsigned int argumentCount = method_getNumberOfArguments(self.method);
    if (argumentCount > 0)
    {
        NSMutableArray *argumentTypes = [NSMutableArray array];
        for (unsigned int i = 0; i < argumentCount; i++)
        {
            char *argumentType = method_copyArgumentType(self.method, i);
            NSString *type = argumentType ? [NSString stringWithUTF8String:argumentType] : nil;
            [argumentTypes addObject:type ? type : @""];
            if (argumentType)
            {
                free(argumentType);
            }
        }
        _argumentTypeEncodings = argumentTypes;
    }
    
    Dl_info info;
    int rc = dladdr(_imp, &info);
    
    if (!rc)  {
        return;
    }

//    printf("-- function %s\n", info.dli_sname);
//    printf("-- program %s\n", info.dli_fname);
//    printf("-- fbase %p\n", info.dli_fbase);
//    printf("-- saddr %p\n", info.dli_saddr);
    
    //NSString *filePath = [NSString stringWithFormat:@"%s", info.dli_fname];
    
#if TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
    NSString *symbolName = @""; // info.dli_sname is unreliable on the device, most of time "<redacted>"
#else
    NSString *symbolName = [NSString stringWithFormat:@"%s", info.dli_sname];
#endif
    
    NSString *categoryName = nil;
    
    NSUInteger startIndex = [symbolName rangeOfString:@"("].location;
    NSUInteger stopIndex = [symbolName rangeOfString:@")"].location;
    if(startIndex != NSNotFound && stopIndex != NSNotFound && startIndex < stopIndex) {
        categoryName = [symbolName substringWithRange:NSMakeRange(startIndex+1, (stopIndex - startIndex)-1)];
    }
    
    _categoryName = categoryName;
}

@end
