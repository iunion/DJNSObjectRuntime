//
//  Person.h
//  RunTimeDemo
//
//  Created by xietao on 16/4/20.
//  Copyright © 2016年 xietao3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RuntimeAddProtocol <NSObject>
@property (nonatomic, strong) NSString *addProtocolString;
@optional

- (void)doAddAction;

@end

@protocol RuntimeBaseProtocol <NSObject>
@property (nonatomic, strong) NSString *protocolString;
@optional

- (void)doBaseAction;

@end

@protocol RuntimeProtocol <NSObject, RuntimeBaseProtocol>

@optional

- (void)doOptionalAction;

@end

@interface Person : NSObject <RuntimeProtocol>

@property (nonatomic, strong) Person <RuntimeProtocol, RuntimeAddProtocol> *m_Person;
@property (nonatomic, assign) CGRect m_Rect;
@property (nonatomic, assign) CGRect *m_Char;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, strong) NSString *city;

+ (const char *)classMethodTest:(oneway char)xx;

- (void)runtimeTestAction1;

- (void)runtimeTestAction2;

- (void)runtimeTestAction3;

@end

@interface Person (one)

@property (nonatomic, retain) NSString *newname;

- (void)runtimeTestAction4;

@end

