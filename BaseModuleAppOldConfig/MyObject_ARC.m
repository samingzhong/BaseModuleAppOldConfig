//
//  MyObject_ARC.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 5/9/22.
//

#import "MyObject_ARC.h"

#import "objc-retainCount/NSObject+GACRetainCount.h"

@interface MyObject_ARC ()

//@property (nonatomic, strong) NSObject *objForDynamic;

@end


@implementation MyObject_ARC

//@dynamic objForDynamic;


//- (void)setObjForDynamic:(NSObject *)objForDynamic {
//
//}
//
//- (NSObject *)objForDynamic {
//    return _objForDynamic;
//}


- (void)startTest {
    
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
//        _objc_autoreleasePoolPrint();
//
        
        
        __autoreleasing MyObject_ARC *o = [[MyObject_ARC alloc] init]; // mrc下 alloc 返回的对象 retainCount为1，不会因为o变量超出作用域而向o发送release消息，但ARC会。
        __weak id w_o = o;
        // 对__weak 变量的使用并不会向对象发送autorelease消息
        NSLog(@"w_o:%@", w_o);
        NSLog(@"w_o:%@", w_o);
        NSLog(@"w_o:%@", w_o);
        NSLog(@"w_o:%@", w_o);
        
//        [o release];
        [ar_o printRetainCount];
        [str printRetainCount];
        [o printRetainCount];
        [NSObject printAutoreleasepool];
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
