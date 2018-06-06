//
//  FIUser.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIUser.h"
static FIUser *user = nil;
@implementation FIUser
+(FIUser *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(user == nil)
            user = [[FIUser alloc]init];
    });
    return user;
}
@end
