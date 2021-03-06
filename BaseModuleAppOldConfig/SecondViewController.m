//
//  SecondViewController.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//

#import "SecondViewController.h"
#import "objc-retainCount/NSObject+GACRetainCount.h"
#import <ReactiveObjC.h>
#import "objc-retainCount/NSObject+GACRetainCount.h"


#import <Masonry.h>

#import "WeakProxy/WeakProxy.h"

#import "UIView+randomBGColor.h"


@interface Touch2 : UIView

@end

@implementation Touch2

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *color = nil;
    color = self.tag == 1?@"蓝色":@"红色";
    NSLog(@"color:%@", color);
}


@end



@interface MyView : UIView

@end

@implementation MyView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseUI];
    }
    
    return self;
}


- (void)baseUI {
    self.frame = CGRectMake(0, 100, 100, 100);
    self.backgroundColor = UIColor.grayColor;
    
    Touch2 *blueView = [[Touch2 alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    blueView.backgroundColor = UIColor.blueColor;
    blueView.tag = 1;
    [self addSubview:blueView];
    
    Touch2 *redView = [[Touch2 alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    redView.backgroundColor = UIColor.redColor;
    redView.tag = 2;
    redView.alpha = 1;
    [self addSubview:redView];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    
    //    redView.userInteractionEnabled = NO;
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    NSLog(@"灰色");
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (CGRectContainsPoint(self.subviews.firstObject.frame, point)) {
//        return self.subviews.firstObject;
//    } else {
//        return self;
//    }
//}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return self.subviews.firstObject;
}




@end




void myFunctionWithBlock(dispatch_block_t block) {
    if (block) {
        block();
    }
}


@interface MyObject : NSObject

@property (nonatomic, strong) void(^block)(void);

- (void)methodWithTestBlock:(void(^)(void))block;

@end

@implementation MyObject

- (void)methodWithTestBlock:(void(^)(void))block {
    self.block = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block();
            //self.block = nil;// 打破循环引用
        }
    });
}

- (void)methodWithTestBlock2:(void(^)(void))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

- (void)methodWithTestBlock3:(void(^)(void))block {
    self.block = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block();
        }
    });
}

@end



@interface MyTimer : NSTimer

@end

@implementation MyTimer

- (void)dealloc {
    NSLog(@"dealloc....");
}

@end


#pragma mark -


@interface SecondViewController ()

@property (nonatomic, strong) MyObject *myObj;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    // Do any additional setup after loading the view.
    
    NSString *str = [NSString stringWithFormat:@"sunnyxx"];
    // str是一个autorelease对象，设置一个weak的引用来观察它
    reference = str;
    
    myFunctionWithBlock(^{
        NSLog(@"self :%@", self);
    });

    
    {
        dispatch_queue_t q = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_queue_t q = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_SERIAL);

        static int sum = 0;
        for (int i=0; i<1000; i++) {
            dispatch_async(q, ^{
                sum+=i;
                NSLog(@"job:%d in %@, sum:%d", i, [NSThread currentThread], sum);

            });
        
            
//            dispatch_apply(1000, q, ^(size_t iteration) {
//                sum+=i;
//                NSLog(@"job:%d in %@, sum:%d", i, [NSThread currentThread], sum);
//            });
        }
    }
    
    
    
    
//    [self blockTest];
//    [self threadSafeCase];
    
    MyView *view = [MyView new];
    //    [self.view addSubview:view];
    [self addSubViewScrollview];
    
    
    //    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.mas_equalTo(0);
    //    }];
    //
    //    [self threadSafeCase];
    
    [self localWeakVarCase];
    
    [self memeryLeakCase];
    
}

#pragma mark - test case
- (void)localWeakVarCase {
    id strong = NSObject.new;
    __weak id obj = nil;
    
    @autoreleasepool {
        obj = strong;
        NSLog(@"obj:%@", obj);
        NSInteger retainCount = [obj rq_retainCount];
        NSLog(@"hello");
    }
    NSInteger retainCount = [obj rq_retainCount];
    NSLog(@"hello");
}


- (void)threadSafeCase {
    //    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:100];
    NSMutableArray *arr = @[].mutableCopy;
    for (int i=0; i<100; i++) {
        dispatch_async(dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT), ^{
            [arr addObject:[NSObject new]];
        });
    }
}


- (void)blockTest {
    
    self.myObj = MyObject.new;
    [self.myObj methodWithTestBlock:^{
        NSLog(@"self:%@", self);
    }];
    
    //    [self.myObj methodWithTestBlock2:^{ //
    //        NSLog(@"self:%@", self);
    //    }];
    
    
    //    [self weakStrongDanceCase];
    
    //    [self RACWeakifyStrongifyCase];
    
    //    [self RACObserveCase];
}

- (void)RACObserveCase {
    @weakify(self);
    [RACObserve(self, myObj) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSLog(@"hello:%@", self.myObj);
    }];
}

-(void)weakStrongDanceCase {
    self.myObj = [MyObject new];
    __weak __typeof(self)weakSelf = self;
    [self.myObj methodWithTestBlock:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf; // 此处因为只是引用了weakSelf 所以不会增加self的引用计数。
        NSLog(@"hello:%@", strongSelf);
    }];
}

- (void)RACWeakifyStrongifyCase {
    self.myObj = [MyObject new];
    __weak __typeof(self)weakSelf = self;
    [self.myObj methodWithTestBlock:^{
        __strong __typeof(weakSelf) self = weakSelf; // block中允许我们重定义self
        NSLog(@"hello:%@", self);
    }];
    self.scrollView.scrollEnabled = YES;
    
    //__strong __typeof(weakSelf) self = weakSelf;//Redefinition of 'self'
}


#pragma mark - scrollview


static UIColor* randomColor(){
    NSArray *colors = @[UIColor.redColor, UIColor.greenColor, UIColor.orangeColor, UIColor.blueColor];
    return colors[arc4random()%4];
}


static CGRect scrollViewPosition(CGSize size) {
    CGFloat x = 10, width = size.width - 2*x, y = 100, height = size.height - 100-40;
    return CGRectMake(x, y, width, height);
}


- (void)addSubViewScrollview {
    
    CGFloat x = 10, width = UIScreen.mainScreen.bounds.size.width - 2*x, y = 100, height = UIScreen.mainScreen.bounds.size.height - 100-40;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewPosition(UIScreen.mainScreen.bounds.size)];
    [self.view addSubview:scrollView];
//    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    scrollView.backgroundColor = UIColor.purpleColor;
    //    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(10);
    //        make.right.mas_equalTo(-10);
    //        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
    //        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    //    }];
    
    
    self.scrollView = scrollView;
    
    UIView *view1 = UIView.new;
    [view1 setRandomBGColor];
    [self.scrollView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2);
        make.right.mas_equalTo(-2);
        make.width.equalTo(scrollView).offset(-4);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(1500);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds), 1500);        
    });
    self.scrollView.scrollEnabled = YES;
    
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    self.scrollView.frame = scrollViewPosition(size);
}


#pragma mark - 内存泄漏用法case
- (void)memeryLeakCase {
    //    self.timer = [MyTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"self...");
    //    }];
    
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    
    
    //    self.timer = [NSTimer timerWithTimeInterval:2 target:[WeakProxy proxyWithTarget:self] selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.timer invalidate];
    //    });
}

- (void)handleTimer {
    NSLog(@"self:%@", self);
}




#pragma mark -

- (void)dealloc {
    NSLog(@"dealloc ");
    [self.timer invalidate];
}


__weak id reference = nil;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", reference); // Console: sunnyxx
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", reference); // Console: (null)
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
