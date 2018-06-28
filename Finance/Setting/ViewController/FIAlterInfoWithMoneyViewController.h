//
//  FIRealNameViewController.h
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseViewController.h"
#import "FIUserInfo.h"
//FIAlterInfoWithMoneyViewController
@interface FIAlterInfoWithMoneyViewController : FIBaseViewController
@property (nonatomic,assign)NSInteger alterType;//1为真实姓名  2位手机号
@property (nonatomic,strong)FIUserInfo *userInfo;
@end
