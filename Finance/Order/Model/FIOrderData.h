//
//  FIOrderData.h
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FIOrderData : NSObject
@property (nonatomic,copy)NSString *order_id;
@property (nonatomic,copy)NSString *orderNum;//订单数量

@property (nonatomic,copy)NSString *orderNo;//订单号
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *overNumber;//剩余云矿机匹配数量
@property (nonatomic,copy)NSString *number;//一共需要匹配云矿机数量
@property (nonatomic,copy)NSString *add_time;//申请时间
@property (nonatomic,copy)NSString *app_time;//匹配成功时间


@property (nonatomic,copy)NSString *buy_name;//购买会员
@property (nonatomic,copy)NSString *pay_time;//支付时间
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *image;//转账凭证
@property (nonatomic,copy)NSString *is_lodge;//1、未投诉 2.已投诉
@end
