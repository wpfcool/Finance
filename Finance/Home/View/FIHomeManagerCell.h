//
//  FIHomeManagerCell.h
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FIHomeManagerCellDelegate<NSObject>
-(void)financeCenterClick;
-(void)myTeamClick;
-(void)buyClick;
-(void)sellOutClick;
@end
@interface FIHomeManagerCell : UITableViewCell
@property (nonatomic,weak)id<FIHomeManagerCellDelegate>delegate;
@end



