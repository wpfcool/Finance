//
//  API.h
//  Finance
//
//  Created by wenpeifang on 2018/6/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#ifndef API_h
#define API_h

#define HOST @"http://45.56.88.145:80/"

//登录
#define Login_URL HOST "api/login/login"
//注册接口
#define REGISTER_URL HOST "api/login/register"
//完善个人信息接口
#define INFO_URL HOST "api/login/info"


//获取手机验证码
#define SEND_IPHONE_CODE HOST "api/common/sendcode"
#endif /* API_h */
