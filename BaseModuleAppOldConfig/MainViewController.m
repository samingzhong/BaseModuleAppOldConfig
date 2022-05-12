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

#import "Person+A.h"

#import "DownLoader.h"
#import "HomeViewController.h"
#import "MsgForwardTestClass.h"
#import <objc/runtime.h>
#import "NSObject+Observe.h"
#import "NSObject+size.h"
#import "MainViewController+KVC.h"
#import "GACTriangeView.h"

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

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MVViewB


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:t];
        self.timer = [NSTimer timerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"hello .....");
        }];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];
    }
    return self;
}


- (void)handleTap:(UITapGestureRecognizer *)t {
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [super pointInside:point withEvent:event];
}


- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 200);
}



//- (void)displayLayer:(CALayer *)layer {
////    [super displayLayer:layer];
//
////    UIImage *uiimage = [UIImage imageNamed:@"test"];
////    layer.contents = (__bridge id _Nullable)(uiimage.CGImage);
//}


- (void)drawRect:(CGRect)rect {
    return;
    
    //1. 注：如果没有获取context时，是什么都不做的（背景无变化）
    [super drawRect:rect];
    
    // 获取上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGSize size = rect.size;
    CGFloat offset = 20;
    
    // 画脑袋
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);
    CGContextSetLineWidth(context, 1.0);
    CGContextAddArc(context, size.width / 2, offset + 30, 30, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 画眼睛和嘴巴
    CGContextMoveToPoint(context, size.width / 2 - 23, 40);
    CGContextAddArcToPoint(context, size.width / 2 - 15, 26, size.width / 2 - 7, 40, 10);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, size.width / 2 + 7, 40);
    CGContextAddArcToPoint(context, size.width / 2 + 15, 26, size.width / 2 + 23, 40, 10);
    CGContextStrokePath(context);//绘画路径
    
    CGContextMoveToPoint(context, size.width / 2 - 8, 65);
    CGContextAddArcToPoint(context, size.width / 2, 80, size.width / 2 + 8, 65, 10);
    CGContextStrokePath(context);//绘画路径
    
    // 画鼻子
    CGPoint nosePoints[3];
    nosePoints[0] = CGPointMake(size.width / 2, 48);
    nosePoints[1] = CGPointMake(size.width / 2 - 3, 58);
    nosePoints[2] = CGPointMake(size.width / 2 + 3, 58);
    CGContextAddLines(context, nosePoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 画脖子
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(size.width / 2 - 5, 80, 10, 10));
    CGContextFillRect(context,CGRectMake(size.width / 2 - 5, 80, 10, 10));
    
//    // 画衣裳
//    CGPoint clothesPoints[4];
//    clothesPoints[0] = CGPointMake(size.width / 2 - 30, 90);
//    clothesPoints[1] = CGPointMake(size.width / 2 + 30, 90);
//    clothesPoints[2] = CGPointMake(size.width / 2 + 100, 200);
//    clothesPoints[3] = CGPointMake(size.width / 2 - 100, 200);
//    CGContextAddLines(context, clothesPoints, 4);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 衣裳颜色渐变
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, size.width / 2 - 30, 90);
    CGPathAddLineToPoint(path, NULL, size.width / 2 + 30, 90);
    CGPathAddLineToPoint(path, NULL, size.width / 2 + 100, 200);
    CGPathAddLineToPoint(path, NULL, size.width / 2 - 100, 200);
    CGPathCloseSubpath(path);
    [self drawLinearGradient:context path:path startColor:[UIColor cyanColor].CGColor endColor:[UIColor yellowColor].CGColor];
    CGPathRelease(path);
    
    // 画胳膊
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:1 blue:1 alpha:1].CGColor);
    CGContextMoveToPoint(context, size.width / 2 - 28, 90);
    CGContextAddArc(context, size.width / 2 - 28, 90, 80,  - M_PI, -1.05 * M_PI, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    CGContextMoveToPoint(context, size.width / 2 + 28, 90);
    CGContextAddArc(context, size.width / 2 + 28, 90, 80,  0, 0.05 * M_PI, 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    // 画左手
    CGPoint aPoints[2];
    aPoints[0] =CGPointMake(size.width / 2 - 30 - 81, 90);
    aPoints[1] =CGPointMake(size.width / 2 - 30 - 86, 90);
    CGContextAddLines(context, aPoints, 2);
    aPoints[0] =CGPointMake(size.width / 2 - 30 - 80, 93);
    aPoints[1] =CGPointMake(size.width / 2 - 30 - 85, 93);
    CGContextAddLines(context, aPoints, 2);
    CGContextDrawPath(context, kCGPathStroke);
    // 画右手
    aPoints[0] =CGPointMake(size.width / 2 + 30 + 81, 90);
    aPoints[1] =CGPointMake(size.width / 2 + 30 + 86, 90);
    CGContextAddLines(context, aPoints, 2);
    aPoints[0] =CGPointMake(size.width / 2 + 30 + 80, 93);
    aPoints[1] =CGPointMake(size.width / 2 + 30 + 85, 93);
    CGContextAddLines(context, aPoints, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
//    // 画虚线
//    aPoints[0] =CGPointMake(size.width / 2 + 30 + 81, 90);
//    aPoints[1] =CGPointMake(size.width / 2 + 30 + 86, 90);
//    CGContextAddLines(context, aPoints, 2);
//    aPoints[0] =CGPointMake(size.width / 2 + 30 + 80, 93);
//    aPoints[1] =CGPointMake(size.width / 2 + 30 + 85, 93);
//    CGContextAddLines(context, aPoints, 2);
//    CGFloat arr[] = {1, 1};
//    CGContextSetLineDash(context, 0, arr, 2);
//    CGContextDrawPath(context, kCGPathStroke);
    
    // 画双脚
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(size.width / 2 - 30, 210, 20, 15));
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(size.width / 2 + 10, 210, 20, 15));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 绘制图片
    UIImage *image = [UIImage imageNamed:@"img_watch"];
    [image drawInRect:CGRectMake(60, 270, 100, 120)];
    //[image drawAtPoint:CGPointMake(100, 340)];
    //CGContextDrawImage(context, CGRectMake(100, 340, 20, 20), image.CGImage);
    
    // 绘制文字
    UIFont *font = [UIFont boldSystemFontOfSize:20.0];
    NSDictionary *attriDict = @{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor redColor]};
    [@"绘制文字" drawInRect:CGRectMake(180, 270, 150, 30) withAttributes:attriDict];
}

- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
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


@property (nonatomic, strong) Person *_person;

@property (nonatomic, copy) void (^block)(void);

@property (nonatomic, assign) NSObject *zombieObj;


@property (nonatomic, strong) NSThread *myWorkThread;

#pragma mark
@property (nonatomic, strong) dispatch_queue_t myWorkQueue;


#pragma mark block
@property (nonatomic, assign) void (^myBlock)(void);
@property (nonatomic, assign) int j;

@property (nonatomic, strong) NSThread *thread;

@end

@implementation MainViewController

@synthesize bar = bar;

extern uintptr_t _objc_rootRetainCount(id obj);
extern id _objc_rootRetain(id obj);
extern void _objc_rootRelease(id obj);
extern id _objc_rootAutorelease(id obj);

static int s_i = 1;


void exampleA() {
  char a = 'A';
  ^{
//    printf("%cn", a);
  }();
}


- (void)sayHello {
    NSLog(@"hello ");
//    usleep(1000000);
    [self autoreleasepoolCase];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    exampleA();
    
#pragma mark msgForwardingTest
    void (^msgForwardingTest)(void) = ^() {
        MsgForwardTestClass *obj = [MsgForwardTestClass new];
        [obj methodWithoutImpletation];
//
//        [obj performSelector:@selector(hello) withObject:@"hello"];
        
//        _objc_msgForward(obj, @selector(hello));
    };
    msgForwardingTest();
    
    
    [self manualKVOCase];
    
    
    [self addRunLoopObserver];
    
    
    
    void (^workThreadRunloopBlock)(void) = ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"work thread:%@", [NSThread currentThread]);
            [NSThread currentThread].name = @"autureleasepool.thread";
            self.thread = NSThread.currentThread;
            [self addRunLoopObserver];
            
            //        [self performSelector:@selector(sayHello) withObject:nil afterDelay:10];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self performSelector:@selector(sayHello) onThread:self.thread withObject:nil waitUntilDone:NO];
            });
        });
    };
