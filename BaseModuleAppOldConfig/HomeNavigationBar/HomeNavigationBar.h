//
//  HomeNavigationBar.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNavigationBar : UIView

@property (nonatomic, copy) NSArray *titles;


- (void)showAll;

- (void)showMini;


@end



NS_ASSUME_NONNULL_END
