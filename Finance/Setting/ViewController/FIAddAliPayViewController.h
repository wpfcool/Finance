//
//  FIAddAliPayViewController.h
//  Finance
//
//  Created by wenpeifang on 2018/7/3.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseViewController.h"
#import "FIAliPayData.h"
@interface FIAddAliPayViewController : FIBaseViewController
@property (nonatomic,strong) FIAliPayData * payData;
@property (nonatomic,assign)NSInteger type;//1为添加2为修改

@end
