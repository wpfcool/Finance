//
//  FIAlterInfoWithMoneyCell.h
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FIAlterInfoWithMoneyCellDelegate;
@interface FIAlterInfoWithMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic,weak)id<FIAlterInfoWithMoneyCellDelegate>delegate;
- (IBAction)buttonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end


@protocol FIAlterInfoWithMoneyCellDelegate<NSObject>
-(void)buttonClick:(FIAlterInfoWithMoneyCell *)cell;
@end
