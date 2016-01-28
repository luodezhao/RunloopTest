//
//  ViewController.m
//  RunLoopTest
//
//  Created by YB on 16/1/15.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "ViewController.h"
#import "TestMachPort.h"
@interface ViewController ()<UIScrollViewDelegate,NSPortDelegate>
//NSRunloop 是CFRunloopRef 的oc层面的封装。

{
    CFRunLoopRef aRunLoop;
    CFRunLoopSourceRef source;
    __weak NSArray * weekArray;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = [NSArray array];
    weekArray = array;
    
//    [self testTimer];
//    [self willWorkWithOutSource];
    [self inputSource];
//    [self testDisPatch];
       
}
- (void)testDisPatch {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSLog(@"1");
    });
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"1");
//            });
    
}
- (void)willWorkWithOutSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [self commonTimer];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"1");
    });
}
- (void)testTimer{
    UIScrollView *myScroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        myScroll.contentSize = CGSizeMake(375, 10000);
        [self.view addSubview:myScroll];
        myScroll.backgroundColor = [UIColor redColor];
    myScroll.delegate = self;
    [self defalutTimer];//defalult mode 下的timer
    [self commonTimer];//common modes中的timer
    
}


- (void)defalutTimer {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTime) userInfo:nil repeats:YES];
}
- (void)commonTimer {
    NSTimer *timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(doTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)doTime {
    NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"timer--");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%p",&weekArray);
    CFRunLoopSourceSignal(source);
    CFRunLoopWakeUp(aRunLoop);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//配置基于端口的输入源
- (void)inputSource {
//    NSPort *myPort = [NSMachPort port];
//    [myPort setDelegate:self];//处理了port的传递
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
//        NSLog(@"1");
//    });
////    [TestMachPort getPortMessageWithPort:myPort];
//
////    NSPortMessage * message1;
//
////    NSLog(@"%@",MyBlock());
//   static CFRunLoopRef a;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CFRunLoopSourceContext context = {0,NULL,NULL,NULL,NULL,NULL,NULL,&isadd,&isCancel,&perfor};
        aRunLoop = CFRunLoopGetCurrent();
source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);

NSInteger bb =  CFRunLoopRunInMode(  (__bridge CFStringRef)NSDefaultRunLoopMode, 3, YES) ;
        NSLog(@"%ld",bb);
        

        
    });
}
void isadd() {
    NSLog(@"add");
}
void isCancel (){
    NSLog(@"cancel");
}
void perfor () {
    NSLog(@"perform");
}

//- (void)handlePortMessage:(NSPortMessage *)message {
//    NSLog(@"%@",message);
//}
@end
