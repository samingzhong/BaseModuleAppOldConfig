//
//  MethodExchange.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#ifndef MethodExchange_h
#define MethodExchange_h

#include <stdio.h>
//#import <Foundation/Foundation.h>
#import <objc/runtime.h>

void swizzle(Class classA, SEL selectorA, SEL selectorB);


#endif /* MethodExchange_h */
