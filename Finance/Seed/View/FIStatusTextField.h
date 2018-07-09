//
//  FIStatusTextField.h
//  Finance
//
//  Created by wenpeifang on 2018/6/25.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSInteger,TextFieldStatustype){
    TextFieldStatusType,
    TextFieldStatusNum,
    TextFieldStatusMoney,
    TextFieldStatusPassword,
    
    TextFieldStatusTypeName,
    TextFieldStatusTypeBankName,
    TextFieldStatusTypeBankCard,
    TextFieldStatusTypeBankOpen,
    
    TextFieldStatusTypePasswordOld,
    TextFieldStatusTypePasswordNew,
    TextFieldStatusTypePasswordNew2,
    TextFieldStatusTypePasswordYanzhengMa,
    
    TextFieldStatusTypeCodeUserName,
    TextFieldStatustypeCodeCount,
    TextFieldStatustypeCodeSafeCode
};

@interface FIStatusTextField : UITextField
@property (nonatomic,assign)TextFieldStatustype status;//保存uitextField的每个种类
@end
