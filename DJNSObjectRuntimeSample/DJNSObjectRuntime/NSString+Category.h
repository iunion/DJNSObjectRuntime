//
//  NSString+Category.h
//  DJkit
//
//  Created by DennisDeng on 12-1-6.
//  Copyright (c) 2012年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

// 删除空白字符
+ (NSString *)stringTrim:(NSString *)str;
+ (NSString *)stringTrimStart:(NSString *)str;
+ (NSString *)stringTrimEnd:(NSString *)str;
// 删除首尾和中间的空白字符
+ (NSString *)stringTrimAllSpace:(NSString *)trimmingStr;

- (NSString *)trim;
- (NSString *)trimSpace;
- (NSString *)trimWithCharacters:(NSString *)characters;
- (NSString *)trimAllSpace;

- (BOOL)containString:(NSString *)string;
- (BOOL)containString:(NSString *)string options:(NSStringCompareOptions)mask;

// 添加随机数
+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram;
+ (NSString *)string:(NSString *)str appendRandom:(NSUInteger)ram startFrom:(NSUInteger)start;

- (NSInteger)indexOfCharacter:(char)character;

- (NSString *)subStringFromCharacter:(char)character;
- (NSString *)subStringToCharacter:(char)character;

- (NSString *)subStringFromChar:(char)charStart toChar:(char)charEnd;


@end


