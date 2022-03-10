//
//  Person.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/9.
//

#import "Person.h"

@interface Person () <NSMutableCopying>

@end

@implementation Person


- (void)classMethod {
    NSLog(@"hello world");
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    Person *new = [Person allocWithZone:zone];
//    new.name = self.name;
//    new.age = self.age;
    
    return new;
}

- (void)mainMethod {
    NSLog(@"mainMethod in Person");
}
@end



@implementation XXPerson


@end
