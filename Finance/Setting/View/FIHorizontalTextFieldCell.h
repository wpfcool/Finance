//
//  FIHorizontalTextFieldCell.h
//  Finance
//
//  Created by 海龙 on 2018/7/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIStatusTextField.h"
#import "FITextFieldViewCellDelegate.h"
@interface FIHorizontalTextFieldCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet FIStatusTextField *contentTextField;
@property (nonatomic,weak)id<FITextFieldViewCellDelegate>delegate;

@end
