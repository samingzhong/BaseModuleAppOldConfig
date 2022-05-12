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

#import <AFNetworking.h>
//#import <AFNetworking/WKWebView+AFNetworking.h>

#import "MyObject_MRC.h"
#import "MyObject_ARC.h"


@interface MyPerson : NSObject
@property (nonatomic, copy) NSString *nickName;
@end
@implementation MyPerson
- (void)helloworld {}

- (void)dealloc {
    
}

@end











@interface AppDelegate () <NSURLSessionDelegate>

@property (nonatomic, assign) NSObject *obj1;

@property (nonatomic, assign) NSObject *obj;

@end

@implementation AppDelegate


//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
//
//}
//
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
//
//}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MyObject_MRC *o = [[MyObject_MRC alloc] init];
    [o startTest];
    
    MyObject_ARC *o1 = [[MyObject_ARC alloc] init];
    [o1 startTest];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"5",@"2",@"3",@"4",@"1"]];
    for (NSString *str in array.copy) { // 不要遍历mutableArray，而是应该拷贝一份数据，然后遍历这份。操作原始数组。
        if ([str isEqual:@"3"]) {
            [array removeObject:str];
        }
    }
//    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isEqualToString:@"3"]) {
//            [array removeObject:obj];
//        }
//    }];
    
//    [[AFHTTPSessionManager manager] GET:@"http://localhost:8000/test.txt" parameters:@{@"[name":@"仲夏名👋a👌", @"?age":@31} headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {

//    NSString *url1 = @"http://localhost:8000/apidata.json";
////    url1 = @"https://www.baidu.com";
//    [[AFHTTPSessionManager manager] GET:url1 parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
////
    NSURL *url = [NSURL URLWithString:@"http://10.10.16.52:8000/huoying.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    void (^networkRequestBlock)(void) = ^ {
        NSURL *url = [NSURL URLWithString:@"http://10.10.16.52:8000/apidata.json"];
//        url = [NSURL URLWithString:@"https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_9266732153990091737%22%7D&n_type=-1&p_from=-1"];
//        NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url];
        NSURLSession *ss = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
        ss = NSURLSession.sharedSession;
        [[ss dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            if ([httpRes isKindOfClass:[NSHTTPURLResponse class]]) {
                NSLog(@"httpRes:%@", httpRes);
                NSString *htmlString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"html:%@", htmlString);
            }
            NSLog(@"data:%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
                }] resume];
//        [[ss dataTaskWithURL:url] resume];
        
        //        [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"obj");
//                }] resume];
        
    };
    networkRequestBlock();
    
//    [[[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        } destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//
//        }] resume];
    
//    [[[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//
//    }] resume];
//
    
    
//    WKWebView *webView = [WKWebView new];
//    WKNavigation *nav = [WKNavigation new];
//    NSProgress *pro;
//    [webView loadRequest:request navigation:nav progress:&pro success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
//        return @"";
//    } failure:^(NSError * _Nonnull error) {
//
//    }];

//    url = [NSURL URLWithString:@"http://10.10.16.52:8000/apidata.json"];
//    request = [NSURLRequest requestWithURL:url];
//
//    [[[AFHTTPSessionManager manager] dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
//
//            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
//
//            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//            }] resume];
    
    // Override point for customization after application launch.
    
//    [JPEngine startEngine];
    
    
//    object_setClass(self, JPEngine.class);
//
//
//
    
//    [ClassB.class swizzleSelectorA:@selector(methodA) withSelectorB:@selector(methodB)];
    
    
    
    ClassA *a = [ClassA classAWithName];
    [a methodA];
    
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
