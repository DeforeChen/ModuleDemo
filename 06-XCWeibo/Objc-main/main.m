//
//  main.m
//  Objc-main
//
//  Created by Alexcai on 2018/8/19.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>



int my_sum(int a,int b);
void my_test(void);

typedef void(^Tasklock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
       __block int a = 0;
        dispatch_queue_t q1 = dispatch_queue_create("queue_one", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t q2 = dispatch_queue_create("queue_two", DISPATCH_QUEUE_SERIAL);
        
        dispatch_semaphore_t semap = dispatch_semaphore_create(1);
        
        dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
        
        for (int i = 0; i < 100; i++) {
            
            dispatch_async(q1, ^{
                NSLog(@"one %d",a);
                a += 1;
                dispatch_semaphore_signal(semap);
            });
            
            dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
            dispatch_async(q2, ^{
                NSLog(@"two %d",a);
                a += 1;
                dispatch_semaphore_signal(semap);
            });
        }
        NSLog(@"end");
        
        
        
        
       
        
        
        
   
    }
    return 0;
}

int my_sum(int a,int b){
    return  a + b;
}

void my_test(){
    NSMutableArray *_mArray = [NSMutableArray array];
    
    __block int operaterNumber = 0;
    
    // 串行队列
    dispatch_queue_t queue =  dispatch_queue_create("threand-one",DISPATCH_QUEUE_SERIAL);
    
   
    
    // 队列中添加异步任务
    
    for (int i = 0; i < 10; i ++) {
        
        Tasklock task = ^{
            if (operaterNumber % 2) {
                NSLog(@"00000%@perator number %d",[NSThread currentThread],operaterNumber);
                [_mArray addObject:@(operaterNumber)];
                operaterNumber += 1;
            }
        };
        Tasklock task1 = ^{
            if (operaterNumber % 2 == 0) {
                NSLog(@"1111%@ perator number %d",[NSThread currentThread],operaterNumber);
                [_mArray addObject:@(operaterNumber)];
                operaterNumber += 1;
            }
        };
        
        Tasklock execTask = i % 2 ? task : task1;
        NSLog(@"for ....");
        dispatch_async(queue, execTask);
    }
 
    dispatch_sync(queue, ^{
        NSLog(@"----------");
        NSLog(@"%zd",_mArray.count);
        for (NSNumber *number in _mArray) {
            NSLog(@"%d", number.intValue);
        }
        
    });
}
