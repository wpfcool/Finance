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

+ (void)upLoadWithURL:(NSString *)urlString upData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)type params:(NSDictionary *)params  result:(void(^)(id dic,NSError*error))resultBlock;

//获取错误描述
+(NSString *)errorDesc:(NSError *)error;
@end
