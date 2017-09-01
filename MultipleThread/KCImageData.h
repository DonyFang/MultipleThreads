//
//  KCImageData.h
//  MultipleThread
//
//  Created by 方冬冬 on 2017/8/31.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCImageData : NSObject

#pragma mark 索引
@property (nonatomic,assign) NSInteger index;

#pragma mark 图片数据
@property (nonatomic,strong) NSData *data;
@end
