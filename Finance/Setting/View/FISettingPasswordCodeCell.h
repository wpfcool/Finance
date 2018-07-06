//
//  FISettingPasswordCodeCell.h
//  Finance
//
//  Created by wenpeifang on 2018/7/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIStatusTextField.h"
#import "FITextFieldViewCellDelegate.h"


@protocol FISettingPasswordCodeCellDelegate<FITextFieldViewCellDelegate>
-(void)codeButtonClick:(UIButton *)button;
@end

@interface FISettingPasswordCodeCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet FIStatusTextField *codeTextField;
@property (nonatomic,weak)id<FISettingPasswordCodeCellDelegate>delegate;

@end



