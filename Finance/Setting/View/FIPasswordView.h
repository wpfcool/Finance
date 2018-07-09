//
//  FIPasswordView.h
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FIPasswordViewDelegate<NSObject>
-(void)hiddenPasswordView;
-(void)safePassword:(NSString *)password;
@end
@interface FIPasswordView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *hiddenTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UITextField *password3;
@property (weak, nonatomic) IBOutlet UITextField *password4;
@property (weak, nonatomic) IBOutlet UITextField *password5;
@property (weak, nonatomic) IBOutlet UITextField *password6;
@property (weak, nonatomic) id<FIPasswordViewDelegate>delegate;
@end
