//
//  FIBankInfoViewController.h
//  Finance
//
//  Created by 海龙 on 2018/7/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseViewController.h"
#import "FIBankData.h"
@interface FIBankInfoViewController : FIBaseViewController
@property (nonatomic,strong)FIBankData * bankData;
@property (nonatomic,assign)NSInteger type;//1为添加2为修改
@property (nonatomic,strong)NSString * realName;

@end
