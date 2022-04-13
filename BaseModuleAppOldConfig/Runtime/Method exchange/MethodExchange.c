//
//  MethodExchange.c
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/11.
//

#include "MethodExchange.h"

void swizzle(Class classA, SEL selectorA, SEL selectorB) {
    Method methodA = class_getInstanceMethod(classA, selectorA);
    Method methodB = class_getInstanceMethod(classA, selectorB);

//    class_addMethod(classB, selectorB, method_getImplementation(methodB), method_getTypeEncoding(methodB));
//    BOOL addOK =  class_addMethod(classA, selectorA, class_getMethodImplementation(classA, selectorA), method_getTypeEncoding(methodB));
//    addOK =  class_addMethod(classA, selectorA, class_getMethodImplementation(classA, selectorA), method_getTypeEncoding(methodB));

    // methodA, methodB 有可能为空, 那就
    method_exchangeImplementations(methodA, methodB);
    
//    Method originalMethod = class_getInstanceMethod(classA, selectorA);
//    Method newMethod = class_getInstanceMethod(classB, selectorB);
//    if (!originalMethod || !newMethod) return ;
//
//    BOOL addOK = class_addMethod(classA,
//                    selectorA,
//                    class_getMethodImplementation(classA, selectorA),
//                    method_getTypeEncoding(originalMethod));
//    addOK = class_addMethod(classB,
//                    selectorB,
//                    class_getMethodImplementation(classB, selectorB),
//                    method_getTypeEncoding(newMethod));
//
//    method_exchangeImplementations(class_getInstanceMethod(classA, selectorA),
//                                   class_getInstanceMethod(classB, selectorB));
}
