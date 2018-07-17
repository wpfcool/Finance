//
//  FICenterRecordCell.h
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FICenterRecordCellDelegate<NSObject>
-(void)buyOrderList;
-(void)sellOutOrderList;
@end

@interface FICenterRecordCell : UITableViewCell
@property (nonatomic,weak)id<FICenterRecordCellDelegate>delegate;
@end
