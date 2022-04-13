//
//  NSObject+Observe.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Observe)

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;


- (void)printClassAllMethod:(Class)cls;

@end

NS_ASSUME_NONNULL_END
