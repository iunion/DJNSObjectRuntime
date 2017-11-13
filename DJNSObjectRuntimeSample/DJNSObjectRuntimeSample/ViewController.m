//
//  ViewController.m
//  DJNSObjectRuntimeSample
//
//  Created by DJ on 2017/9/12.
//  Copyright © 2017年 DennisDeng. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+DJRuntime.h"
#import "NSObject+Category.h"

#import "NSObject+DJRuntimeUtility.h"

#import "DJClassInfor.h"

#import "AAA.h"
#import "BBB.h"

#import "Person.h"


@interface ViewController ()

@property (nonatomic, strong) UITextField *classTextField;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //DJClassInfor *viewClassInfor = [DJClassInfor classInfoWithClass:[UIView class]];
    //Class metaClass = objc_getMetaClass(class_getName([UIView class]));
    //DJClassInfor *viewClassInfor1 = [DJClassInfor classInfoWithClass:metaClass];

//    BBB *bb = [[BBB alloc] init];
//    DJClassInfor *viewClassInfor2 = [DJClassInfor classInfoWithClass:[BBB class]];
//    NSString *cd = @(@encode(char));
//    BOOL cc = [DJObjectManager isClassFromFoundation:[AAA class]];
    
    [self testPerson];
}

- (void)testPerson
{
    self.person = [[Person alloc] init];
    self.person.name = @"lala";
    self.person.age = 18;
    self.person.gender = @"female";
    self.person.city = @"beijing";

    NSLog(@"className: %@", [self.person className]);
    [self.person getInstanceSize];
    
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

    // 获取方法的信息
    Method classMethod = [Person getClassMethodWithSelector:@selector(classMethodTest)];
    NSLog(@"%s %u", sel_getName(method_getName(classMethod)), method_getNumberOfArguments(classMethod)-2);

    Method classMethod1 = [Person getClassMethodWithSelector:@selector(getClassMethodWithSelector:)];
    NSLog(@"%s %u", sel_getName(method_getName(classMethod1)), method_getNumberOfArguments(classMethod1)-2);
    Method classMethod2 = [NSObject getClassMethodWithSelector:@selector(getClassMethodWithSelector:)];
    NSLog(@"%s %u", sel_getName(method_getName(classMethod2)), method_getNumberOfArguments(classMethod2)-2);

    Method method = [self.person getInstanceMethodWithSelector:@selector(runtimeTestAction1)];
    NSLog(@"%s %u", sel_getName(method_getName(method)), method_getNumberOfArguments(method)-2);
    Method method1 = [self.person getInstanceMethodWithSelector:@selector(doBaseAction)];
    NSLog(@"%s %u", sel_getName(method_getName(method1)), method_getNumberOfArguments(method1)-2);
    Method method2 = [self.person getInstanceMethodWithSelector:@selector(doOptionalAction)];
    NSLog(@"%s %u", sel_getName(method_getName(method2)), method_getNumberOfArguments(method2)-2);

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
    
    // 设置对象实例变量
    ivar = [self.person setInstanceVariableWithIvarName:@"_name" value:@"new name"];
    NSLog(@"name: %@", self.person.name);
    [self.person setIvarValue:ivar value:@"lala"];
    NSLog(@"name: %@", self.person.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
