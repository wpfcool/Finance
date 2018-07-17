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

+(NSString *)uuid;
//根据剩余秒数生成dd:MM:ss
+(NSString *)getTime:(NSInteger)time;

+(NSMutableAttributedString *)attributeStringWithRedX:(NSString *)str;
@end
