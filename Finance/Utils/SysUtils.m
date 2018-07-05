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

+(NSString *)getTime:(NSString *)time{
    NSInteger second = [time integerValue];
    NSInteger hour = second / 3600;
    NSInteger minute = (second - hour * 3600) / 60;
    NSInteger secondN = (second - hour * 3600 - minute * 60);
    return [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(long)hour,(long)minute,(long)secondN];
}
+(NSMutableAttributedString *)attributeStringWithRedX:(NSString *)str{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:HEX_UICOLOR(0x3F3F3F, 1) range:NSMakeRange(0, str.length)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, str.length)];
    
    return string;
}
@end
