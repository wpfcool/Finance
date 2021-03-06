//
//  FITextFieldViewCell.h
//  Finance
//
//  Created by wenpeifang on 2018/6/25.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FIStatusTextField.h"
#import "FITextFieldViewCellDelegate.h"

@interface FITextFieldViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet FIStatusTextField *textField;
@property (nonatomic,weak)id<FITextFieldViewCellDelegate>delegate;

@end


