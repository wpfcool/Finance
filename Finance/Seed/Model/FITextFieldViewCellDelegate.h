//
//  FITextFieldViewCellDelegate.h
//  Finance
//
//  Created by 海龙 on 2018/7/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FITextFieldViewCellDelegate <NSObject>
-(void)textFieldDidChanged:(FIStatusTextField * )textField;

@end
