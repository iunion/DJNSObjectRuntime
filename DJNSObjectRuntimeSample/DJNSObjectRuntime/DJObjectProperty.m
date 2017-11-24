//
//  DJObjectProperty.m
//  DJkit
//
//  Created by DennisDeng on 2017/3/22.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "DJObjectProperty.h"
#import "DJObjectManager.h"

#import "DJObjectType.h"

#import "NSString+Category.h"

// See https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6
// Type encoding of the property, the @encode type string of a property
// Type encoding see https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
const char kNSObjectRuntimeAttributeTypeEncoding = 'T';
// The name of the backing instance variable
const char kNSObjectRuntimeAttributeBackingIvar = 'V';
// The property is read-only (readonly)
const char kNSObjectRuntimeAttributeReadOnly = 'R';
// The property is a copy of the value last assigned (copy)
const char kNSObjectRuntimeAttributeCopy = 'C';
// The property is a reference to the value last assigned (retain)
const char kNSObjectRuntimeAttributeRetain = '&';
// The property is non-atomic (nonatomic)
const char kNSObjectRuntimeAttributeNonAtomic = 'N';
// The property defines a custom getter selector name. The name follows the G (for example, GcustomGetter,)
const char kNSObjectRuntimeAttributeCustomGetter = 'G';
// The property defines a custom setter selector name. The name follows the S (for example, ScustomSetter:,)
const char kNSObjectRuntimeAttributeCustomSetter = 'S';
// The property is dynamic (@dynamic)
const char kNSObjectRuntimeAttributeDynamic = 'D';
// The property is a weak reference (__weak)
const char kNSObjectRuntimeAttributeWeak = 'W';
// The property is eligible for garbage collection
const char kNSObjectRuntimeAttributeGarbageCollectable = 'P';
// Specifies the type using old-style encoding
const char kNSObjectRuntimeAttributeOldStyleTypeEncoding = 't';


@implementation DJObjectProperty

- (instancetype)initWithProperty:(objc_property_t)property
{
    if (!property)
    {
        return nil;
    }

    self = [super init];
    
    if (self)
    {
         _property = property;
        [self freshProperty];
    }
    
    return self;
}

- (void)setProperty:(objc_property_t)aproperty
{
    if (_property != aproperty)
    {
        _property = aproperty;
        [self freshProperty];
    }
}

- (void)freshProperty
{
    const char *name = property_getName(self.property);
    if (name)
    {
        //_name = @(name);
        _name = [NSString stringWithUTF8String:name];
        NSLog(@"propertyName: %@", _name);
    }
    
    DJEncodingType type = DJEncodingTypeUnknown;

    NSLog(@"%@", @(property_getAttributes(self.property)));
    
    unsigned int attrCount;
    objc_property_attribute_t *attrs = property_copyAttributeList(self.property, &attrCount);
    for (unsigned int i = 0; i < attrCount; i++)
    {
        NSLog(@"%@, %@", @(attrs[i].name), @(attrs[i].value));

        char attributeChar = attrs[i].name[0];
        switch (attributeChar)
        {
            // Type encoding
            case kNSObjectRuntimeAttributeTypeEncoding:
            {
                if (attrs[i].value)
                {
                    _type = [[DJObjectType alloc] initWithTypeEncoding:attrs[i].value];
                    type = _type.type;
                }
            }
                break;
                
            // Instance variable
            case kNSObjectRuntimeAttributeBackingIvar:
            {
                if (attrs[i].value)
                {
                    _ivarName = [NSString stringWithUTF8String:attrs[i].value];
                }
            }
                break;
                
            case kNSObjectRuntimeAttributeReadOnly:
            {
                _isReadonly = YES;
                type |= DJEncodingTypePropertyReadonly;
            }
                break;
                
            case kNSObjectRuntimeAttributeCopy:
            {
                type |= DJEncodingTypePropertyCopy;
            }
                break;
                
            case kNSObjectRuntimeAttributeRetain:
            {
                type |= DJEncodingTypePropertyRetain;
            }
                break;
                
            case kNSObjectRuntimeAttributeNonAtomic:
            {
                type |= DJEncodingTypePropertyNonatomic;
            }
                break;
                
            case kNSObjectRuntimeAttributeDynamic:
            {
                type |= DJEncodingTypePropertyDynamic;
            }
                break;
                
            case kNSObjectRuntimeAttributeWeak:
            {
                type |= DJEncodingTypePropertyWeak;
            }
                break;
                
            case kNSObjectRuntimeAttributeCustomGetter:
            {
                type |= DJEncodingTypePropertyCustomGetter;
                if (attrs[i].value)
                {
                    _getterName = [NSString stringWithUTF8String:attrs[i].value];
                    if (_getterName)
                    {
                        _getter = NSSelectorFromString(_getterName);
                    }
                }
            }
                break;
                
            case kNSObjectRuntimeAttributeCustomSetter:
            {
                type |= DJEncodingTypePropertyCustomSetter;
                if (attrs[i].value)
                {
                    _setterName = [NSString stringWithUTF8String:attrs[i].value];
                    if (_setterName)
                    {
                        _setter = NSSelectorFromString(_setterName);
                    }
               }
            }
                break;
                
            default: break;
        }
    }
    
    if (attrs)
    {
        free(attrs);
        attrs = NULL;
    }

    _fullType = type;
    
    if (_name.length)
    {
        if (!_getter)
        {
            _getterName = _name;
            _getter = NSSelectorFromString(_name);
        }
        if (!_setter)
        {
            if (_name.length > 1)
            {
                _setterName = [NSString stringWithFormat:@"set%@%@:", [_name substringToIndex:1].uppercaseString, [_name substringFromIndex:1]];
                _setter = NSSelectorFromString(_setterName);
            }
            else
            {
                _setterName = [NSString stringWithFormat:@"set%@:", [_name substringToIndex:1].uppercaseString];
                _setter = NSSelectorFromString(_setterName);
            }
        }
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
