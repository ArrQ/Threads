//
//  CustomOperation.m
//  多线程基础demo
//
//  Created by ArrQ on 2017/10/5.
//  Copyright © 2017年 ArrQ. All rights reserved.
//

#import "CustomOperation.h"
@interface CustomOperation ()
@property(nonatomic,copy) NSString *operName;

@property BOOL over;
@end
@implementation CustomOperation

- (instancetype)initWithName:(NSString *)name{
    
    if (self = [super init]) {
        
        self.operName = name;
        
    }
    
    
    return self;
}

- (void)main{// main 方法 ---- 很快 执行完奥！
    
//    for (int i = 0; i <= 3; i++) {
//
//         NSLog(@"%@ %d",self.operName,i);
//
//        [NSThread sleepForTimeInterval:1];// 时间 间隔 
//
//    }// 耗时操作
//
    
    
//    异步 解决 耗时操作
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [NSThread sleepForTimeInterval:1];
        if (self.cancelled) {
            return ;
        }
        NSLog(@"%@",self.operName);
        self.over = YES;
    });
    
    
//    main 方法 很快 执行完 怎么办   通过  runloop  来 设定
    while (!self.over && !self.cancelled) {
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];// 简单来讲  循环 监听状态
        
    }
    
    
    
    
}


@end
