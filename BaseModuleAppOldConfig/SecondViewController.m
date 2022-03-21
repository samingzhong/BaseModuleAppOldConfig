//
//  SecondViewController.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import "SecondViewController.h"
#import "objc-retainCount/NSObject+GACRetainCount.h"
#import <ReactiveObjC.h>







void myFunctionWithBlock(dispatch_block_t block) {
    if (block) {
        block();
    }
}


@interface MyObject : NSObject

@property (nonatomic, strong) void(^block)(void);

- (void)methodWithTestBlock:(void(^)(void))block;

@end

@implementation MyObject

- (void)methodWithTestBlock:(void(^)(void))block {
    self.block = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block();
            //self.block = nil;// 打破循环引用
        }
    });
}

- (void)methodWithTestBlock2:(void(^)(void))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

- (void)methodWithTestBlock3:(void(^)(void))block {
    self.block = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block();
        }
    });
}

@end




@interface SecondViewController ()

@property (nonatomic, strong) MyObject *myObj;

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    // Do any additional setup after loading the view.

    NSString *str = [NSString stringWithFormat:@"sunnyxx"];
    // str是一个autorelease对象，设置一个weak的引用来观察它
    reference = str;
    
    myFunctionWithBlock(^{
        NSLog(@"self :%@", self);
    });

    
//    [self blockTest];
    [self threadSafeCase];
    
}


- (void)threadSafeCase {
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:100];
    NSMutableArray *arr = @[].mutableCopy;
    for (int i=0; i<100; i++) {
        dispatch_async(dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT), ^{
            [arr addObject:[NSObject new]];
        });
    }
}


- (void)blockTest {
    
    self.myObj = MyObject.new;
    [self.myObj methodWithTestBlock:^{
        NSLog(@"self:%@", self);
    }];
    
//    [self.myObj methodWithTestBlock2:^{ //
//        NSLog(@"self:%@", self);
//    }];
    
    
//    [self weakStrongDanceCase];
    
//    [self RACWeakifyStrongifyCase];
    
//    [self RACObserveCase];
}

- (void)RACObserveCase {
    @weakify(self);
    [RACObserve(self, myObj) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSLog(@"hello:%@", self.myObj);
    }];
}

-(void)weakStrongDanceCase {
    self.myObj = [MyObject new];
    __weak __typeof(self)weakSelf = self;
    [self.myObj methodWithTestBlock:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf; // 此处因为只是引用了weakSelf 所以不会增加self的引用计数。
        NSLog(@"hello:%@", strongSelf);
    }];
}

- (void)RACWeakifyStrongifyCase {
    self.myObj = [MyObject new];
    __weak __typeof(self)weakSelf = self;
    [self.myObj methodWithTestBlock:^{
        __strong __typeof(weakSelf) self = weakSelf; // block中允许我们重定义self
        NSLog(@"hello:%@", self);
    }];
    
    //__strong __typeof(weakSelf) self = weakSelf;//Redefinition of 'self'
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