//    workThreadRunloopBlock();
    
    
    
    
//    [self controlGCDMaxThreadInQueue];
//    [self gcdThreadExpose];
    
    #pragma mark blockTest
    void (^blockTest)(void) = ^() {
        int i_i;
        
        void (^block0)(void) = ^{
            NSLog(@"hello:%d", i_i);
        };
        _myBlock = ^{
            NSLog(@"hello:%d", i_i);
        };
        //    Block_copy(self.myBlock);
        
        // arc 下 block会被自动拷贝到堆区。
        int i = 0;
        void (^block)(void) = ^{
            NSLog(@"i:%d", i);
        };
        NSLog(@"block:%@", block);
        
        // block位于堆区
        id tmp = self;
        void (^block1)(void) = ^{
            NSLog(@"self:%@", tmp);
        };
        
//        block1 = Block_copy(block1);
        NSLog(@"block:%@", block1);
        
        
        // block位于data段，全局
        void (^block2)(void) = ^{
            //        s_i = 2;
        };
        NSLog(@"block:%@", block2);
        
        
        int j = 0;
        self.j = j;
    };
    blockTest();
    
    
    
    void (^weakUsageBlock)(void) = ^ {
        NSObject *s_o = NSObject.new;
        id __weak w_o = s_o;
        NSLog(@"w_o retainCount:%z", w_o  );
    };
    weakUsageBlock();
    
    
    
    self.myWorkQueue = dispatch_queue_create("my.work.queue", DISPATCH_QUEUE_CONCURRENT);
    
//    [DownLoader downloadWithUrl:@"https://vd3.bdstatic.com/mda-ncdf5p17j4ztsdaw/sc/cae_h264_delogo/1647263253838817803/mda-ncdf5p17j4ztsdaw.mp4?v_from_s=hkapp-haokan-hnb&auth_key=1647327438-0-0-5e27273cca0976df226d33c8f764990c&bcevod_channel=searchbox_feed&cd=0&pd=1&pt=3&logid=1637974093&vid=15318298559196487317&abtest=100815_2-17451_1&klogid=1637974093" block:nil];
//    [DownLoader downloadWithUrl:@"http://10.10.16.52:8000/huoying.mp4" block:nil];
    
     
    
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
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = MVStateA;
//        [self buildViewBWithState:MVStateA];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = MVStateB;
//        [self buildViewBWithState:MVStateB];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //willchange/didchange必须成对调用，有些场景不是通过setter方法设置成员变量的值，
        // 调用willchange会做一个记录
        [self willChangeValueForKey:@"state"];
        NSLog(@"hello world");
        // 调用didchange后会查找下之前有没有willchange的记录，有的话才会触发observer的notify
        [self didChangeValueForKey:@"state"];
    });
    
    
//    [self zombieTest];
//    [self zombieTest];
    
//    [self gcdThreadCooTest];
//    
//    [self copyTest];
    [self objectMemoryLayoutAlignTest];
//    
//    [self addPropertyToCategoryTest];
    
//    [self autoreleasepoolCase];
    [self keepWorkThreadAliveAndDoMore];
    
//    [self autoreleaseCase];
}


- (void)manualKVOCase {

}


- (void)setState:(MVState)state {
    _state = state;
    [self willChangeValueForKey:@"state"];
    NSLog(@"hello world");
    // 调用didchange后会查找下之前有没有willchange的记录，有的话才会触发observer的notify
    [self didChangeValueForKey:@"state"];
}


-(void)copyTest {
    XXPerson *p  = [XXPerson new];
    [p baseCommonMethodA];
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
    
    static int i = 0;
    
    i++;
    if (i>=5) {
        [self stopMyWorkRunloop];
    } else {
        [self startAutoreleaeObjJobOnWorkThread];
    }
    
}


- (void)zombieTest {
    NSObject *obj = NSObject.new;
    self.zombieObj = obj;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        id obj = self.zombieObj;
        [obj description];
    });
}

- (void)gcdThreadCooTest {
    dispatch_queue_t queue = dispatch_queue_create("cc.imguiqing", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"task 1 on %@",[NSThread currentThread]);
        sleep(arc4random()%5);
        NSLog(@"task 1 on %@ done!",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task 2 on %@",[NSThread currentThread]);
        sleep(arc4random()%5);
        NSLog(@"task 2 on %@ done!",[NSThread currentThread]);

    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier ==========");
    });
    dispatch_async(queue, ^{
        NSLog(@"task 3 on %@",[NSThread currentThread]);
    });
}


- (void)objSizeInfo {
    UIView *view = UIView.new;
    NSLog(@"\nmalloc_size(obj):%@\nsizeof(NSInterger:%@),sizeof(BOOL:%@)", @(malloc_size((__bridge const void *)(view))), @(sizeof(typeof(NSInteger))), @(sizeof(typeof(BOOL))));
    int size = class_getInstanceSize([Person class]);
    NSLog(@"sizeof(obj:%d", size);
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
//    [self objSizeInfo];
    [self printSizeInfos];
    NSLog(@"asf");
}



- (void)autoreleasepoolCase {
    
    for (int i=0; i<9999; i++) {
//        @autoreleasepool {
            NSString *str = [NSString stringWithFormat:@"hello world：%@", @(random())];
            NSLog(@"str:%@", str);            
//        }
    }
}


