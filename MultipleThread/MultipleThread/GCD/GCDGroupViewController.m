//
//  GCDGroupViewController.m
//  MultipleThread
//
//  Created by 方冬冬 on 2017/9/1.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "GCDGroupViewController.h"

@interface GCDGroupViewController ()

@end

@implementation GCDGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

     
    

}


- (void)dispatch_barrier_async{
    //4之后的任务在我线程sleep之后才执行，这其实就起到了一个线程锁的作用，在多个线程同时操作一个对象的时候，读可以放在并发进行，当写的时候，我们就可以用dispatch_barrier_async方法，效果杠杠的。
    dispatch_queue_t concurrentDispatchQueue=dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"0");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"1");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"2");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"3");
    });
    dispatch_barrier_async(concurrentDispatchQueue, ^{
        sleep(1);
        NSLog(@"4");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"5");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"6");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"7");
    });
    dispatch_async(concurrentDispatchQueue, ^{
        NSLog(@"8");
    });
    
}

- (void)dispatch_set_target_queue{

    dispatch_queue_t serialDispatchQueue=dispatch_queue_create("com.test.queue", NULL);
    dispatch_queue_t dispatchgetglobalqueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_set_target_queue(serialDispatchQueue, dispatchgetglobalqueue);
    dispatch_async(serialDispatchQueue, ^{
        NSLog(@"我优先级低，先让让");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我优先级高,我先block");
    });
    

}

- (void)set_globalPriofity{//设置优先级 （就是说可以优先执行某个任务但是这个任务会不会比其他任务先执行完不能确定）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"4");
        NSLog(@"%@",[NSThread currentThread]);
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"3");
        NSLog(@"%@",[NSThread currentThread]);
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
        NSLog(@"%@",[NSThread currentThread]);
        
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"1");
        NSLog(@"%@",[NSThread currentThread]);
        
    });

}

- (void)main_threadClogMethod{

    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(queue, ^{//串行同步任务  阻塞主线程
        sleep(1);
        NSLog(@"1");
    });
    dispatch_sync(queue, ^{
        sleep(1);
        NSLog(@"2");
    });
    dispatch_sync(queue, ^{
        sleep(1);
        NSLog(@"3");
    });
    NSLog(@"4");
}

- (void)updateUIMethod{//主线程更新UI
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"异步线程%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"异步主线程%@",[NSThread currentThread]);
        });
    });
}


- (void)afterMethod{//延迟执行
    NSLog(@"延迟前");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟中"); //不会阻塞线程 但是会使内部的代码延迟执行
        
    });
    
    NSLog(@"延迟前");
}

- (void)global_queueClogMethod{//无法确定开启几条线程
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"第1个任务%@",[NSThread currentThread]);
        
        NSLog(@"1");
    });
    
    dispatch_async(queue, ^{
        sleep(3);//使当前任务中的代码延迟两秒执行
        NSLog(@"2");
        NSLog(@"第2个任务%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"3");
        NSLog(@"第3个任务%@",[NSThread currentThread]);
        
    });
    
    NSLog(@"第4个任务%@",[NSThread currentThread]);
    NSLog(@"4");
}

- (void)groupMethod{
    
    //当我们需要监听一个并发队列中，所有任务都完成了，就可以用到这个group，因为并发队列你并不知道哪一个是最后执行的，所以以单独一个任务是无法监听到这个点的，如果把这些单任务都放到同一个group，那么，我们就能通过dispatch_group_notify方法知道什么时候这些任务全部执行完成了。
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"0");
    });
    dispatch_group_async(group, queue,^{
        NSLog(@"1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"down");
    });
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
