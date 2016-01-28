//
//  TestMachPort.h
//  RunLoopTest
//
//  Created by YB on 16/1/28.
//  Copyright © 2016年 YB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestMachPort : NSObject
+ (int)getPortMessageWithPort:(NSPort *)port ;
@end
