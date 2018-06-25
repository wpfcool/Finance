//
//  FISeedViewController.h
//  Finance
//
//  Created by wenpeifang on 2018/6/24.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseViewController.h"

@interface FISeedViewController : FIBaseViewController
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIButton *submitButton;
@property (nonatomic,strong)UIView * headerView;
-(NSString *)getTitle;
@end
