//
//  main.m
//  BaseModuleAppOldConfig
//
//  Created by zhongxiaoming on 2022/3/4.
//
#import <dlfcn.h>

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import <fishhook.h>
#import "objc-retainCount/NSObject+GACRetainCount.h"
#import "MainViewController.h"
static int (*orig_close)(int);
static int (*orig_open)(const char *, int, ...);
 
int my_close(int fd) {
  printf("Calling real close(%d)\n", fd);
  return orig_close(fd);
}
 
int my_open(const char *path, int oflag, ...) {
  va_list ap = {0};
  mode_t mode = 0;
 
  if ((oflag & O_CREAT) != 0) {
    // mode only applies to O_CREAT
    va_start(ap, oflag);
    mode = va_arg(ap, int);
    va_end(ap);
    printf("Calling real open('%s', %d, %d)\n", path, oflag, mode);
    return orig_open(path, oflag, mode);
  } else {
    printf("Calling real open('%s', %d)\n", path, oflag);
    return orig_open(path, oflag, mode);
  }
}



int main(int argc, char * argv[]) {
    
    [NSObject printAutoreleasepool];
    NSLog(@"234");
    NSString *appDelegate;
    @autoreleasepool {
////      rebind_symbols((struct rebinding[2]){{"close", my_close, (void *)&orig_close}, {"open", my_open, (void *)&orig_open}}, 2);
//        NSString *str = [NSString stringWithFormat:@"asaasdflajsdfljaf:%@",[NSObject class]];
//        __autoreleasing id view = [[MVViewB alloc] init];
//
        [NSObject printAutoreleasepool];
//        NSLog(@"234");
      // Open our own binary and print out first 4 bytes (which is the same
      // for all Mach-O binaries on a given architecture)
      int fd = open(argv[0], O_RDONLY);
      uint32_t magic_number = 0;
      read(fd, &magic_number, 4);
      printf("Mach-O Magic Number: %x \n", magic_number);
      close(fd);
        appDelegate = NSStringFromClass([AppDelegate class]);
        return UIApplicationMain(argc, argv, nil, appDelegate);
    }
}
