//
//  ViewController.m
//  多线程基础demo
//
//  Created by ArrQ on 2017/10/4.
//  Copyright © 2017年 ArrQ. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "TicketManager.h"
#import "TestSingle.h"
#import "CustomOperation.h"

#define magin 10
@interface ViewController ()
@property(nonatomic,strong) NSOperationQueue *queue;// 异步 多用
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    TicketManager *manager = [[TicketManager alloc]init];
//    [manager startTosale];
    
    UIButton *button_ = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button_ setTitle:@"pThread" forState:UIControlStateNormal];
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.layer.masksToBounds = YES;
    button_.layer.cornerRadius = 5;
    button_.frame = CGRectMake(100, 100,100, 40);
    button_.layer.borderWidth = 1.f;
    button_.layer.borderColor = [[UIColor colorWithWhite:0.7 alpha:1.0]CGColor];
    [button_ setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
    [button_ addTarget:self action:@selector(clickPThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_];
    
    button_ = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button_ setTitle:@"NSThread" forState:UIControlStateNormal];
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.layer.masksToBounds = YES;
    button_.layer.cornerRadius = 5;
    button_.frame = CGRectMake(100, 150,100, 40);
    button_.layer.borderWidth = 1.f;
    button_.layer.borderColor = [[UIColor colorWithWhite:0.7 alpha:1.0]CGColor];
    [button_ setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
    [button_ addTarget:self action:@selector(clickNSThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_];


    
    button_ = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button_ setTitle:@"GCD" forState:UIControlStateNormal];
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.layer.masksToBounds = YES;
    button_.layer.cornerRadius = 5;
    button_.frame = CGRectMake(100, 200,100, 40);
    button_.layer.borderWidth = 1.f;
    button_.layer.borderColor = [[UIColor colorWithWhite:0.7 alpha:1.0]CGColor];
    [button_ setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
    [button_ addTarget:self action:@selector(clickGCD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_];

    
    button_ = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button_ setTitle:@"单利" forState:UIControlStateNormal];
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.layer.masksToBounds = YES;
    button_.layer.cornerRadius = 5;
    button_.frame = CGRectMake(100, 250,100, 40);
    button_.layer.borderWidth = 1.f;
    button_.layer.borderColor = [[UIColor colorWithWhite:0.7 alpha:1.0]CGColor];
    [button_ setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
    [button_ addTarget:self action:@selector(clickSingle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_];

    
    button_ = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button_ setTitle:@"延迟执行" forState:UIControlStateNormal];
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.layer.masksToBounds = YES;
    button_.layer.cornerRadius = 5;
    button_.frame = CGRectMake(100, 300,100, 40);
    button_.layer.borderWidth = 1.f;
    button_.layer.borderColor = [[UIColor colorWithWhite:0.7 alpha:1.0]CGColor];
    [button_ setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
    [button_ addTarget:self action:@selector(clickTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_];
    
    
    button_ = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button_ setTitle:@"NSOperation" forState:UIControlStateNormal];
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.layer.masksToBounds = YES;
    button_.layer.cornerRadius = 5;
    button_.frame = CGRectMake(100, 350,200, 40);
    button_.layer.borderWidth = 1.f;
    button_.layer.borderColor = [[UIColor colorWithWhite:0.7 alpha:1.0]CGColor];
    [button_ setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
    [button_ addTarget:self action:@selector(clickNSOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_];

    

}


# pragma mark --- PThread text
- (void)clickPThread{
    NSLog(@"主线程");
    pthread_t pthread;
    pthread_create(&pthread, NULL, run, NULL);
    
}


void *run(void *data){
    NSLog(@"子线程");
    for (int i = 1; i < 10; i++) {
    NSLog(@"返回数据：%d",i);
    sleep(1);
        
    }
    return NULL;
}



# pragma mark --- clickNSThread text
// 三种方法 只有 第一种方法  可以 设置 他的 属性   开辟多线程的 标识

- (void)clickNSThread{
    NSLog(@"主线程");
// 1.通过 alloc init 方式创建
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(runThread1) object:nil];
    [thread1 setName:@"name_thread1"];// 区分 线程
    [thread1 setThreadPriority:0.5];// 线程执行的 概率 大小
    [thread1 start];
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(runThread1) object:nil];
    [thread2 setName:@"name_thread2"];
    [thread2 setThreadPriority:0.2];

    [thread2 start];

    
    // 2.通过 detachNewThreadSelector 方式创建并执行
//    [NSThread detachNewThreadSelector:@selector(runThread1) toTarget:self withObject:nil];
    
    // 3.通过 detachNewThreadSelector 方式创建并执行
//    [self performSelectorInBackground:@selector(runThread1) withObject:nil];
    
    
}

- (void)runThread1{
    NSLog(@"子线程");
    NSLog(@"线程名字：%@",[NSThread currentThread].name);

    for (int i = 1; i <= 10; i++) {
        NSLog(@"返回数据：%d",i);
        sleep(1);
        
//        调用 主线程
        
        if (i == 10) {
            [self performSelectorOnMainThread:@selector(runMainThread) withObject:nil waitUntilDone:YES];
        }
        
        
    }
    
    
}

- (void)runMainThread{
    
     NSLog(@"回到主线程");
    
    
    
}



# pragma mark --- GCD text

- (void)clickGCD{
    
     NSLog(@"执行GCD");
//     dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//         NSLog(@"任务1");
//
//        [NSThread sleepForTimeInterval:3];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
////            回到 主线程 刷新 UI
//
//            NSLog(@"刷新UI");
//        });
//    });
//
    
  
//    线程 参数以及多线程 测试
//    dispatch_get_global_queue  全局并发
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//
//         NSLog(@"开始 - 线程 1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"结束 - 线程 1");
//
//
//
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        NSLog(@"开始 - 线程 2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"结束 - 线程 2");
//
//
//
//    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//
//        NSLog(@"开始 - 线程 3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"结束 - 线程 3");
//
//    });
//
 
 
//    串行 队列 一个 线程   参数 -  DISPATCH_QUEUE_SERIAL
    
//    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.queue",DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue, ^{
//        NSLog(@"开始 任务1 ");
//        [NSThread sleepForTimeInterval:2];
//
//         NSLog(@"结束 任务1");
//
//    });
//
//    dispatch_async(queue, ^{
//        NSLog(@"开始 任务2 ");
//        [NSThread sleepForTimeInterval:2];
//
//        NSLog(@"结束 任务2");
//
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"开始 任务3 ");
//        [NSThread sleepForTimeInterval:2];
//
//        NSLog(@"结束 任务3");
//
//    });
//
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.group", DISPATCH_QUEUE_SERIAL);
    
    dispatch_group_t group = dispatch_group_create();
    
    

    
//    dispatch_group_async(group, queue, ^{
//         NSLog(@"开始任务1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"结束任务1");
//
//    });
//
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"开始任务2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"结束任务2");
//
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"开始任务3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"结束任务3");
//
//    });
//
//
//
//    dispatch_group_notify(group, queue, ^{
//
//        NSLog(@"所有任务 结束");
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//             NSLog(@"回到主线程 刷新UI ");
//
//        });
//
//    });
//
   
    
    
    
//    ----------    两个 异步请求
    
    
   
    
//    dispatch_group_async(group, queue, ^{
//        [self sendRequest1:^{
//
//             NSLog(@"sendRequest1 done");
//        }];
//
//    });
//    dispatch_group_async(group, queue, ^{
//        [self sendRequest2:^{
//
//            NSLog(@"sendRequest2 done");
//        }];
//
//    });
    
    
    //    添加 ------  enter 方式
    
    dispatch_group_enter(group);
    
    [self sendRequest1:^{
        
        NSLog(@"sendRequest1 done");

        dispatch_group_leave(group);
        
    }];
    [self sendRequest2:^{
        
        NSLog(@"sendRequest2 done");
        
        dispatch_group_leave(group);  //  enter 后  需要 释放掉
        
    }];
    
    
//    --------
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"所有任务 结束");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"回到主线程 刷新UI ");
            
        });
        
    });
    
    
}