- (void)keepWorkThreadAliveAndDoMore {
    
    void (^entrance)(void) = ^(void) {
        [NSThread currentThread].name = @"com.mywork.thread";
        self.myWorkThread = [NSThread currentThread];
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    };
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        entrance();
//    });
    
    self.myWorkThread = [[NSThread alloc] initWithBlock:^{
        entrance();
    }];
    [self.myWorkThread start];
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self performSelector:@selector(startJob) onThread:self.myWorkThread withObject:nil waitUntilDone:NO];
//    });
    
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self performSelector:@selector(stopMyWorkRunloop) onThread:self.myWorkThread withObject:nil waitUntilDone:NO];
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self performSelector:@selector(startJob) onThread:self.myWorkThread withObject:nil waitUntilDone:NO];
//    });
}

- (void)startAutoreleaeObjJobOnWorkThread {
    [self performSelector:@selector(startJob) onThread:self.myWorkThread withObject:nil waitUntilDone:NO];
}

- (void)endWorkThread {
    [self performSelector:@selector(startJob) onThread:self.myWorkThread withObject:nil waitUntilDone:NO];
}



- (void)stopMyWorkRunloop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    [NSThread exit];
}


- (void)stopRunLoop {
    
}

- (void)startJob {
    NSLog(@"start job at thread:%@", [NSThread currentThread]);
    
    [self autoreleasepoolCase];
}


#pragma mark - Message Forwarding (消息转发）
- (void)msgForwardingCase {
    
}


#pragma mark - runloop observer
static CFAbsoluteTime sTime;
static double atime;
static void YYRunLoopAutoreleasePoolObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry: {
            YYAutoreleasePoolPush();// 进入循环，先创建池子。
        } break;
            
        case kCFRunLoopAfterWaiting: {
            NSLog(@"runloop醒来了");
            sTime = CFAbsoluteTimeGetCurrent();
            atime =  CFAbsoluteTimeGetCurrent();
        } break;
        case kCFRunLoopBeforeWaiting: {//进入休眠前，释放池子里的对象、并且重新创建一个池子。
            CFTimeInterval intervalTime = (CFAbsoluteTimeGetCurrent()-sTime);
            NSLog(@"runloop即将休眠:%f, 动态帧率:%f", intervalTime, 1/intervalTime);

            YYAutoreleasePoolPop();
            YYAutoreleasePoolPush();
        } break;
        case kCFRunLoopExit: {
            YYAutoreleasePoolPop(); // 退出循环，释放池子。
        } break;
        default: break;
    }
}

static void YYAutoreleasePoolPush() {
    NSLog(@"autoreleasepool push in thread:%@", [NSThread currentThread]);
}

static void YYAutoreleasePoolPop() {
    NSLog(@"autoreleasepool pop in thread:%@", [NSThread currentThread]);
}

- (void)addRunLoopObserver {
    
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();

//    CFRunLoopObserverRef pushObserver;
//    pushObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopEntry,
//                                           true,         // repeat
//                                           -0x7FFFFFFF,  // before other observers
//                                           YYRunLoopAutoreleasePoolObserverCallBack, NULL);
//    CFRunLoopAddObserver(runloop, pushObserver, kCFRunLoopCommonModes);
//    CFRelease(pushObserver);
    
    
    
    CFRunLoopObserverRef popObserver;
    popObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(),
                                          kCFRunLoopAllActivities,
                                          true,        // repeat
                                          0x7FFFFFFF,  // after other observers
                                          YYRunLoopAutoreleasePoolObserverCallBack, NULL);
    CFRunLoopAddObserver(runloop, popObserver, kCFRunLoopCommonModes);
    CFRelease(popObserver);
    
    if ([[NSThread currentThread] isEqual:[NSThread mainThread]]) {
        return;
    }
    
    [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
    
}


#pragma mark - 类别+属性
- (void)addPropertyToCategoryTest {
    Person *p = Person.new;
    p.categoryProperty = self;
}


- (void)gcdThreadExpose {
    
    __block int sum = 0;
    void (^costTimeJob)(void) = ^ {
        for (int i=0; i<1000000; i++) {
            sum+=i;
        }
        sleep(arc4random()%10);
        NSLog(@"sum:%d", sum);
    };
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(2);
    
    for (int i=0; i<1000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            NSLog(@"job:%@ start in thread:%@", @(i), [NSThread currentThread]);
            costTimeJob();
            NSLog(@"job:%@ done in thread:%@", @(i), [NSThread currentThread]);
            dispatch_semaphore_signal(sem);
        });
    }
}



