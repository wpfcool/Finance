//
//  FIOrderPageViewController.h
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseViewController.h"

@interface FIOrderPageViewController : FIBaseViewController
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger index;//0位待匹配1为待付款 2 待确认 3待评价
@property (nonatomic,assign)NSInteger orderCataory;//1买入2卖出
@end
