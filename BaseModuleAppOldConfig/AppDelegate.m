//
//  AppDelegate.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "JPEngine.h"
#import <objc/runtime.h>

#import "TestObject.h"
#import "NSObject+Observe.h"

#import "MethodExchange.h"

#import "ClassA.h"
#import "ClassB.h"

#import "NSObject+MethodSwizzle.h"


@interface MyPerson : NSObject
@property (nonatomic, copy) NSString *nickName;
@end
@implementation MyPerson
- (void)helloworld {}

- (void)dealloc {
    
}

@end











@interface AppDelegate ()

@property (nonatomic, assign) NSObject *obj1;

@property (nonatomic, assign) NSObject *obj;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [JPEngine startEngine];
    
    
//    object_setClass(self, JPEngine.class);
//
//
//
    
    [ClassB.class swizzleSelectorA:@selector(methodA) withSelectorB:@selector(methodB)];
    
    
//    ClassA *a = ClassA.new;
//    [a methodA];
    
    ClassB *b = ClassB.new;
    [b methodA];
    [b methodB];
    
    BaseClass *bc = BaseClass.new;
    [bc methodB];
    
    
    
    
    
    MyPerson *person = [[MyPerson alloc] init];
    
    __weak MyPerson *waekP = person;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"weakP ----- %@",waekP);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"person ----- %@",person);
        });
    });
    
    
    
    
//    MyPerson *person = MyPerson.new;
    NSLog(@"person:%p", person.class);
    
    {
        self.obj = NSObject.new;
    }
    
    
    
    [self printClassAllMethod:self.class];
    [self addObserver:self forKeyPath:@"obj"];
//    [self addObserver:self forKeyPath:@"obj" options:NSKeyValueObservingOptionNew context:nil];
    [self printClassAllMethod:self.class];
    
    
    person = MyPerson.new;
    
    {
        self.obj = NSObject.new;
    }
//    NSLog(@"self.obj:%@", self.obj);
    
//    int x = 10;
//    while (x --> 0) {
//        printf("%d", x);
//    }
    
    id obj = [NSObject new];
    __weak id obj1 = obj;
    NSLog(@"obj1:%@", obj1);
    NSLog(@"obj1:%@", obj1);
    NSLog(@"obj1:%@", obj1);
    NSLog(@"obj1:%@", obj1);
    NSLog(@"obj1:%@", obj1);
    
    
    
    
    
    {
    self.obj1 = NSObject.new;
    }
    
    
    void (^MyBlock)(void) = ^() {
        NSLog(@"self;%@", self);
    };
    MyBlock();
    
//    [self.obj1 description];
    NSLog(@"obj1:%@", self);

    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = UIColor.redColor;
    
//    MainViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    MainViewController *vc = [MainViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
//    TestObject *obj = TestObject.new;
//    obj.dynamicObject;
    
    
    
    dispatch_queue_t q = dispatch_queue_create("my.q", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(q, ^{
        sleep(1);
        NSLog(@"work 1 in thread:%@", [NSThread currentThread]);
    });
    
    dispatch_async(q, ^{
        sleep(2);
        NSLog(@"work 2 in thread:%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(q, ^{
        NSLog(@"work 3 in thread:%@", [NSThread currentThread]);
    });
    
    dispatch_async(q, ^{
        NSLog(@"end of work");
    });
    
    
    
    
    
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    __block UIBackgroundTaskIdentifier taskId = [application beginBackgroundTaskWithExpirationHandler:^{
//        [application endBackgroundTask:taskId];
//        taskId = UIBackgroundTaskInvalid;
    }];
    
    [self longTimeTaskWithCompletion:^{
        [application endBackgroundTask:taskId];
        taskId = UIBackgroundTaskInvalid;
    }];
}

- (void)longTimeTaskWithCompletion:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i<10; i++) {
            NSLog(@"before sleep:%d", i+1);
            sleep(10*(i+1));
            NSLog(@"after sleep:%d", i+1);
        }
        if (block) {
            block();
        }
    });
}

@end
