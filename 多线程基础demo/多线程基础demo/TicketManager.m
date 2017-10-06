//
//  TicketManager.m
//  多线程基础demo
//
//  Created by ArrQ on 2017/10/4.
//  Copyright © 2017年 ArrQ. All rights reserved.
//

#import "TicketManager.h"


#define Total 10
@interface TicketManager ()
@property(nonatomic,assign) int tickets; // 剩余票数
@property(nonatomic,assign) int saleCount;// 卖出票数

@property(nonatomic,strong) NSThread *threadBJ;

@property(nonatomic,strong) NSThread *threadSH;

// 另一种 加锁方式

@property(nonatomic,strong) NSCondition *ticketCondition;

@end

@implementation TicketManager

- (instancetype)init{
    
    if (self = [super init]) {
        self.tickets = Total;
        self.threadBJ = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        [self.threadBJ setName:@"北京"];
        self.threadSH = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        [self.threadSH setName:@"上海"];

        
    }
    
    return self;
    
    
}

- (void)sale{
    
    while (true) {
        
//        第一种 加锁状态 @synchronized
        
//        @synchronized (self) {
//
//            //        tickets > 0  说明还可以卖票
//            if (self.tickets > 0) {
//
//                [NSThread sleepForTimeInterval:0.5];
//                self.tickets--;
//                self.saleCount = Total - self.tickets;
//                NSLog(@"%@:当前余票：%d,售出：%d",[NSThread currentThread].name,self.tickets,self.saleCount);
//            }
//
//
//        }
        
//  第二种 加锁  状态   NSCondition   不管用 md 
        
        
        [self.ticketCondition lock];
                //        tickets > 0  说明还可以卖票
                if (self.tickets > 0) {
        
                    [NSThread sleepForTimeInterval:0.5];
                    self.tickets--;
                    self.saleCount = Total - self.tickets;
                    NSLog(@"%@:当前余票：%d,售出：%d",[NSThread currentThread].name,self.tickets,self.saleCount);
                }
        [self.ticketCondition unlock];
        
        
        
//        没有 加锁的  状态
//        //        tickets > 0  说明还可以卖票
//        if (self.tickets > 0) {
//
//            [NSThread sleepForTimeInterval:0.5];
//            self.tickets--;
//            self.saleCount = Total - self.tickets;
//            NSLog(@"%@:当前余票：%d,售出：%d",[NSThread currentThread].name,self.tickets,self.saleCount);
//        }
//

        
        
    }
    
    
    
}


- (void)startTosale{
    
    [self.threadBJ start];
    [self.threadSH start];
    
}






@end
