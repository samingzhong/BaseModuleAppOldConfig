//
//  NSObject+MethodSwizzle.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#import "NSObject+MethodSwizzle.h"
#import <objc/runtime.h>
#import "MethodExchange.h"

@implementation NSObject (MethodSwizzle)


+ (void)swizzleSelectorA:(SEL)selectorA withSelectorB:(SEL)selectorB {
    swizzle(self, selectorA, selectorB);
}


@end
