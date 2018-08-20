//
//  BCMember.h
//  Finance
//
//  Created by wenpeifang on 2018/8/20.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCMember : NSObject
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *trueName;

@property (nonatomic,copy)NSString *bankCard;

@property (nonatomic,copy)NSString *alipayNum;
@property (nonatomic,copy)NSString *phone;


//            "username": "aini1234",
//            "trueName": "王春生",
//            "bankCard": "6217003170006641007",
//            "alipayNum": null,
//            "phone": "17191586529"
@end
