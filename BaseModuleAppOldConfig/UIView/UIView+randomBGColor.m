//
//  UIView+randomBGColor.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxm on 2022/4/9.
//

#import "UIView+randomBGColor.h"

@implementation UIView (randomBGColor)

static UIColor* randomColor(){
    NSArray *colors = @[UIColor.redColor, UIColor.greenColor, UIColor.orangeColor, UIColor.blueColor];
    return colors[arc4random()%4];
}



- (void)setRandomBGColor {
    self.backgroundColor = randomColor();
}

@end
