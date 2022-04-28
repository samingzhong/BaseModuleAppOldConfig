//
//  ClassB.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#import "ClassB.h"
#import <objc/runtime.h>

@implementation BaseClass

- (void)methodB {
    NSLog(@"method B from BaseClass:%@", self);
}


@end



@implementation ClassB

+ (void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        BOOL success = class_addMethod(self, @selector(methodB), imp_implementationWithBlock(^(id sef, SEL sel){
            NSLog(@"methodB from ClassB:%@", self);
        }), "v@:");
        NSLog(@"success:%d", success);
    });
}

//- (void)methodB {}

- (void)methodA {
    NSLog(@"method A from ClassA:%@", self);
}

@end
