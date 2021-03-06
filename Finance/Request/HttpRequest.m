//
//  HttpRequest.m
//  Finance
//
//  Created by wenpeifang on 2018/6/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "HttpRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import "WFEncrypt.h"
#import "JSONUtils.h"
@implementation HttpRequest
//获得方法名
+(NSString *)getUrlName:(NSString *)url
{
    NSString * method = [[url componentsSeparatedByString:@"/"] lastObject];
    return method;
}

+(void)getWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters result:(void(^)(id dic,NSError*error))resultBlock{
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *method = [self getUrlName:urlString];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *  jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *JsonDES = [WFEncrypt TripleDES:jsonString encryptOrDecrypt:kCCEncrypt key:@"p2p_standard2_base64_key"];
    NSString * combination = [NSString stringWithFormat:@"123456987654%@%@",method,JsonDES];
    NSString * sign = [WFEncrypt md5:combination];
    [manager.requestSerializer setValue:@"123456" forHTTPHeaderField:@"Deviceid"];
    [manager.requestSerializer setValue:@"987654" forHTTPHeaderField:@"Requestid"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"Sign"];
    [manager.requestSerializer setValue:method forHTTPHeaderField:@"Method"];
    
    [manager GET:urlString parameters:@{@"value":JsonDES} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        json = [JSONUtils JSONObjectWithoutNull:json];        //去除[NSNULL null]; 避免闪退
    
        NSString * code =  json[@"code"];
        if([code integerValue] == 10000){
            id result = json[@"results"];
            resultBlock(result,nil);
        }
        else{
            NSError * error = [self errorWithJSON:json];
            resultBlock(nil,error);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError * networkerror= [self networkError];
        resultBlock(nil,networkerror);
    }];
    
}



+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters result:(void(^)(id dic,NSError*error))resultBlock{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *method = [self getUrlName:urlString];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *  jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *JsonDES = [WFEncrypt TripleDES:jsonString encryptOrDecrypt:kCCEncrypt key:@"p2p_standard2_base64_key"];
    NSString * combination = [NSString stringWithFormat:@"123456987654%@%@",method,JsonDES];
    NSString * sign = [WFEncrypt md5:combination];
    [manager.requestSerializer setValue:@"123456" forHTTPHeaderField:@"Deviceid"];
    [manager.requestSerializer setValue:@"987654" forHTTPHeaderField:@"Requestid"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"Sign"];
    [manager.requestSerializer setValue:method forHTTPHeaderField:@"Method"];
    
    
    [manager POST:urlString parameters:@{@"value":JsonDES} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //去除[NSNULL null]; 避免闪退
        json = [JSONUtils JSONObjectWithoutNull:json];
        
        NSString * code =  json[@"code"];
        if([code integerValue] == 10000){
            id result = json[@"results"];
            resultBlock(result,nil);
        }
        else{
            NSError * error = [self errorWithJSON:json];
            resultBlock(nil,error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError * networkerror= [self networkError];
        resultBlock(nil,networkerror);
    }];
}

+ (void)upLoadWithURL:(NSString *)urlString upData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)type params:(NSDictionary *)params  result:(void(^)(id dic,NSError*error))resultBlock{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *method = [self getUrlName:urlString];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *  jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *JsonDES = [WFEncrypt TripleDES:jsonString encryptOrDecrypt:kCCEncrypt key:@"p2p_standard2_base64_key"];
    NSString * combination = [NSString stringWithFormat:@"123456987654%@%@",method,JsonDES];
    NSString * sign = [WFEncrypt md5:combination];
    [manager.requestSerializer setValue:@"123456" forHTTPHeaderField:@"Deviceid"];
    [manager.requestSerializer setValue:@"987654" forHTTPHeaderField:@"Requestid"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"Sign"];
    [manager.requestSerializer setValue:method forHTTPHeaderField:@"Method"];
    
    
    [manager POST:urlString parameters:@{@"value":JsonDES} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //去除[NSNULL null]; 避免闪退
        json = [JSONUtils JSONObjectWithoutNull:json];
        
        NSString * code =  json[@"code"];
        if([code integerValue] == 10000){
            id result = json[@"results"];
            resultBlock(result,nil);
        }
        else{
            NSError * error = [self errorWithJSON:json];
            resultBlock(nil,error);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError * networkerror= [self networkError];
        resultBlock(nil,networkerror);
    }];
    
}

+(NSString *)errorDesc:(NSError *)error{
     return error.userInfo[@"message"];
}
+(NSError *)networkError {
    NSDictionary *dict = nil;
    NSString *domain = nil;
    dict = @{@"message": @"网络异常，请稍后重试！"};
    domain = @"com.wpf.finance";
    return [NSError errorWithDomain:domain code:404 userInfo:dict];
}
+(NSError *)errorWithJSON:(NSDictionary *)json {
    NSDictionary *dict = nil;
    NSString *domain = nil;
    NSString *errorCode = json[@"errorCode"];
    dict = @{@"message": json[@"msg"] ?: @""};
    domain = @"com.wpf.finance";
    return [NSError errorWithDomain:domain code:[errorCode integerValue] userInfo:dict];
}



@end
