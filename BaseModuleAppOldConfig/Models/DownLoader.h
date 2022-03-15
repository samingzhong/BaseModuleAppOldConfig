//
//  DownLoader.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownLoader : NSObject



+ (void)downloadWithUrl:(NSString *)url block:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
