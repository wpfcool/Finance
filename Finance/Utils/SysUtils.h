//
//  SysUtils.h
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysUtils : NSObject
//获得版本号
+ (NSString *)shortVersion;
+(BOOL)isPhoneNumber:(NSString *)phoneNumber;//是否是手机号
+(BOOL)isSafePasswordNumber:(NSString *)passwordNumber;//是否是安全密码
+(BOOL)isPasswordNumber:(NSString *)passwordNumber;
+(BOOL)isUserNameNumber:(NSString *)userName;
+(NSString *)uuid;
//根据剩余秒数生成dd:MM:ss
+(NSString *)getTime:(NSInteger)time;
+(NSString *)getDate:(NSString *)time;
+(NSMutableAttributedString *)attributeStringWithRedX:(NSString *)str;
@end
