//
//  FIHomeOrderHeaderCell.h
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIBaseTableViewCell.h"
@interface FISectionHeaderCell : FIBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
-(void)hiddenMore:(BOOL)hidden;
@end
