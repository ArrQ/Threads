//
//  CustomOperation.h
//  多线程基础demo
//
//  Created by ArrQ on 2017/10/5.
//  Copyright © 2017年 ArrQ. All rights reserved.
//  自定义------NSOperation

#import <Foundation/Foundation.h>

@interface CustomOperation : NSOperation
- (instancetype)initWithName:(NSString *)name;
@end
