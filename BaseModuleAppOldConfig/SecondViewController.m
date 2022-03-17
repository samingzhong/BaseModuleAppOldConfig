//
//  SecondViewController.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import "SecondViewController.h"
#import "objc-retainCount/NSObject+GACRetainCount.h"


void myFunctionWithBlock(dispatch_block_t block) {
    if (block) {
        block();
    }
}



@interface SecondViewController ()

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    // Do any additional setup after loading the view.

    NSString *str = [NSString stringWithFormat:@"sunnyxx"];
    // str是一个autorelease对象，设置一个weak的引用来观察它
    reference = str;
    
//    __weak __typeof(self)weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//        NSLog(@"retainCount:%ld", [strongSelf rq_retainCount]);
//        NSLog(@"self:%@", strongSelf);
//    });
//
//
//
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//
//        NSLog(@"self:%@", strongSelf);
//    });
    
    myFunctionWithBlock(^{
        NSLog(@"self :%@", self);
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"retainCount:%ld", [self rq_retainCount]);
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

- (void)dealloc {
    NSLog(@"dealloc ");
}


__weak id reference = nil;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", reference); // Console: sunnyxx
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", reference); // Console: (null)
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
