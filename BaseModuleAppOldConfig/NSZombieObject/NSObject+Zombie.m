//
//  NSObject+Zombie.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxm on 2022/4/11.
//

#import "NSObject+Zombie.h"
#import <objc/runtime.h>

@interface MyZombieClass : NSObject

@end

@implementation MyZombieClass

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [MyZombieClass instanceMethodSignatureForSelector:@selector(dealException:)];
}

- (void)dealException:(NSString *)info {
    NSString *msg = [NSString stringWithFormat:@"函数安全校验失败，请检查，找不到对应方法 %@", info];
    NSLog(@"msg:%@", msg);
}

- (void)forwardInvocationSafe:(NSInvocation *)invocation {
    NSString *info = [NSString stringWithFormat:@"unrecognized selector [%@] sent to %@", NSStringFromSelector(invocation.selector), NSStringFromClass(self.class)];
    [invocation setSelector:@selector(dealException:)];
    [invocation setArgument:&info atIndex:2];
    [invocation invokeWithTarget:[[self.class alloc] init]];
}


@end




@implementation NSObject (Zombie)




static void swizzleDeallocIfNeeded(Class classToSwizzle) {
    
        NSString *className = NSStringFromClass(classToSwizzle);
        
        SEL deallocSelector = sel_registerName("dealloc");
        
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        
        id newDealloc = ^(__unsafe_unretained id self) {
//            NSLog(@"object execute deallocing:%@", self);
            object_setClass(self, MyZombieClass.class);
        };
        
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        
        if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
            // The class already contains a method implementation.
            Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
            
            // We need to store original implementation before setting new implementation
            // in case method is called at the time of setting.
            originalDealloc = (__typeof__(originalDealloc))method_getImplementation(deallocMethod);
            
            // We need to store original implementation again, in case it just changed.
            originalDealloc = (__typeof__(originalDealloc))method_setImplementation(deallocMethod, newDeallocIMP);
        }
}

+ (void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       // 旧方法
//        swizzleDeallocIfNeeded(self);
    });
}

@end
