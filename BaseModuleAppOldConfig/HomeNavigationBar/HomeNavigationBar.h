//
//  HomeNavigationBar.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/8.
//

#import <UIKit/UIKit.h>

@protocol BarShowDelegate <NSObject>

@optional
- (void)showAll;
- (void)showMini;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HomeNavigationBar : UIView

@property (nonatomic, weak) id <BarShowDelegate> delegate;

@property (nonatomic, copy) NSArray *titles;


- (void)showAll;

- (void)showMini;


@end



NS_ASSUME_NONNULL_END
