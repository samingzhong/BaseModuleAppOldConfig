//
//  Person.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

//@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL man;
//@property (nonatomic, assign) float f;
//@property (nonatomic, assign) float f1;
//@property (nonatomic, assign) BOOL man1;

//@property (nonatomic, assign) double d;

@property (nonatomic, copy) void (^block)(void);

- (void)mainMethod;

+ (void)classMethod;

+ (instancetype)autoreleasePerson;

- (void)baseCommonMethodA;
@end



@interface XXPerson : Person


@end

NS_ASSUME_NONNULL_END
