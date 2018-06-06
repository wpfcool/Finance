//
//  FIUser.h
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FIUser : NSObject
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *token;
+(FIUser *)shareInstance;
@end