// 两个 异步请求

- (void)sendRequest1:(void(^)(void))block {
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         NSLog(@"开始任务1");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束任务1");

        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (block) {
                
                block();
            }
            
        });
        
    });
    
    
    
}


- (void)sendRequest2:(void (^)(void))block{
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"开始任务2");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束任务2");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (block) {
                
                block();
            }
            
        });
        
    });
    
    
    
}


# pragma mark --- 单利 test

- (void)clickSingle{
    
//    TestSingle *single = [TestSingle instance];
//     NSLog(@"单利----%@",single);
    
//     那么 只执行 一次呢
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
         NSLog(@"我只执行一次哦！");
        
    });
    
}



# pragma mark --- 延迟执行
- (void)clickTime{
    
//    弊端 返回页面时候   依然 执行   给个  变量  退出的 时候  给个 yes  不执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

         NSLog(@"延迟 2秒钟 ");
        
    });
}




# pragma mark --- NSOperation test

- (void)clickNSOperation{
    
    NSLog(@"main thread");// 此时 你会 发现  都是主线程 执行 这样势必 会 阻塞 所以要开辟 子线程
//    NSInvocationOperation *invocation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationAction) object:nil];
//    [invocation start];
    
    
    
// -------------   子类方式 实现 ---------
//   ---------------- NSInvocationOperation --------

    
// 1.
//    开辟子线程
    
//    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//
//        NSInvocationOperation *invocation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationAction) object:nil];
//        [invocation start];
//
//         NSLog(@"全部任务结束----验证 同步方式");
//    });
//   ---------------- NSBlockOperation --------
//2.
    
//    NSBlockOperation *blocker = [NSBlockOperation blockOperationWithBlock:^{
//
//        for (int i = 0; i<3; i++) {
//
//             NSLog(@"%d",i);
//            [NSThread sleepForTimeInterval:1];
//        }
//
//    }];
    
//    [blocker start];
//    异步方式
    
//    if (!self.queue) {
//
//        self.queue = [[NSOperationQueue alloc]init];
//
//
//    }
    
//    [self.queue addOperation:blocker];
//
//     NSLog(@"end 所有任务---验证异步方式");
    
    
//  ------------------  自定义 方式实现  --------
//   异步 2   自定义 ------NSOperation
    
    if (!self.queue) {
        
        self.queue = [[NSOperationQueue alloc]init];
    
    }
    [self.queue setMaxConcurrentOperationCount:4];// 设置 最大 线程数
    CustomOperation *customOperationA = [[CustomOperation alloc]initWithName:@"customOperationA"];
    CustomOperation *customOperationB = [[CustomOperation alloc]initWithName:@"customOperationB"];
    CustomOperation *customOperationC = [[CustomOperation alloc]initWithName:@"customOperationC"];
    CustomOperation *customOperationD = [[CustomOperation alloc]initWithName:@"customOperationD"];
//  依赖 B->C->A->D  执行顺序   依赖 设置后  执行完 才会 执行 最大线程数
    [customOperationD addDependency:customOperationA];
    [customOperationA addDependency:customOperationC];
    [customOperationC addDependency:customOperationB];
    
    [self.queue addOperation:customOperationA];
    [self.queue addOperation:customOperationB];
    [self.queue addOperation:customOperationC];
    [self.queue addOperation:customOperationD];

     NSLog(@"end 所有任务---验证异步方式");

    
    
}


- (void)invocationAction{
    
    for (int i = 0; i < 3; i++) {
        
         NSLog(@"%d",i);
        
        [NSThread sleepForTimeInterval:1];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
