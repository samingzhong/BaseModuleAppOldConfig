//
//  MyObject.m
//  base_command_line_demo
//
//  Created by zhongxiaoming on 5/9/22.
//

#import "MyObject_MRC.h"

extern void
_objc_autoreleasePoolPrint(void);

@implementation MyObject_MRC

- (void)startTest {
#pragma mark retainCount,autoreleasepool, autorelease
    __block id w = nil;
    void (^reatainCountTest)(void) = ^ {
        #pragma mark 工厂方法创建的对象会自动加入autoreleasepool
//        MyObject_MRC *ar_o = [MyObject_MRC myObject];
////        [ar_o autorelease];
//        NSObject *ar_o2 = [[[NSObject alloc] init] autorelease];
////        [ary retain];
//        NSString *str = [NSString stringWithFormat:@"test"];
//        _objc_autoreleasePoolPrint();
//        NSLog(@"ary retainCount:%d, str retainCount:%d", [ar_o retainCount], [str retainCount]);
//        
        
        
        MyObject_MRC *o = [[MyObject_MRC alloc] init]; // mrc下 alloc 返回的对象 retainCount为1，不会因为o变量超出作用域而向o发送release消息，但ARC会。
        [o release];
        NSLog(@"hello ");
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
}

- (void)methodWithBlock:(dispatch_block_t)block {
    if (block) {
        block();
    }
    
    dispatch_block_t tmpBlock = block;
    
}

+ (instancetype)myObject {
//    __autoreleasing MyObject *obj = [[self alloc] init]; // 仅在arc下有效
    MyObject_MRC *obj = [[self alloc] init]; // 仅在arc下有效
    //    [obj retain];
    //    [obj retain];
    [obj autorelease];
    return obj;
}


- (void)dealloc {
    [super dealloc];
}


@end
