//
//  FIOrderDetailOrderCell.h
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIOrderData.h"
@interface FIOrderDetailOrderCell : UITableViewCell
@property (nonatomic,strong)FIOrderData * orderData;
@property (nonatomic,assign)OrderType orderType;
@end