- (void)controlGCDMaxThreadInQueue {

    dispatch_semaphore_t sem = dispatch_semaphore_create(2);
    dispatch_queue_t q = dispatch_queue_create("my.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(q, ^{
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        //job
        NSLog(@"job ....");
        sleep(10);
        NSLog(@"job done....");
    });
    
    dispatch_async(q, ^{
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        //job
        NSLog(@"job ....");
        sleep(15);
        NSLog(@"job done....");
    });
    
    dispatch_async(q, ^{
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        //job
        NSLog(@"job ....");
        sleep(20);
        NSLog(@"job done....");
    });
    
    dispatch_async(q, ^{
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        //job
        NSLog(@"job ....");
        sleep(25);
        NSLog(@"job done....");
    });
    
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
        UIView *leftView = [[GACTriangeView alloc] initWithColor:UIColor.whiteColor style:triangleViewIsoscelesBottom];
//        leftView.backgroundColor = UIColor.grayColor;
        [view addSubview:leftView];
        UIView *rightView = UIView.new;
        rightView.backgroundColor = UIColor.redColor;
        [view addSubview:rightView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-2);
        }];
        
//
        
        
        
        UIButton *btn = UIButton.new;
        [btn setTitle:@"push to b" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(0);
        }];
        
        
        void (^rotate)(UIView *view) = ^(UIView *view) {
            NSTimer *timer = [NSTimer timerWithTimeInterval:1.0/30 repeats:YES block:^(NSTimer * _Nonnull timer) {
                static CGFloat angle = 0;
                CGAffineTransform transform = CGAffineTransformIdentity;
                transform = CGAffineTransformTranslate(transform, 0, 0);
                angle+=M_PI/30;
                view.transform = CGAffineTransformRotate(transform, angle);
            }];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        };
        rotate(btn);
        
    }
    
    return view;
}

//+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
//}



- (void)test {
    
    [self kvcTest];
    
    Class class = object_getClass(self.class);
//
//    [self performSelector:@selector(sayHello) onThread:self.thread withObject:nil waitUntilDone:NO];
//
//    HomeViewController *homeVC = HomeViewController.new;
//    [self.navigationController pushViewController:homeVC animated:YES];
//    return;;
    
//    @autoreleasepool {
//        __autoreleasing Person *p = [[Person alloc] init];
//    }
    
//    id p = [[[Person alloc] init] autorelease];
    self._person = [[Person alloc] init];
    self._person.block = ^{
        NSLog(@"p:%@", self);
    };
//    NSLog(@"p retainCount:%d", [p retainCount]);
    
//    [self performSelector:@selector(autoreleaseObjInworkThreadCase) onThread:self.myWorkThread withObject:nil waitUntilDone:NO];
//    return;
   
//    Person *p = [Person new];
    SecondViewController *vc = SecondViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
    
//    Class  _Nullable class = object_getClass(self);
//    [self printClassAllMethod:class];
}

- (void)autoreleaseCase {
//    @autoreleasepool {
//        Person *p = [Person autoreleasePerson];
//    }
//    Person *p = [Person autoreleasePerson];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        Person *p = [Person autoreleasePerson];
//        NSLog(@"p:%@", p);
//    });
    
    self.myWorkThread = [[NSThread alloc] initWithBlock:^{
        NSThread.currentThread.name = @"hello.thread";
        NSRunLoop *rl = [NSRunLoop currentRunLoop];
        [rl addPort:NSPort.new forMode:NSRunLoopCommonModes];
        [rl runUntilDate:[NSDate distantFuture]];
        
        }];
    [self.myWorkThread start];
}

- (void)autoreleaseObjInworkThreadCase {
    Person *p = [Person autoreleasePerson];
    NSLog(@"p:%@", p);
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.nextResponder touchesBegan:touches withEvent:event];
//}


//- (IBAction)btnDidClick:(id)sender {
//    
//}



@end


@interface MainViewController (Test)

@end

@implementation MainViewController (Test)

//- (void)viewDidLoad {
//    NSLog(@"hello ");
//}

@end


@implementation MainViewController (GCDTestCase)

- (void)dispatch_group {
    
}

- (void)dispatch_semphere {
    
}

- (void)dispatch_barriar {
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.myBlock();
//    [self performSelector:@selector(sayHello) onThread:self.thread withObject:nil waitUntilDone:NO];
    [self test];

}
@end



@implementation MainViewController (featureA)

- (NSObject *)fa_obj {
    return self;
}

- (void)setFa_obj:(NSObject *)fa_obj {
    
}

@end
