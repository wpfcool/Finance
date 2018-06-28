//
//  FIPropData.m
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPropData.h"
#import <YYModel/YYModel.h>
@implementation FIPropData
+(NSDictionary *)modelCustomPropertyMapper{
    
    return @{
             @"propId":@"id"
             };
}
@end
