//
//  HomeNavigationBar.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/8.
//

#import "HomeNavigationBar.h"
#import <Masonry.h>


@interface HomeNavigationBar ()

@property (nonatomic, strong) UIStackView *mainStackView;

@property (nonatomic, strong) UIScrollView *scrollView;
@end


@implementation HomeNavigationBar

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
        _titles =@[@"栏目123123",@"栏目12",@"栏目123",@"栏目1",@"栏目",@"栏目",@"栏目",@"栏目",@"栏目"];
        self.backgroundColor = UIColor.blueColor;
        UIView *topView = UIView.new;
        topView.backgroundColor = UIColor.redColor;
        [self addSubview:topView];
        _mainStackView = UIStackView.new;
        _mainStackView.axis = UILayoutConstraintAxisHorizontal;
        _mainStackView.backgroundColor = UIColor.orangeColor;
        [self addSubview:_mainStackView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(80);
        }];
        
//        [_mainStackView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
//            make.top.mas_equalTo(topView.mas_bottom).offset(8);
//            make.height.mas_equalTo(40);
//            make.bottom.mas_offset(-2);
//        }];
        
        _mainStackView.spacing = 10;
        _mainStackView.alignment = UIStackViewAlignmentCenter;
        _mainStackView.distribution = UIStackViewDistributionFillProportionally;
        
        _scrollView = UIScrollView.new;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(topView.mas_bottom).offset(8);
            make.height.mas_equalTo(40);
            make.bottom.mas_offset(-2);
        }];
        [_scrollView addSubview:_mainStackView];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        
        [_mainStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_offset(0);
            make.height.equalTo(_scrollView);
//            make.width.mas_equalTo(1000);
        }];
        [self loadTitles];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showMini];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showAll];
    });
    
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(-1, 100);
}

- (void)loadTitles {
    NSMutableArray *btns = @[].mutableCopy;
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = UIColor.grayColor;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
        [btns addObject:btn];
        [self.mainStackView addArrangedSubview:btn];
    }];
    
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)showAll {
    [UIView animateWithDuration:0.25 animations:^{
        self.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }];
}

- (void)showMini {
    [UIView animateWithDuration:0.25 animations:^{
        self.bounds = CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height);
    }];
}


@end
