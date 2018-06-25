//
//  FITeam.h
//  Finance
//
//  Created by wenpeifang on 2018/6/22.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITeam : NSObject
@property (nonatomic,copy)NSString *teamNum;
@property (nonatomic,copy)NSString *leader;
@end

@interface FILeader : NSObject
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *user_image;
@property (nonatomic,copy)NSString *trueName;
@property (nonatomic,copy)NSString *phone;

@end
