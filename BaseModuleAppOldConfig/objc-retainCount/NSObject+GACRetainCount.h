//
//  NSObject+GACRetainCount.h
//  GACTravel_Client
//
//  Created by zhongxiaoming on 2022/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GACRetainCount)

- (NSUInteger)rq_retainCount;
- (void)printRetainCount;

- (id)rq_retain;

- (void)rq_release;

- (id)rq_autorelease;


@end

NS_ASSUME_NONNULL_END
