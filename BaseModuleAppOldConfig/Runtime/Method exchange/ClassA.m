//
//  ClassA.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#import "ClassA.h"

@implementation ClassA

+ (ClassA *)classAWithName {
    ClassA  *obj = ClassA.new;
    
    return obj;
}

- (void)dealloc {
    
}


- (void)methodA {
    NSLog(@"method A from ClassA:%@", self);
}
@end
