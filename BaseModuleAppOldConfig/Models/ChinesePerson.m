//
//  ChinesePerson.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 5/13/22.
//

#import "ChinesePerson.h"

@interface ChinesePerson ()

@property (nonatomic, copy) NSString *innerString;

@end

@implementation ChinesePerson

@dynamic innerString;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.innerString = @"hello";
    }
    return self;
}


- (void)test {
    self.innerString = @"hello";
}

@end
