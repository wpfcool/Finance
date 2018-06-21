//
//  FIHomeOrderViewCell.h
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FIHomeOrderViewCell;
@protocol FIHomeOrderViewCellDelegate<NSObject>
-(void)waitingMatchClick:(FIHomeOrderViewCell *)cell;
-(void)waitingPayClick:(FIHomeOrderViewCell *)cell;
-(void)waitingConfirmClick:(FIHomeOrderViewCell *)cell;
-(void)waitingAppraise:(FIHomeOrderViewCell *)cell;
@end
@interface FIHomeOrderViewCell : UITableViewCell
@property (nonatomic,weak)id<FIHomeOrderViewCellDelegate>delegate;
@end



