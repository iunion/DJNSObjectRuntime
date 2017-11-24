//
//  DJObjectType.m
//  DJNSObjectRuntimeSample
//
//  Created by DJ on 2017/11/23.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "DJObjectType.h"

#import "NSString+Category.h"

@implementation DJObjectType

- (instancetype)initWithTypeEncoding:(const char *)typeEncoding
{
    if ((self = [self init]))
    {
        _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        
        [self encodingTypeWith:typeEncoding];
    }
    
    return self;
}

- (void)encodingTypeWith:(const char *)typeEncoding;
{
    char *type = (char *)typeEncoding;
    
    _type = DJEncodingTypeUnknown;

    if (!type)
    {
        return;
    }
    size_t len = strlen(type);
    if (len == 0)
    {
        return;
    }
    
    if (type)
    {
        NSLog(@"%@", @(type));
     
        DJEncodingType qualifier = 0;
        bool prefix = true;
        while (prefix)
        {
            switch (*type)
            {
                case 'r':
                {
                    qualifier |= DJEncodingTypeQualifierConst;
                    type++;
                }
                    break;
                case 'n':
                {
                    qualifier |= DJEncodingTypeQualifierIn;
                    type++;
                }
                    break;
                case 'N':
                {
                    qualifier |= DJEncodingTypeQualifierInout;
                    type++;
                }
                    break;
                case 'o':
                {
                    qualifier |= DJEncodingTypeQualifierOut;
                    type++;
                }
                    break;
                case 'O':
                {
                    qualifier |= DJEncodingTypeQualifierBycopy;
                    type++;
                }
                    break;
                case 'R':
                {
                    qualifier |= DJEncodingTypeQualifierByref;
                    type++;
                }
                    break;
                case 'V':
                {
                    qualifier |= DJEncodingTypeQualifierOneway;
                    type++;
                }
                    break;
                default:
                {
                    prefix = false;
                }
                    break;
            }
        }

        _type = qualifier | DJEncodingTypeUnknown;
        
        switch (*type)
        {
            case 'v': _type = qualifier | DJEncodingTypeVoid; break;
            case 'B': _type = qualifier | DJEncodingTypeBool; break;
            case 'c': _type = qualifier | DJEncodingTypeInt8; break;
            case 'C': _type = qualifier | DJEncodingTypeUInt8; break;
            case 's': _type = qualifier | DJEncodingTypeInt16; break;
            case 'S': _type = qualifier | DJEncodingTypeUInt16; break;
            case 'i': _type = qualifier | DJEncodingTypeInt32; break;
            case 'I': _type = qualifier | DJEncodingTypeUInt32; break;
            case 'l': _type = qualifier | DJEncodingTypeInt32; break;
            case 'L': _type = qualifier | DJEncodingTypeUInt32; break;
            case 'q': _type = qualifier | DJEncodingTypeInt64; break;
            case 'Q': _type = qualifier | DJEncodingTypeUInt64; break;
            case 'f': _type = qualifier | DJEncodingTypeFloat; break;
            case 'd': _type = qualifier | DJEncodingTypeDouble; break;
            case 'D': _type = qualifier | DJEncodingTypeLongDouble; break;
            case '#': _type = qualifier | DJEncodingTypeClass; break;
            case ':': _type = qualifier | DJEncodingTypeSEL; break;
            case '*': _type = qualifier | DJEncodingTypeCString; break;
            case '^': _type = qualifier | DJEncodingTypePointer; break;
            case '[': _type = qualifier | DJEncodingTypeCArray; break;
            case '(': _type = qualifier | DJEncodingTypeUnion; break;
            case '{': _type = qualifier | DJEncodingTypeStruct; break;
            case '@':
            {
                if (len == 2 && *(type + 1) == '?')
                    _type = qualifier | DJEncodingTypeBlock;
                else
                    _type = qualifier | DJEncodingTypeObject;
            }
                break;
            default: _type = qualifier | DJEncodingTypeUnknown;
        }
    }
    
    // NSObject
    if (_type == DJEncodingTypeObject)
    {
        // 检索类名 @"_name_"
        NSScanner *scanner = [NSScanner scannerWithString:_typeEncoding];
        if (![scanner scanString:@"@\"" intoString:NULL])
        {
            return;
        }
        
        NSString *clsName = nil;
        if ([scanner scanUpToCharactersFromSet: [NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&clsName])
        {
            if (clsName.length)
            {
                _objectClassName = clsName;
            }
        }
        
        // 检索 protocol @"_name_<_protocol_><_protocol_>"
        NSMutableArray *protocols = nil;
        while ([scanner scanString:@"<" intoString:NULL])
        {
            NSString* protocol = nil;
            if ([scanner scanUpToString:@">" intoString: &protocol])
            {
                if (protocol.length)
                {
                    if (!protocols)
                    {
                        protocols = [NSMutableArray array];
                    }
                    [protocols addObject:protocol];
                }
            }
            [scanner scanString:@">" intoString:NULL];
        }
        _protocols = protocols;
    }
    else if (_type == DJEncodingTypePointer)
    {
        // 获取指针类型
        DJObjectType *subType = [[DJObjectType alloc] initWithTypeEncoding:type+1];
        _subType = subType;
    }
    else if (_type == DJEncodingTypeStruct)
    {
        _structureName = [_typeEncoding subStringFromChar:'{' toChar:'='];
    }
    else if (_type == DJEncodingTypeUnion)
    {
        _unionName = [_typeEncoding subStringFromChar:'(' toChar:'='];
    }
}

@end
