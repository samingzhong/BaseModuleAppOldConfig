//
//  NSObject+size.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 4/27/22.
//

#import "NSObject+size.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@implementation NSObject (size)

- (void)printSizeInfos {
    NSLog(@"==================== obj size infos ==========================\nmalloc_size(%@):%@\class_getInstanceSize(%@):%@", self, @(malloc_size((__bridge const void *)(self))), self, @(class_getInstanceSize([self class])));
    NSLog(@"==================== obj size infos ==========================");
}

@end
