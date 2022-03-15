//
//  Person+A.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/10.
//

#import "Person+A.h"
#import "Person+PersonExtension.h"

@interface Person (A)


@end

@implementation Person (A)

static const char key;

- (void)setCategoryProperty:(NSObject *)categoryProperty {
    
}

- (NSObject *)categoryProperty {
    return nil;
}

@end


@implementation XXPerson(A)

- (void)mainMethod {
    NSLog(@"main method in Person(A)");
}


@end
