//
//  ViewController.m
//  MultipleThread
//
//  Created by 方冬冬 on 2017/8/31.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadViewController.h"
#import "NSThreadTwoViewController.h"
#import "NSThreadThreeViewController.h"
#import "NSOperationViewController.h"
#import "GCDViewController.h"
#import "GCDTwoViewController.h"
#import "GCDThreeViewController.h"
#import "GCDFourViewController.h"
#import "GCDFiveViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.mainTable];
    self.mainTable.delegate = self;
    
    self.mainTable.dataSource = self;
    

    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"NSThread--one  开启子线程执行耗时操作";
        
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"NSThread--two  开启多条线程加载图片无序";

    }else if (indexPath.row == 2){
        cell.textLabel.text = @"NSThread--Three  开启多条线程加载图片无序(可以仅仅能设置线程状态设置取消线程)";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"NSoperation-one  NSBlockOperation创建多个线程加载图片";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"GCD --one  串行队列异步任务（有序）";
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"GCD --two  并发队列异步任务（无序）";
    }else if (indexPath.row == 6){
        cell.textLabel.text = @"GCD --three  并发队列异步任务（无序）加线程锁(NSLOCK)";
    }else if (indexPath.row == 7){
        cell.textLabel.text = @"GCD --four  并发队列异步任务（无序）加线程锁(@synchronized)";
    }else if (indexPath.row == 8){
        cell.textLabel.text = @"GCD -- five  线程之间的调度关系";
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NSThreadViewController *nsthreadVc = [[NSThreadViewController alloc] init];
        
        [self.navigationController pushViewController:nsthreadVc animated:YES];

    }else if (indexPath.row == 1){
        NSThreadTwoViewController *threadVC = [[NSThreadTwoViewController alloc] init];
        
        [self.navigationController pushViewController:threadVC animated:YES];

    }else if (indexPath.row == 2){
        NSthreadThreeViewController *threadVC = [[NSthreadThreeViewController alloc] init];
        
        [self.navigationController pushViewController:threadVC animated:YES];
        
    }else if (indexPath.row == 3){
        NSOperationViewController *operationVc = [[NSOperationViewController alloc] init];
        
        [self.navigationController pushViewController:operationVc animated:YES];
        
    }else if (indexPath.row == 4){
        GCDViewController *gcdVc = [[GCDViewController alloc] init];
        [self.navigationController pushViewController:gcdVc animated:YES];
        
    }else if (indexPath.row == 5){
        GCDTwoViewController *gcdVc = [[GCDTwoViewController alloc] init];
        [self.navigationController pushViewController:gcdVc animated:YES];
    }else if (indexPath.row == 6){
       GCDThreeViewController  *gcdVc = [[GCDThreeViewController alloc] init];
        [self.navigationController pushViewController:gcdVc animated:YES];
    }else if (indexPath.row == 7){
        GCDFourViewController  *gcdVc = [[GCDFourViewController alloc] init];
        [self.navigationController pushViewController:gcdVc animated:YES];
    }else if (indexPath.row == 8){
        GCDFiveViewController  *gcdVc = [[GCDFiveViewController alloc] init];
        [self.navigationController pushViewController:gcdVc animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}



@end
