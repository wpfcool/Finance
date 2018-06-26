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

//首页
#define HOME_URL HOST "api/user/index"

//  财务中心
#define FINANCE_CENTER_URL HOST  "api/user/income"
//我的团队
#define MY_TEAM_URL HOST  "api/team/index"
//我的领导
#define MY_LEADER_URL HOST "api/user/myleader"

//激活码个数
#define ACTIVIE_NUM_URL HOST "api/code/getcode"
//激活
#define ACTIVIE_URL HOST "api/code/codeuser"
//周期播种次数
#define TIME_SEED_COUNT_URL HOST  "api/user/num"
//买入种子
#define BUY_SEED_URL HOST  "api/pay/buy"
//卖出种子
#define SELL_SEED_URL HOST  "api/pay/sell"

#endif /* API_h */
