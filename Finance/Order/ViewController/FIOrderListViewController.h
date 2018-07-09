//
//  FIOrderListViewController.h
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseViewController.h"

@interface FIOrderListViewController : FIBaseViewController
@property (nonatomic,assign)NSInteger type;//0位待匹配1为待付款 2 待确认 3待评价
@property (nonatomic,assign)NSInteger orderCataory;//1买入2卖出
@end
