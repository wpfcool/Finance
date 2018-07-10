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
//#define INFO_URL HOST "api/login/info"

#define FORGETPASS_URL HOST "api/login/forgetpwd"
#define RESETPASS_URL HOST  "api/login/resetpwd"
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
//用户信息
#define USER_INFO_URL HOST  "api/user/detail"
//查询道具数量
#define PROP_NUM_URL HOST  "api/user/queryprop"

//修改手机号接口
#define ALTERPHONE_URL HOST "api/user/rephone"
//获得道具列表
#define PROPList_URL HOST "api/shop/index"
//购买道具
#define BUY_PROP_URL HOST "api/shop/buyprop"
//修改真实姓名
#define ALTER_REALNAME_URL HOST "api/user/rename"
//获得银行卡列表
#define BANKLIST_URL HOST "api/user/getbank"
// 修改昵称
#define ALTER_NICKNAME_URL HOST "api/user/renickname"
//获得支付宝账号
#define GET_ALIYPAY_URL HOST "api/user/getalipay"

//add支付宝账号
#define ADD_ALIYPAY_URL HOST "api/user/realipay"
//银行账号修改
#define ADD_BANK_URL HOST  "api/user/bankuser"
//修改登录密码
 #define ALTER_LOGINPASS_URL HOST "api/user/repassword"

//修改安全密码
#define ALTER_SAFEPASS_URL HOST "api/user/resafe"
//评分列表
#define SCORELIST_URL HOST  "api/credit/index"
//转赠激活码
#define GAVECODE_URL HOST  "api/code/gift"
//订单列表
#define ORDERLIST_URL HOST  "api/order/orderlist"
//确认付款
#define CONFIRMPAY_URL HOST  "api/order/confirm"
//获得订单手机号
#define ORDERPHONE_URL HOST  "api/order/getorderphone"
//投诉
#define COMPLAIN_URL HOST  "api/order/lodge"
//
//评价
#define PingjaURL HOST  "api/order/score"
//上传凭证
#define UPLOADPINGZHENGURL HOST "api/order/payment"
#endif /* API_h */
