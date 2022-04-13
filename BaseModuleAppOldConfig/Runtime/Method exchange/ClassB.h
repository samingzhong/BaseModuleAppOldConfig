//
//  ClassB.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BaseClass : NSObject
- (void)methodB;
@end



@interface ClassB : BaseClass


- (void)methodA;

@end

NS_ASSUME_NONNULL_END
