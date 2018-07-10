//
//  FICenterData.h
//  Finance
//
//  Created by wenpeifang on 2018/6/22.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FICenterData : NSObject
@property (nonatomic,copy)NSString * total_seed;//总收益
@property (nonatomic,copy)NSString * grand_seed;//累计收益
@property (nonatomic,copy)NSString * buy_seed;//买入云矿机总数
@property (nonatomic,copy)NSString * sell_seed;//卖出云矿机总数
@property (nonatomic,copy)NSString * wait_seed;//待卖出云矿机总数
@property (nonatomic,copy)NSString * code;//激活码个数
@end
