//
//  UIButton+Enlarge.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import "UIButton+Enlarge.h"
#import <objc/runtime.h>

static char topNameKey;
static char leftNameKey;
static char rightNameKey;
static char bottomNameKey;
 
@interface UIButton ()

@property (nonatomic, assign) UIPadding padding;

@end


@implementation UIButton (Enlarge)

- (void)enLargeWithPadding:(UIPadding)padding{
    self.padding = padding;
}


- (void)setPadding:(UIPadding)padding {
    objc_setAssociatedObject(self, &topNameKey, @(padding.top), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &leftNameKey, @(padding.left), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &bottomNameKey, @(padding.bottom), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &rightNameKey, @(padding.right), OBJC_ASSOCIATION_ASSIGN);
}

- (UIPadding)padding {
    NSNumber *top = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *left = objc_getAssociatedObject(self, &leftNameKey);
    NSNumber *bottom = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *right = objc_getAssociatedObject(self, &rightNameKey);
    return UIEdgeInsetsMake(top.floatValue, left.floatValue, bottom.floatValue, right.floatValue);
}


- (CGRect)gacEnlargedRect {
    if (self.padding.left || self.padding.top || self.padding.bottom || self.padding.right) {
        return CGRectMake(self.bounds.origin.x - self.padding.left,
                          self.bounds.origin.y - self.padding.top,
                          self.bounds.size.width + self.padding.left + self.padding.right,
                          self.bounds.size.height + self.padding.top + self.padding.bottom);
    } else {
        return self.bounds;
    }
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self gacEnlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"Call Stack: %@", [NSThread callStackSymbols]);
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}


@end
