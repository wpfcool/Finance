//
//  JSONUtils.h
//  jcloud
//
//  Created by zhangfusheng on 15/11/26.
//  Copyright © 2015年 Beijing Jingdong Shangke Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONUtils : NSObject

+ (id)JSONObjectWithoutNull:(id)JSONObject;

+ (id)convertObject:(id)object toType:(Class)aClass;

@end

#define JSONToType(obj, type) [JSONUtils convertObject:obj toType:[type class]]
