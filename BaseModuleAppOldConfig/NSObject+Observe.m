//
//  NSObject+Observe.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/4/7.
//

#import "NSObject+Observe.h"
#import <objc/runtime.h>

@implementation NSObject (Observe)

+ (void)load {
    
}




#pragma mark **- 遍历方法-ivar-property**
- (void)printClassAllMethod:(Class)cls{
    NSLog(@"Class info from:%@", cls);
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        IMP imp = class_getMethodImplementation(cls, sel);
        NSLog(@"%@-%p",NSStringFromSelector(sel),imp);
    }
    free(methodList);
}




- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    ///------ "addObserver:forKeyPath:options:context:"方法的实现 -----
    /// 动态创建子类
    NSString *newName = [@"KVONotifying_" stringByAppendingString:NSStringFromClass(object_getClass(self))];
    Class originClass = object_getClass(self);
    NSString *setterName = [[@"set" stringByAppendingString:[[[keyPath uppercaseString] substringToIndex:1] stringByAppendingString:[keyPath substringFromIndex:1]]] stringByAppendingString:@":"];
    Class subCls = objc_allocateClassPair(object_getClass(self), [newName UTF8String], 0);
    
    id newSetter = ^(__unsafe_unretained id self){
        NSLog(@"before setting:%@", keyPath);
//        notify observer
        
//        SEL selector = NSSelectorFromString(setterName);
//        IMP originSetter = class_getMethodImplementation(originClass, selector);
        
        NSLog(@"after setting:%@", keyPath);
    };
    
    IMP newSetterIMP = imp_implementationWithBlock(newSetter);
    IMP DefaultSetterForKVO = newSetterIMP;
    class_addMethod(subCls, NSSelectorFromString(setterName), (IMP)DefaultSetterForKVO, "v@:@");

    
    id newClassImpBlock = (id)^(__unsafe_unretained id self){
        return originClass;
    };
    
    IMP newclassIMP = imp_implementationWithBlock(newClassImpBlock);
    class_addMethod(subCls, NSSelectorFromString(@"class"), (IMP)newclassIMP, "v@:@");
    
    
    id newDellocImpBlock = (id)^(__unsafe_unretained id self){
        return originClass;
    };
    
    IMP newDeallocIMP = imp_implementationWithBlock(newDellocImpBlock);
    class_addMethod(subCls, NSSelectorFromString(@"dealloc"), (IMP)newDeallocIMP, "v@:@");
    
    
    objc_registerClassPair(subCls);
    /// 替换子类的isa
    object_setClass(self, subCls);
}



@end
