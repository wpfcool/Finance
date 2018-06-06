//
//  HttpRequest.h
//  Finance
//
//  Created by wenpeifang on 2018/6/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

+(void)getWithUrlString:(NSString *)urlString parameters:(NSDictionary*)parameters result:(void(^)(id dic,NSError*error))resultBlock;

+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary*)parameters result:(void(^)(id dic,NSError*error))resultBlock;
@end
