//
//  sqliteTest.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 5/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface sqliteTest : NSObject

- (BOOL)openDBWithFilePath:(NSString *)dbPath;

- (BOOL)createTable:(NSString *)tableName;

- (BOOL)insertObject:(id)object;

- (BOOL)modifyObject:(id)object;


@end

NS_ASSUME_NONNULL_END
