//
//  FIScoreData.m
//  Finance
//
//  Created by wenpeifang on 2018/7/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIScoreData.h"

@implementation FIScoreData

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *timestamp =[NSString stringWithFormat:@"%@", dic[@"sell_evaluate_time"]] ;
    if(timestamp.length ==0)
        return NO;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp.integerValue];
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    _sell_evaluate_time  = [format stringFromDate:date];
        
    return YES;
}

@end
