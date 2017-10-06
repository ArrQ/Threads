//
//  TestSingle.m
//  多线程基础demo
//
//  Created by ArrQ on 2017/10/5.
//  Copyright © 2017年 ArrQ. All rights reserved.
//

#import "TestSingle.h"

@implementation TestSingle

+ (instancetype)instance{
    
    static dispatch_once_t onceToken;
    static TestSingle *single = nil;
    
    dispatch_once(&onceToken, ^{
        NSLog(@"init the single");
        single = [[TestSingle alloc]init];
        
    });
    
    return single;
    
}
@end
