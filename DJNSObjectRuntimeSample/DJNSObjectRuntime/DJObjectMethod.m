//
//  DJObjectMethod.m
//  DJkit
//
//  Created by DennisDeng on 2017/3/23.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "DJObjectMethod.h"
#include "dlfcn.h"
#import "NSString+Category.h"

// Arguments 0 and 1 are self and _cmd always
const unsigned int kDJNumberOfImplicitArgs = 2;

// See Table 6-2 https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
// const
const char kNSObjectRuntimeMethodTypeQualifierConst = 'r';
// in
const char kNSObjectRuntimeMethodTypeQualifierIn = 'n';
// inout
const char kNSObjectRuntimeMethodTypeQualifierInOut = 'N';
// out
const char kNSObjectRuntimeMethodTypeQualifierOut = 'o';
// bycopy
const char kNSObjectRuntimeMethodTypeQualifierBycopy = 'O';
// byref
const char kNSObjectRuntimeMethodTypeQualifierByref = 'R';
// oneway
const char kNSObjectRuntimeMethodTypeQualifierOneway = 'V';


@interface DJObjectMethod ()

@property (nonatomic, strong) NSDictionary *cachedDyldInfoDictionary;
@property (nonatomic, strong) NSMutableDictionary *descriptionDic;

@end

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
        _descriptionDic = [[NSMutableDictionary alloc] init];
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
    [self.descriptionDic setObject:_name forKey:@"Name"];
    
    const char *typeEncoding = method_getTypeEncoding(self.method);
    if (typeEncoding)
    {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
    }
    
    char *returnType = method_copyReturnType(self.method);
    if (returnType)
    {
        _returnTypeEncoding = [NSString stringWithUTF8String:returnType];
        _returnType = [[DJObjectType alloc] initWithTypeEncoding:returnType];
        free(returnType);
    }
    
    unsigned int argumentCount = method_getNumberOfArguments(self.method);
    if (argumentCount > 0)
    {
        NSMutableArray *argumentTypeEncodings = [NSMutableArray array];
        NSMutableArray *argumentTypes = [NSMutableArray array];
        for (unsigned int i = kDJNumberOfImplicitArgs; i < argumentCount; i++)
        {
            char *argumentType = method_copyArgumentType(self.method, i);
            NSString *type = argumentType ? [NSString stringWithUTF8String:argumentType] : nil;
            [argumentTypeEncodings addObject:type ? type : @""];
            if (argumentType)
            {
                DJObjectType *type = [[DJObjectType alloc] initWithTypeEncoding:argumentType];
                [argumentTypes addObject:type];
                free(argumentType);
            }
            else
            {
                DJObjectType *type = [[DJObjectType alloc] init];
                [argumentTypes addObject:type];
            }
        }
        _argumentTypeEncodings = argumentTypeEncodings;
        _argumentTypes = argumentTypes;
    }
}

- (nonnull NSDictionary *)dyldInfo
{
    IMP imp = method_getImplementation(_method);
    
    Dl_info info;
    int rc = dladdr(imp, &info);
    if (!rc)
    {
        return nil;
    }
    
    //    printf("-- function %s\n", info.dli_sname);
    //    printf("-- program %s\n", info.dli_fname);
    //    printf("-- fbase %p\n", info.dli_fbase);
    //    printf("-- saddr %p\n", info.dli_saddr);
    
    NSString *filePath = [NSString stringWithFormat:@"%s", info.dli_fname];
    
#if TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
    NSString *symbolName = @""; // info.dli_sname is unreliable on the device, most of time "<redacted>"
#else
    NSString *symbolName = [NSString stringWithFormat:@"%s", info.dli_sname];
#endif
    
    NSString *categoryName = [symbolName subStringFromChar:'(' toChar:')'];

    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:2];
    if (filePath)
    {
        md[@"filePath"] = filePath;
    }
    if (symbolName)
    {
        md[@"symbolName"] = symbolName;
    }
    if (categoryName)
    {
        md[@"categoryName"] = categoryName;
    }
    return md;
}

- (NSString *)categoryName
{
    if(_cachedDyldInfoDictionary == nil)
    {
        self.cachedDyldInfoDictionary = [self dyldInfo];
    }
    return _cachedDyldInfoDictionary[@"categoryName"];
}

- (NSString *)symbolName
{
    if(_cachedDyldInfoDictionary == nil)
    {
        self.cachedDyldInfoDictionary = [self dyldInfo];
    }
    return _cachedDyldInfoDictionary[@"symbolName"];
}

- (NSString *)filePath
{
    if(_cachedDyldInfoDictionary == nil)
    {
        self.cachedDyldInfoDictionary = [self dyldInfo];
    }
    return _cachedDyldInfoDictionary[@"filePath"];
}

@end
