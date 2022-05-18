//
//  Person.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/9.
//

#import "Person.h"

@interface Person () <NSMutableCopying>

@property (nonatomic, copy) NSString *innerString;

@end

@implementation Person

- (void)baseCommonMethodA {
    NSLog(@"base method a in Person");
}


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


+ (instancetype)autoreleasePerson {
    __autoreleasing Person *p = [[Person alloc] init];
    return p;
}

- (void)dealloc {
//    NSLog(@"dealloc ");
}


@end



@interface XXPerson ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id obj;


//@property (nonatomic, copy) NSString *innerString;

@end


@implementation XXPerson

@dynamic age;
@dynamic innerString;

- (void)doSomeLog {
    Class selfClass = [self class];
    NSLog(@"%@", selfClass);
    Class superClass = [super class];
    NSLog(@"%@", superClass);
    
    NSString *string = @"hello";
    id obj = NSObject.new;
    self.name = string;
    self.obj = obj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self doSomeLog];
    }
    return self;
}

- (void)baseCommonMethodA {
    NSLog(@"base method a in XXPerson");
}

@end
