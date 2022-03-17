//
//  NSObject+GACRetainCount.m
//  GACTravel_Client
//
//  Created by zhongxiaoming on 2022/2/10.
//

#import "NSObject+GACRetainCount.h"

@implementation NSObject (GACRetainCount)

extern uintptr_t _objc_rootRetainCount(id obj);
extern id _objc_rootRetain(id obj);
extern void _objc_rootRelease(id obj);
extern id _objc_rootAutorelease(id obj);

- (NSUInteger)rq_retainCount
{
    return _objc_rootRetainCount(self);
}

- (void)printRetainCount
{
    NSLog(@"obj:<%@> retainCount:%lu", self, [self rq_retainCount]);
}

- (id)rq_retain
{
    return _objc_rootRetain(self);
}

- (void)rq_release
{
    _objc_rootRelease(self);
}

- (id)rq_autorelease
{
    return _objc_rootAutorelease(self);
}



@end
