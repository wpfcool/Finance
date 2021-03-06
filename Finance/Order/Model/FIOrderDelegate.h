//
//  FIOrderDelegate.h
//  Finance
//
//  Created by wenpeifang on 2018/7/10.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FIOrderData;
@protocol FIOrderDelegate <NSObject>
@optional
-(void)uploadPingzheng:(NSString *)orderId;
//-(void)contactMemeber:(NSString *)orderId orderType:(OrderType)type Phone:(NSString *)phone;
-(void)contactMemeber:(NSString * )userid;

-(void)cuiConfirm:(NSString *)orderId;
-(void)confirmPay:(NSString *)orderId;
-(void)complain:(FIOrderData *)orderData orderType:(OrderType)type;
-(void)pingjia:(NSString *)orderId orderType:(OrderType)type;
-(void)getPingzheng:(NSString *)image;//获得凭证

//-(void)memberInfo:(NSString *)
@end
