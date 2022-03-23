//
//  WeakProxy.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/22.
//

#import "WeakProxy.h"

@interface WeakProxy()

@property (nonatomic, weak) id target;

@end

@implementation WeakProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}


+ (instancetype)weakProxyWithTarget:(id)target {
    return [[WeakProxy alloc] initWithTarget:target];
}

@end
