//
//  NSObject+MethodSwizzle.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MethodSwizzle)

+ (void)swizzleSelectorA:(SEL)selectorA withSelectorB:(SEL)selectorB;

@end

NS_ASSUME_NONNULL_END
