//
//  WFEncrypt.h
//  Finance
//
//  Created by wenpeifang on 2018/6/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
@interface WFEncrypt : NSObject
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;
+(NSString *)md5:(NSString *)plainText;

@end
