//
//  DownLoader.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/15.
//

#import "DownLoader.h"
#import "NSMutableURLRequest+RangeDownload.h"
#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>



@interface DownLoaderOperation : NSOperation <NSURLSessionDataDelegate>

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSRange range;


@end

@implementation DownLoaderOperation

@synthesize finished = _finish;
@synthesize executing = _executing;

- (void)done {
    self.finished = YES;
    self.executing = NO;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"finished"];
    _finish = finished;
    [self didChangeValueForKey:@"finished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}


- (NSString *)anrDirectory {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *directory = [cachePath stringByAppendingPathComponent:@"tmpfile"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:directory]) {
        [manager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    directory = [directory stringByAppendingString:@"/test.mp4"];
    if (![manager fileExistsAtPath:directory]) {
        [manager createFileAtPath:directory contents:nil attributes:nil];
    }
    return directory;
}

- (void)start {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    
    NSRange range = self.range;
    request.contentRange = range;
    request.HTTPMethod = @"GET";
//    sleep(arc4random()%20);
    NSURLSessionDataTask *task = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:NSOperationQueue.new] dataTaskWithRequest:request];
    
    
    [task resume];
    
//    UIImage *image = [UIImage imageWithData:data];
//    NSLog(@"image:%@",image);
//    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:[self anrDirectory]];
//    [fh seekToFileOffset:request.contentRange.location];
//    [fh writeData:data];
//    NSLog(@"hello");
//    [self done];
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"didReceiveData");
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"didReceiveResponse completionHandler");
    
}

@end




@interface DownLoader ()

@property (nonatomic, assign) NSInteger totalSize;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSOperationQueue *downloadQueue;

@property (nonatomic, strong) NSOperation *firstOperation;

@end






@implementation DownLoader


+ (DownLoader *)sharedInstance {
    static dispatch_once_t onceToken;
    static DownLoader *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
        instance.downloadQueue = [NSOperationQueue new];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}






+ (void)downloadWithUrl:(NSString *)url block:(void(^)(void))block {
    [self sharedInstance].url = url;
    
    [self fetchTotolSizeWithBlock:^(NSArray *array) {
        for (NSString *str in array) {
            NSRange range = NSRangeFromString(str);
            DownLoaderOperation *operation  = DownLoaderOperation.new;
            operation.url = url;
            operation.range = range;
            if (range.location == 0) {
                [self sharedInstance].firstOperation = operation;
            }
            [[self sharedInstance].downloadQueue addOperation:operation];
        }
        
    }];
    
    
    
    
    
    
    
//
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//
//    NSRange range = NSMakeRange(10, 1024*10);
//    request.contentRange = range;
//    request.HTTPMethod = @"GET";
//    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        UIImage *image = [UIImage imageWithData:data];
//        NSLog(@"image:%@",image);
//        NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:[self anrDirectory]];
//        [fh seekToFileOffset:request.contentRange.location];
//        [fh writeData:data];
//        NSLog(@"hello");
//    }];
//    [task resume];
}

+ (NSString *)anrDirectory {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *directory = [cachePath stringByAppendingPathComponent:@"tmpfile"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:directory]) {
        [manager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    directory = [directory stringByAppendingString:@"/test.file"];
    if (![manager fileExistsAtPath:directory]) {
        [manager createFileAtPath:directory contents:nil attributes:nil];
    }
    return directory;
}


+ (NSString *)cachePath {
    return nil;
}


+ (void)fetchTotolSizeWithBlock:(void(^)(NSArray *))block {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self sharedInstance].url]];
    
    request.HTTPMethod = @"HEAD";
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"reponse:%@", response);
        if (!error) {
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            NSInteger totolSize = ((NSNumber *)httpRes.allHeaderFields[@"Content-Length"]).integerValue;
            [self sharedInstance].totalSize = totolSize;
            NSInteger counts = [self unitSizeWithTotolSize:totolSize];
            long unitSize = totolSize/counts;
            NSArray *array = [self splitTotalSize:totolSize withUnit:unitSize];
            if (block) {
                block(array);
            }
            NSLog(@"www");
        }
    }];
    [task resume];
}
+ (NSInteger)unitSizeWithTotolSize:(NSInteger)totalSize {
    if (totalSize<=10*1024) { // <= 10kb
        return 1;
    } else if (totalSize <= 100*1024) {// 100kb
        return 2;
    } else if (totalSize<=1024*1024) {// <=1Mb
        return 5;
    } else {// <=10Mb
        return 10;
    }
}

+ (NSArray <NSString *> *)splitTotalSize:(NSInteger)totalSize withUnit:(NSInteger)unitSize {
//    101/50-->0-49,50-99,100.
    NSMutableArray *array = @[].mutableCopy;
    for (NSInteger tmpLeftSize = totalSize, index = 0; ; index+=unitSize) {
        if (index+unitSize<=totalSize) {
            [array addObject:NSStringFromRange(NSMakeRange(index, unitSize))];
        } else {
            [array addObject:NSStringFromRange(NSMakeRange(index, totalSize-index))];
            break;
        }
    }
    return array.copy;
}


@end
