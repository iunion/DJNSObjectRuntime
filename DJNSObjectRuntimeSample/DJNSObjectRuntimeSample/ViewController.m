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

#import "DJClassInfor.h"

#import "AAA.h"
#import "BBB.h"


@interface ViewController ()

@property (nonatomic, strong) UITextField *classTextField;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //DJClassInfor *viewClassInfor = [DJClassInfor classInfoWithClass:[UIView class]];
    //Class metaClass = objc_getMetaClass(class_getName([UIView class]));
    //DJClassInfor *viewClassInfor1 = [DJClassInfor classInfoWithClass:metaClass];

    BBB *bb = [[BBB alloc] init];
    DJClassInfor *viewClassInfor2 = [DJClassInfor classInfoWithClass:[bb class]];

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
