//
//  ClassB.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#import "ClassB.h"

@implementation BaseClass

- (void)methodB {
    NSLog(@"method B from BaseClass:%@", self);
}


@end



@implementation ClassB

- (void)methodA {
    NSLog(@"method A from ClassA:%@", self);
}

@end
