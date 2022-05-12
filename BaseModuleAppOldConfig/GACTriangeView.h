//
//  GACTriangeView.h
//  GACTravel_Client
//
//  Created by 贾伟 on 2021/9/3.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TriangleViewStyle) {
    triangleViewIsoscelesTop,
    triangleViewIsoscelesLeft,
    triangleViewIsoscelesBottom,
    triangleViewIsoscelesRight,
};


NS_ASSUME_NONNULL_BEGIN

@interface GACTriangeView : UIView

/**
 @param color 填充颜色
 @param style 三角形样式
 @return TriangleView
 */
- (instancetype)initWithColor:(UIColor *)color style:(TriangleViewStyle)style;

/**
 @param color 填充颜色,
     style default:triangleViewIsoscelesTop
 @return TriangleView
 */
- (instancetype)initWithColor:(UIColor *)color;

- (void)triangleViewSetColor:(UIColor *)color style:(TriangleViewStyle)style;
- (void)triangleViewSetStyle:(TriangleViewStyle)style;
- (void)triangleViewSetColor:(UIColor *)color;


@end

NS_ASSUME_NONNULL_END
