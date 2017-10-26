//
//  NSString+Category.m
//  DJkit
//
//  Created by DennisDeng on 12-1-6.
//  Copyright (c) 2012年 DennisDeng. All rights reserved.
//

#import "NSString+Category.h"
#import "NSObject+Category.h"

@implementation NSString (Category)

+ (NSString *)stringTrim:(NSString *)str
{
    NSString *string1;
    
    string1 = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return string1;
}

+ (NSString *)stringTrimStart:(NSString *)str
{
    NSString *string1;
    
    string1 = [[str stringByAppendingString:@"a"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [string1 substringToIndex:[string1 length]-1];
}

+ (NSString *)stringTrimEnd:(NSString *)str
{
    NSString *string1;
    
    string1 = [[@"a" stringByAppendingString:str] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [string1 substringFromIndex:1];
}

+ (NSString *)stringTrimAllSpace:(NSString *)trimmingStr
{
    return [trimmingStr trimAllSpace];
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// @"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""
- (NSString *)trimWithCharacters:(NSString *)characters
{
    if ([characters isNotEmpty])
    {
        // 定义一个特殊字符的集合
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:characters];
        // 过滤字符串的特殊字符
        return [self stringByTrimmingCharactersInSet:set];
    }
    else
    {
        return self;
    }
}

- (NSString *)trimAllSpace
{
    NSString *resultStr;
    
    resultStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *components = [resultStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ' ' AND SELF != '\t'"]];
    resultStr = [components componentsJoinedByString:@""];
    
    return resultStr;
}

- (BOOL)containString:(NSString *)string
{
    return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
}

- (BOOL)containString:(NSString *)string options:(NSStringCompareOptions)mask
{
    NSUInteger location = [self rangeOfString:string options:mask].location;
    return (location == NSNotFound) ? NO : YES;
}

// 添加随机数
+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram
{
    int randValue = arc4random();
    if (randValue < 0)
    {
        randValue = randValue * -1;
    }
    randValue = randValue % (ram+1);
    return [NSString stringWithFormat:@"%@%d", str, randValue];
}

+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram startFrom:(NSUInteger)start
{
    NSUInteger randValue = arc4random();
    randValue = randValue % (ram+1-start) + start;
    return [NSString stringWithFormat:@"%@%lu", str, (unsigned long)randValue];
}

- (NSInteger)indexOfCharacter:(char)character
{
    for (NSUInteger i = 0; i < [self length]; i++)
    {
        if ([self characterAtIndex:i] == character)
        {
            return i;
        }
    }
    
    return NSNotFound;
}

- (NSString *)subStringFromCharacter:(char)character
{
    NSInteger index = [self indexOfCharacter:character];
    if (index != NSNotFound)
    {
        return [self substringFromIndex:(NSUInteger)index];
    }
    else
    {
        return nil;
    }
}

- (NSString *)subStringToCharacter:(char)character
{
    NSInteger index = [self indexOfCharacter:character];
    if (index != NSNotFound)
    {
        return [self substringToIndex:(NSUInteger)index];
    }
    else
    {
        return nil;
    }
}

- (NSString *)subStringFromChar:(char)charStart toChar:(char)charEnd
{
    NSInteger startIndex = -1, endIndex = 0;
    NSUInteger length = 0;
    
    for (NSUInteger i = 0; i < [self length]; i++)
    {
        if ([self characterAtIndex:i] == charStart && startIndex == -1)
        {
            startIndex = i+1;
            i += 1;
            continue;
        }
        if ([self characterAtIndex:i] == charEnd)
        {
            endIndex = i;
            break;
        }
    }
    
    if (endIndex != 0 && startIndex != -1)
    {
        length = endIndex - startIndex;
    }
    if (length != 0)
    {
        NSRange rang = NSMakeRange(startIndex, length);
        
        return [self substringWithRange:rang];
    }
    
    return nil;
}

@end


