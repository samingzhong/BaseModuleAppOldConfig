//
//  TestObject.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestObject : NSObject {
    NSObject *_object;
    NSObject *__object;
}

@property (nonatomic, strong) NSObject *object; // @property xxxx; 编译器会生成名为_object的实例变量，但是查询到已经有_object以及__object实例变量了，所以会生成___object的实例变量。并同时生成其setter/getter方法。

@property (nonatomic, strong) NSObject *dynamicObject;


@end

NS_ASSUME_NONNULL_END
