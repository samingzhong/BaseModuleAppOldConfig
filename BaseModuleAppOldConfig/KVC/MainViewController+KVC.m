//
//  MainViewController+KVC.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 4/28/22.
//

#import "MainViewController+KVC.h"

@implementation MainViewController (KVC)

- (void)kvcTest {
//    [self setValue:@(9) forKey:@"kvc_key"];
    kvc_key = @1;
}

@end
