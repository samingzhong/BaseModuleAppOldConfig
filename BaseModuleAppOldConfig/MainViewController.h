//
//  MainViewController.h
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
    id kvc_key;
}


@end


@interface MainViewController (featureA)
@property (nonatomic, strong) NSObject *fa_obj;
@end


@interface MainViewController (featureB)
@property (nonatomic, strong) NSObject *fb_obj;

@end

@interface MVViewB : UIView

@end

