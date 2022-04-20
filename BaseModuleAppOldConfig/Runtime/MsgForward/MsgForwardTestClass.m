//
//  MsgForwardTestClass.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 4/20/22.
//

#import "MsgForwardTestClass.h"
#import <objc/runtime.h>
#import <objc/message.h>


@interface UnRecognizeSelectorHandler : NSObject

@end

@implementation UnRecognizeSelectorHandler

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static UnRecognizeSelectorHandler *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (void)handleUnRecognizeSelector:(NSString *)msg {
    NSLog(@"info:%@", msg);
}

@end



@implementation MsgForwardTestClass


+ (void)gac_swizzleMethod:(SEL)originSelector withMethod:(SEL)newSelector {
    Method origMethod = class_getInstanceMethod(self, originSelector);
    if (!origMethod) {
        return;
    }
    Method newMethod = class_getInstanceMethod(self, newSelector);
    if (!newMethod) {
        return;
    }

    class_addMethod(self,
                    originSelector,
                    class_getMethodImplementation(self, originSelector),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    newSelector,
                    class_getMethodImplementation(self, newSelector),
                    method_getTypeEncoding(newMethod));

    method_exchangeImplementations(class_getInstanceMethod(self, originSelector), class_getInstanceMethod(self, newSelector));
}

+ (void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [self gac_swizzleMethod:@selector(methodSignatureForSelector:) withMethod:@selector(gac_methodSignatureForSelector:)];
    });
}


#pragma mark - 1.resolveInstanceMethod
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    BOOL (^block)(void) =  ^(void){
        if (sel == @selector(methodWithoutImpletation)) {
            #pragma mark 新增一个方法：方法名为：sel，方法实现：method0，类型
//            class_addMethod(self, sel, class_getMethodImplementation(self, @selector(method0)), "v@");
//            class_addMethod(self, sel, (IMP)function0, "v@");
            class_addMethod(self, sel, (IMP)_objc_msgForward, "v@");
            return YES;
        }
        
        return NO;
    };
     block();
    
    return [super resolveInstanceMethod:sel];
}

- (void)method0 {
    NSLog(@"method0");
}

static void function0(id sef, SEL sel, id arg1) {
    NSLog(@"function0");
}

#pragma mark  - 2.forwardingTargetForSelector
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [UnRecognizeSelectorHandler sharedInstance];
//}

#pragma mark - 3.
- (NSMethodSignature *)gac_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [self gac_methodSignatureForSelector:aSelector];
    if ([self respondsToSelector:aSelector] || sign) {
        return sign;
    } else {
        return [UnRecognizeSelectorHandler instanceMethodSignatureForSelector:@selector(handleUnRecognizeSelector:)];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    id target = anInvocation.target;
    SEL sel = anInvocation.selector;
    NSString *message = [NSString stringWithFormat:@"target:%@ unrecognize selector:%@", target, NSStringFromSelector(sel)];
    [anInvocation setTarget:[UnRecognizeSelectorHandler sharedInstance]];
    [anInvocation setSelector:@selector(handleUnRecognizeSelector:)];
    [anInvocation setArgument:&message atIndex:2];
    [anInvocation invoke];
}

@end
