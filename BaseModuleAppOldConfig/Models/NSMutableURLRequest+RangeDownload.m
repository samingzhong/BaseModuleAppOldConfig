//
//  NSURLRequest+RangeDownload.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/15.
//

#import "NSMutableURLRequest+RangeDownload.h"
#import <objc/runtime.h>

@implementation NSMutableURLRequest (RangeDownload)


- (void)setContentRange:(NSRange)contentRange {
    objc_setAssociatedObject(self, @selector(contentRange), NSStringFromRange(contentRange), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSString *range=[NSString stringWithFormat:@"bytes=%ld-%ld",contentRange.location, contentRange.location+contentRange.length];
//    - (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field;
    [self setValue:range forHTTPHeaderField:@"Range"];
}

- (NSRange)contentRange {
    NSString *contentRange = objc_getAssociatedObject(self, @selector(contentRange));
    NSRange result = NSRangeFromString(contentRange);
    return result;
}


@end
