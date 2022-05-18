//
//  MyObject_ARC.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 5/9/22.
//

#import "MyObject_ARC.h"
#import <objc/runtime.h>

#import "objc-retainCount/NSObject+GACRetainCount.h"

@interface MyObject_ARC (){
//    NSObject * _objForDynamic;
}

@property (nonatomic, strong) NSObject *objForDynamic;

@end


@implementation MyObject_ARC

//@dynamic objForDynamic;
@synthesize objForDynamic = _objForDynamic;


- (void)setObjForDynamic:(NSObject *)objForDynamic {

}
//
- (NSObject *)objForDynamic {
    return _objForDynamic;
}


- (void)startTest {
    
    #pragma mark isa
//    所有元类对象的 isa 指针都指向跟元类；
//    根元类（Meta_NSObject）的 superClass 指针指向跟类对象（NSObject）；
//    跟类对象（NSObject）的 superClass 指向为nil；
//
//    作者：康小曹
//    链接：https://www.jianshu.com/p/4bc94bb6d7c4
//    来源：简书
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
    void (^isaTest)(void) = ^ {
        id NSObjectClass = NSObject.class;
        id NSObject_MetaClass = object_getClass(NSObject.class);
        id MyObject_MetaClass = object_getClass(self.class);
        id MyObject_MetaClass_MetaClass = object_getClass(MyObject_MetaClass);
        id NSObject_MetaClass_superClass = class_getSuperclass(NSObject_MetaClass);
        id NSObject_superClass = class_getSuperclass(NSObjectClass);
        NSLog(@"");
    };
    isaTest();
    
    
    #pragma mark dynamic
    self.objForDynamic = [NSObject new];
    
#pragma mark retainCount,autoreleasepool, autorelease
    __block id w = nil;
    void (^reatainCountTest)(void) = ^ {
        #pragma mark 工厂方法创建的对象会自动加入autoreleasepool
        MyObject_ARC *ar_o = [MyObject_ARC myObject];
//        [ar_o autorelease];
//        [ary retain];
        NSString *str = [NSString stringWithFormat:@"12312312test:%@", @10];
        NSString *str2 = [NSString stringWithFormat:@"12312%@", @10];

//        _objc_autoreleasePoolPrint();
        
//
        
        __weak id w_p = nil;
        @autoreleasepool {
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            w_p = mArray;
//            [w_p printRetainCount];
                        [w_p printRetainCount];
                        [mArray printRetainCount];
            [NSObject printAutoreleasepool];

            
            MyObject_ARC *o = [[MyObject_ARC alloc] init]; // mrc下 alloc 返回的对象 retainCount为1，不会因为o变量超出作用域而向o发送release消息，但ARC会。
           __weak id w_o = o;
           // 对__weak 变量的使用并不会向对象发送autorelease消息
           NSLog(@"w_o:%@", w_o);
           NSLog(@"w_o:%@", w_o);
           NSLog(@"w_o:%@", w_o);
           NSLog(@"w_o:%@", w_o);
           
   //        [o release];
           [ar_o printRetainCount];
           [str printRetainCount];
           [str2 printRetainCount];
           [o printRetainCount];
           [NSObject printAutoreleasepool];
        }
        NSLog(@"before");
        [w_p printRetainCount];
        NSLog(@"hello:w_p:%p", w_p);
        
        
    };
    reatainCountTest();
    
    
    // block
    void (^blockTest)(void) = ^ {
        int i;
        [self methodWithBlock:^{
            NSLog(@"hello block:%d", i);
        }];
    };
    blockTest();
    

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        void (^startCurrentThreadRunloop)(void) = ^ {
            [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSRunLoopCommonModes];// 创建runloop，为runloop添加source：端口（进程间数据交互，source1）
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]]; // 启动runloop
            NSThread.currentThread.name = @"MyObject_ARC.thread"; //
        };
        
        #pragma mark 子线程中，performSelector afterDelay:无法起作用，因为子线程的runloop默认是没有开启的。
        startCurrentThreadRunloop();
        [self performSelector:@selector(methodWithBlock:) withObject:^{
            NSLog(@"hello worl");
        } afterDelay:20];
    });
    
    
    
    #pragma mark dispatch source, cancel
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *15), DISPATCH_TIME_FOREVER, 1);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"timer 触发");
        dispatch_source_cancel(timer);
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"timer 取消");
//        dispatch_release(timer);
    });
    dispatch_resume(timer);
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_source_cancel(timer);
//    });
}

- (void)methodWithBlock:(dispatch_block_t)block {
    if (block) {
        block();
    }

    dispatch_block_t tmpBlock = block; // block是方法参数，在栈上，赋值给tmpBlock，会被拷贝到堆上，变成堆上的对象。
    NSLog(@"block:%@, tmpBlock:%@", [block class], [tmpBlock class]);
//    CFRunLoopStop(CFRunLoopGetCurrent());
}

+ (instancetype)myObject {
    __autoreleasing MyObject_ARC *obj = [[self alloc] init]; // 仅在arc下有效
    return obj;
}


- (void)dealloc {
    
}


@end
