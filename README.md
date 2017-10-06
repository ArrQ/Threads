# 多线程 基础须知

最熟悉  用的最多的 
多核  运算的    引入了 Block   

GCD  


任务方面：
同步 异步  会不会 阻塞 主线程 
 
同步 会 阻塞

- 队列 相关  ：

  - 串行：任务1  任务 2

  - 并行：多个 线程 同时进行 


    - dispatch_get_main_queue     UI 的 刷新

    - dispatch_get_global_queue



### NSOperation ————-gcd 的封装

- NSOperationQueue
  - a addOperation
  - b setMaxConcurrentOperationCount

- 状态

` ready cancelled executing  finished  asynchronous`

- 依赖 — addDependency
