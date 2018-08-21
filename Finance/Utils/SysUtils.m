//
//  SysUtils.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "SysUtils.h"
#import "SFHFKeychainUtils.h"
#define USERNAME @"com.wpf.finance"
#define SERVERNAME @"com.wpf.finance.service"
@implementation SysUtils
+ (NSString *)shortVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return infoDict[@"CFBundleShortVersionString"];
    
}

+(NSString *)uuid
{
    NSString *temp= [SFHFKeychainUtils getPasswordForUsername:USERNAME andServiceName:SERVERNAME error:nil];
    
    if(temp==nil || [temp isEqualToString:@""])
    {
        temp=[self getUUid];
        [SFHFKeychainUtils storeUsername:USERNAME andPassword:temp forServiceName:SERVERNAME updateExisting:YES error:nil];
    }
    return temp;
}
+(NSString*)getUUid
{
    NSString * uuid =[[UIDevice currentDevice] identifierForVendor].UUIDString;
    return uuid;
}

+(NSString *)getTime:(NSInteger)time{
    //天
    NSInteger day = time / 86400;
    NSInteger hour = (time - day* 86400)/3600;
    NSInteger minute = (time - hour * 3600 - day * 86400) / 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(long)day,(long)hour,(long)minute];
}
+(NSMutableAttributedString *)attributeStringWithRedX:(NSString *)str{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:HEX_UICOLOR(0x3F3F3F, 1) range:NSMakeRange(0, str.length)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, str.length)];
    
    return string;
}
+(NSString *)getDate:(NSString *)time{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
    NSDateFormatter * fommate = [[NSDateFormatter alloc]init];
    [fommate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [fommate stringFromDate:date];
}
+(BOOL)isBankNumber:(NSString *)bank{
    NSString *regex = @"^[0-9]*$";
    return [SysUtils chenkString:bank regex:regex];
}
+(BOOL)isPasswordNumber:(NSString *)passwordNumber{
    NSString *regex = @"^(?![0-9]+$)\\w{8,}$";
    return [SysUtils chenkString:passwordNumber regex:regex];
}
+(BOOL)isUserNameNumber:(NSString *)userName{
    NSString *regex = @"^(?![0-9]+$)\\w{6,12}$";
    return [SysUtils chenkString:userName regex:regex];
}
+(BOOL)isSafePasswordNumber:(NSString *)passwordNumber{
    NSString *regex = @"^[0-9]{6}$";
    return [SysUtils chenkString:passwordNumber regex:regex];
}

+(BOOL)isPhoneNumber:(NSString *)phoneNumber{
    
    NSString *regex = @"^1[345789]\\d{9}$";
    return [SysUtils chenkString:phoneNumber regex:regex];
}
+ (BOOL)chenkString:(NSString *)str regex:(NSString *)regex
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    // 对str字符串进行匹配
    NSArray *matches = [regular matchesInString:str
                                        options:0
                                          range:NSMakeRange(0, str.length)];
    
    if(matches.count > 0){
        return YES;
    }
    return NO;
}
@end
