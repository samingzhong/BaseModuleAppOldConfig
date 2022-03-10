//
//  MainViewController.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import "MainViewController.h"
#import "UIbutton+Enlarge.h"
#import "SecondViewController.h"
#import <Masonry.h>
#import <ReactiveObjC.h>
#import "HomeNavigationBar.h"
#import "Person.h"
#import <malloc/malloc.h>
#import <objc/runtime.h>

@interface UICollectionViewFlowLayoutA : UICollectionViewFlowLayout

@end

@implementation UICollectionViewFlowLayoutA





- (void)prepareLayout{
    [super prepareLayout];
}

@end



@interface MVView : UIView

@end

@implementation MVView


- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 50+arc4random()%100);
}

@end


@interface MVViewB : UIView

@end

@implementation MVViewB




- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 200);
}

@end


typedef NS_ENUM(NSInteger, MVState) {
    MVStateA = 0,
    MVStateB = 1,
    MVStateC = 2,
    MVStateD = 3,
};

@interface MainViewController () <BarShowDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) UIView *viewA;
@property (nonatomic, strong) UIView *viewB;

@property (nonatomic, assign) MVState state;

@property (nonatomic, strong) HomeNavigationBar *bar;


@property (nonatomic, assign) Person *person;

@property (nonatomic, copy) void (^block)(void);

@property (nonatomic, weak) NSObject *zombieObj;

@end

@implementation MainViewController

extern uintptr_t _objc_rootRetainCount(id obj);
extern id _objc_rootRetain(id obj);
extern void _objc_rootRelease(id obj);
extern id _objc_rootAutorelease(id obj);


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.grayColor;
    
    HomeNavigationBar *bar = HomeNavigationBar.new;
    [self.view addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
    }];
    self.bar = bar;
    [self.button enLargeWithPadding:UIEdgeInsetsMake(30, 30, 50, 30)];
    
    [self.button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
//    self.button.userInteractionEnabled = NO;
    
    
    [self buildMainView];
    
    
    [[RACObserve(self, state) skip:1] subscribeNext:^(id  _Nullable x) {
        MVState state = [x integerValue];
        [self buildViewBWithState:state];
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = MVStateA;
//        [self buildViewBWithState:MVStateA];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = MVStateB;
//        [self buildViewBWithState:MVStateB];
    });
    
    
//    [self zombieTest];
    [self zombieTest];
    
    [self copyTest];
    [self objectMemoryLayoutAlignTest];
    
}


-(void)copyTest {
    Person *p  = [XXPerson new];
//    p.name = @"hello";
//    self.person = p;
//    self.block = ^{
//        NSLog(@"sdf:%@", self.person.name );
//    };
    
    [p mainMethod];
    
    NSLog(@"ds");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static BOOL r = NO;
    r ? [self.bar showAll] : [self.bar showMini];
    r = !r;
    
//    NSLog(@"self.name:%@", self.person.name);
    NSLog(@"sdfaf");
    
}


- (void)zombieTest {
    NSObject *obj = NSObject.new;
    self.zombieObj = obj;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        id obj = self.zombieObj;
        [obj description];
    });
}


- (void)objectMemoryLayoutAlignTest {
    Person *obj = [[Person alloc] init];
    
    for (int i=0; i<1000; i++) {
        _objc_rootRetain(obj);
        _objc_rootRetainCount(obj);
    }
    
//    obj.name = [NSString stringWithFormat:@"A"];
    obj.age=1;
    obj.man=YES;
//    obj.f = 3.f;
//    obj.f1 = 4.f;
//    obj.man1=YES;

//    obj.d = 5.f;
    
    NSLog(@"1sizeof(obj):%@\nsizeof(NSInterger:%@),sizeof(BOOL:%@)", @(malloc_size((__bridge const void *)(obj))), @(sizeof(typeof(NSInteger))), @(sizeof(typeof(BOOL))));
    int size = class_getInstanceSize([Person class]);
    NSLog(@"sizeof(obj:%d", size);
    NSLog(@"asf");
}


- (void)buildMainView {
    [self.button removeFromSuperview];
    
    
    
    NSMutableArray <MVView *>*subViews = NSMutableArray.new;
    NSArray *colors = @[UIColor.redColor, UIColor.greenColor, UIColor.orangeColor, UIColor.blueColor];
    for (int i=0; i<4; i++) {
        MVView *view = MVView.new;
        view.backgroundColor = colors[arc4random()%4];
        [self.view addSubview:view];
        [subViews addObject:view];
        
        if (i == 1) {
            self.viewB = view;
        }
        
        if (i == 0) {
            self.viewA = view;
        }
    }
    
    [subViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (idx==0) {
                if (@available(iOS 11.0, *)) {
                    make.top.mas_equalTo(self.bar.mas_bottom).offset(8);
                    make.height.mas_equalTo(200);

                } else {
                    // Fallback on earlier versions
                    make.top.mas_equalTo(self.bar.mas_bottom).offset(8);
                }
            } else {
                make.top.mas_equalTo((subViews[idx-1]).mas_bottom).offset(8);
            }
            make.left.right.mas_equalTo(0);
//            make.height.mas_equalTo(50+arc4random()%100);
        }];
    }];
    
    [self buildViewA];
}


- (void)buildViewA {
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    layout.itemSize = CGSizeMake(50, 50);
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    cv.backgroundColor = UIColor.greenColor;
    [self.viewA addSubview:cv];
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    cv.dataSource = self;
    cv.delegate = self;
    [cv registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width/2-10, 50);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 2;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.grayColor;
    
    return cell;
}


- (void)buildViewBWithState:(MVState)state {
    [self.viewB.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    UIView *view = [self viewWithState:state];
    [self.viewB addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (UIView *)viewWithState:(MVState)state {
    UIView *view = nil;
    
    switch (state) {
        case MVStateA:
            view = [self stateAView];
            break;
        case MVStateB:
            view = [self stateBView];
            break;
            
        default:
            view = [self stateAView];
            
            break;
    }
    
    return view;
}

- (UIView *)stateAView {
    UIView *view = nil;
    
    {
        view = MVViewB.new;
        view.backgroundColor = UIColor.orangeColor;
        UIView *leftView = UIView.new;
        leftView.backgroundColor = UIColor.grayColor;
        [view addSubview:leftView];
        UIView *rightView = UIView.new;
        rightView.backgroundColor = UIColor.redColor;
        [view addSubview:rightView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(2);
            make.top.mas_offset(2);
            make.bottom.mas_offset(-2);
            make.right.multipliedBy(0.3);
        }];
        
    }
    
    return view;
}

- (UIView *)stateBView {
    UIView *view = nil;
    
    {
        view = MVViewB.new;
        view.backgroundColor = UIColor.orangeColor;
        UIView *leftView = UIView.new;
        leftView.backgroundColor = UIColor.grayColor;
        [view addSubview:leftView];
        UIView *rightView = UIView.new;
        rightView.backgroundColor = UIColor.redColor;
        [view addSubview:rightView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.center.mas_equalTo(0);
            make.bottom.mas_equalTo(-2);
        }];
        
    }
    
    return view;
}


- (void)test {
    SecondViewController *vc = SecondViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}


//- (IBAction)btnDidClick:(id)sender {
//    
//}


@end
