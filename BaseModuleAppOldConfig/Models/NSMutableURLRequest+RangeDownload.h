//
//  NSURLRequest+RangeDownload.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableURLRequest (RangeDownload)

@property (nonatomic, assign) NSRange contentRange;

@end

NS_ASSUME_NONNULL_END
