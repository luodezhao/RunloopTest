//
//  TestMachPort.m
//  RunLoopTest
//
//  Created by YB on 16/1/28.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "TestMachPort.h"

@implementation TestMachPort
+ (int)getPortMessageWithPort:(NSPort *)port {
    NSPortMessage *mssage = [[NSPortMessage alloc]initWithMachPort:port];
    NSLog(@"%@",mssage);
    [mssage release];
    return 1;
}
@end
