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
@end
