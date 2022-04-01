//
//  AppDelegate.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import "AppDelegate.h"
#import "MainViewController.h"


#import "TestObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    void (^MyBlock)(void) = ^() {
        NSLog(@"self;%@", self);
    };
    MyBlock();
    
    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = UIColor.redColor;
    
    MainViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
//    TestObject *obj = TestObject.new;
//    obj.dynamicObject;
    
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

@end
