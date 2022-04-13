//
//  AutoReleasePoolUtil.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/13.
//

#import "AutoReleasePoolUtil.h"

@implementation AutoReleasePoolUtil



//
//static void YYRunLoopAutoreleasePoolObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
//    switch (activity) {
//        case kCFRunLoopEntry: {
//            YYAutoreleasePoolPush();// 进入循环，先创建池子。
//        } break;
//        case kCFRunLoopBeforeWaiting: {//进入休眠前，释放池子里的对象、并且重新创建一个池子。
//            YYAutoreleasePoolPop();
//            YYAutoreleasePoolPush();
//        } break;
//        case kCFRunLoopExit: {
//            YYAutoreleasePoolPop(); // 退出循环，释放池子。
//        } break;
//        default: break;
//    }
//}
//
//static void autoreleasePoolPush (){
//    NSMutableDictionary *dic =  [NSThread currentThread].threadDictionary;
//    NSMutableArray *poolStack = dic[@"YYNSThreadAutoleasePoolStackKey"];
//}
//
//static void autureleasePoolPop (){
//
//}


@end
