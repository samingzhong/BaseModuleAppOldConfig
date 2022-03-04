//
//  UIButton+Enlarge.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIEdgeInsets UIPadding;

@interface UIButton (Enlarge)

- (void)enLargeWithPadding:(UIPadding)padding;

@end

NS_ASSUME_NONNULL_END
