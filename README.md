DJNSObjectRuntime
==============

DJNSObjectRuntime is an ObjC wrapper around the Objective-C runtime APIs. <br/>


## Usage

### DJClassInfor
``` objective-c
DJClassInfor *viewClassInfor3 = [DJClassInfor classInfoWithClass:[Person class]];
```

### NSObject+DJRuntime
``` objective-c
// 获取成员变量的信息
Ivar ivar = [self.person getInstanceVariableWithIvarName:@"_protocolString"];
if (ivar)
{
NSLog(@"%s %s", ivar_getTypeEncoding(ivar), ivar_getName(ivar));
}
Ivar ivar1 = [self.person getInstanceVariableWithIvarName:@"addInfo"];
if (ivar1)
{
NSLog(@"%s %s", ivar_getTypeEncoding(ivar1), ivar_getName(ivar1));
}
Ivar ivar2 = [self.person getInstanceVariableWithIvarName:@"_age"];
NSUInteger *age_pointer = (NSUInteger *)((__bridge void *)(self.person) + ivar_getOffset(ivar2));
NSLog(@"%@", @(self.person.age));
NSLog(@"%@", @(*age_pointer));
*age_pointer = 20;
NSLog(@"%@", @(self.person.age));
```
``` objective-c
// 获取属性的信息
objc_property_t property = [self.person getPropertyWithPropertyName:@"protocolString"];
if (property)
{
NSLog(@"%s %s", property_getAttributes(property), property_getName(property));
}

objc_property_t property1 = [self.person getPropertyWithPropertyName:@"protocolS"];
if (property1)
{
NSLog(@"%s %s", property_getAttributes(property1), property_getName(property1));
}
```
``` objective-c
// 获取方法的信息
Method classMethod = [Person getClassMethodWithSelector:@selector(classMethodTest)];
NSLog(@"%s %u", sel_getName(method_getName(classMethod)), method_getNumberOfArguments(classMethod)-kDJNumberOfImplicitArgs);

Method classMethod1 = [Person getClassMethodWithSelector:@selector(getClassMethodWithSelector:)];
NSLog(@"%s %u", sel_getName(method_getName(classMethod1)), method_getNumberOfArguments(classMethod1)-kDJNumberOfImplicitArgs);
Method classMethod2 = [NSObject getClassMethodWithSelector:@selector(getClassMethodWithSelector:)];
NSLog(@"%s %u", sel_getName(method_getName(classMethod2)), method_getNumberOfArguments(classMethod2)-kDJNumberOfImplicitArgs);

Method method = [self.person getInstanceMethodWithSelector:@selector(runtimeTestAction1)];
NSLog(@"%s %u", sel_getName(method_getName(method)), method_getNumberOfArguments(method)-kDJNumberOfImplicitArgs);
Method method1 = [self.person getInstanceMethodWithSelector:@selector(doBaseAction)];
NSLog(@"%s %u", sel_getName(method_getName(method1)), method_getNumberOfArguments(method1)-kDJNumberOfImplicitArgs);
Method method2 = [self.person getInstanceMethodWithSelector:@selector(doOptionalAction)];
NSLog(@"%s %u", sel_getName(method_getName(method2)), method_getNumberOfArguments(method2)-kDJNumberOfImplicitArgs);
```
``` objective-c
// 获取对象实例变量
void *ret;
ivar = [self.person getInstanceVariableWithIvarName:@"_name" outValue:&ret];
NSString *name = (NSString *)ret;
NSLog(@"name: %@", name);
name = [self.person getInstanceVariableWithIvar:ivar];
NSLog(@"name: %@", name);

ivar = [self.person getInstanceVariableWithIvarName:@"_age" outValue:&ret];
NSUInteger age = (NSUInteger)ret;
NSLog(@"age: %@", @(age));
age = (NSUInteger)[self.person getInstanceVariableWithIvar:ivar];
NSLog(@"age: %@", @(age));
```
``` objective-c
// 设置对象实例变量
ivar = [self.person setInstanceVariableWithIvarName:@"_name" value:@"new name"];
NSLog(@"name: %@", self.person.name);
[self.person setIvarValue:ivar value:@"lala"];
NSLog(@"name: %@", self.person.name);

objc_property_t propertyname = [self.person getPropertyWithPropertyName:@"newname"];
if (propertyname)
{
NSLog(@"%s %s", property_getAttributes(propertyname), property_getName(propertyname));
}
ivar = [self.person getInstanceVariableWithIvarName:@"newname" outValue:&ret];
NSLog(@"newname: %@", self.person.newname);
```

## Author
- [Dennis Deng](https://github.com/iunion)

