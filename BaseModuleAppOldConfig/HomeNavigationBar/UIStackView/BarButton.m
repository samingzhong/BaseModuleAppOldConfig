//
//  BarButton.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/8.
//

#import "BarButton.h"
#import <Masonry.h>

@interface BarButton ()

@property (nonatomic, strong) UILabel *myTitleLabel;
@property (nonatomic, strong) UIImageView *bottomImageView;

@end


@implementation BarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel.hidden = YES;
        UILabel *label = UILabel.new;
        label.backgroundColor = UIColor.greenColor;
        [self addSubview:label];
        self.myTitleLabel = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_greaterThanOrEqualTo(10);
//            make.width.mas_lessThanOrEqualTo(100);

            make.left.mas_equalTo(8);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(-8);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(8);
        }];
        
        self.bottomImageView = UIImageView.new;
        self.bottomImageView.backgroundColor = UIColor.purpleColor;
        [self addSubview:self.bottomImageView];
        [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(arc4random()%30+20, arc4random()%30+20));
            make.top.mas_equalTo(label.mas_bottom).offset(10);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(self).offset(-8);
            make.left.mas_greaterThanOrEqualTo(8);
            make.right.mas_lessThanOrEqualTo(-8);
            
        }];
        [self.bottomImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.myTitleLabel.text = title;
}



@end
