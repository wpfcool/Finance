//
//  FIOrderListCell.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderListCell.h"
#import <Masonry/Masonry.h>
@interface FIOrderListCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *pcsLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@property (weak, nonatomic) IBOutlet UILabel *middLabel;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@end
@implementation FIOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setOrderData:(FIOrderData *)orderData{
    _orderData = orderData;
    self.orderNoLabel.text = orderData.orderNo;
    self.orderPriceLabel.text = [NSString stringWithFormat:@"¥%@",orderData.price];
    self.pcsLabel.text = [NSString stringWithFormat:@"%@  pcs",orderData.number];
    
    self.timeLabel.text = [self getTime:orderData.pay_time];
}

-(void)setOrderType:(OrderType)orderType{
    _orderType = orderType;
    
    if(orderType & OrderTypeWaitingMatch){
        self.heightConstraint.constant = 125;
        self.timeView.hidden = YES;
        self.buttonView.hidden = YES;
        self.topLabel.hidden = YES;
        self.bottomLabel.hidden = YES;
        self.middLabel.hidden = NO;
        self.middLabel.text = [NSString stringWithFormat:@"下单时间:%@",[self getDate:self.orderData.add_time]];
    }
    else if(orderType & OrderTypeWaitingPay){
        //买入订单下的代付款
        self.heightConstraint.constant = 155;
        self.timeView.hidden = NO;
        self.buttonView.hidden = NO;
        self.middLabelHeightConstraint.constant = 0;
        self.middLabel.hidden = YES;
        self.topLabel.hidden = NO;
        self.bottomLabel.hidden = NO;
        self.topLabel.text = [NSString stringWithFormat:@"匹配时间:%@",[self getDate:self.orderData.app_time]];
        if(orderType&OrderTypeBuy){
          //  添加联系会员及上传付款凭证按钮
            self.bottomLabel.text = [NSString stringWithFormat:@"卖方会员:%@",self.orderData.seller_name];
            [self addMemberAndPinghzengButton];
        }else if(orderType & OrderTypeSell){
            //  添加联系会员按钮
            [self addMemberButton];
            self.bottomLabel.text = [NSString stringWithFormat:@"买方会员:%@",self.orderData.buy_name];

        }
        
    }else if(orderType&OrderTypeWaitingConfirm){
        
        self.heightConstraint.constant = 155;
        self.timeView.hidden = NO;
        self.buttonView.hidden = NO;
        self.topLabel.hidden = NO;
   
        if(orderType&OrderTypeBuy){
            self.middLabel.hidden = YES;
            self.middLabelHeightConstraint.constant = 0;
            self.topLabel.text = [NSString stringWithFormat:@"付款时间:%@",[self getDate:self.orderData.app_time]];
            self.bottomLabel.text = [NSString stringWithFormat:@"卖方会员:%@",self.orderData.seller_name];
            
            //  添加联系会员及催确认按钮
            [self addMemberAndTuikuanButton];
        }else if(orderType & OrderTypeSell){
            self.middLabel.hidden = NO;
            self.middLabelHeightConstraint.constant = 15;
            self.topLabel.text = [NSString stringWithFormat:@"申请时间:%@",[self getDate:self.orderData.app_time]];
            self.middLabel.text = [NSString stringWithFormat:@"付款时间:%@",[self getDate:self.orderData.app_time]];
            self.bottomLabel.text = [NSString stringWithFormat:@"买方会员:%@",self.orderData.buy_name];
            
            //  添加联系会员按钮 投我要诉 确认收款
            [self addMemberTouSuConfirmButton];
        }
    }else if(orderType&OrderTypeWaitingPingjia){
        self.heightConstraint.constant = 155;
        self.timeView.hidden = YES;
        self.buttonView.hidden = NO;
        self.topLabel.hidden = YES;
        self.bottomLabel.hidden = YES;
        self.middLabel.hidden = NO;
        if(orderType&OrderTypeBuy){
            self.middLabel.text = [NSString stringWithFormat:@"卖方会员:%@",self.orderData.seller_name];
        }else if(orderType & OrderTypeSell){
            self.middLabel.text = [NSString stringWithFormat:@"买方会员:%@",self.orderData.buy_name];

        }
        //  添加评价按钮
        [self addPingjiaButton];
    }
    
}

-(void)removeViewFormButtonView{
    for (UIButton  * btn in self.buttonView.subviews) {
        [btn removeFromSuperview];
    }
}
-(UIButton *)blueButton{
    UIButton * blueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [blueButton setTitleColor:HEX_UICOLOR(0xF82F9, 1) forState:UIControlStateNormal];
    blueButton.layer.cornerRadius = 12;
    blueButton.layer.borderWidth = 1;
    blueButton.titleLabel.font = [UIFont systemFontOfSize:11];
    blueButton.layer.borderColor = HEX_UICOLOR(0xF82F9, 1).CGColor;
    return blueButton;
}

-(UIButton *)grayButton{
    UIButton * contactMember = [UIButton buttonWithType:UIButtonTypeCustom];
    [contactMember setTitleColor:HEX_UICOLOR(0x999999, 1) forState:UIControlStateNormal];
    contactMember.layer.cornerRadius = 12;
    contactMember.layer.borderWidth = 1;
    contactMember.titleLabel.font = [UIFont systemFontOfSize:11];
    contactMember.layer.borderColor = HEX_UICOLOR(0x999999, 1).CGColor;
    return contactMember;
}
-(void)addPingjiaButton{
    [self removeViewFormButtonView];
    UIButton * btn = [self grayButton];
    [btn setTitle:@"评价" forState:UIControlStateNormal];
    [btn addTarget:self
                  action:@selector(pingjiaClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buttonView);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
    
}
-(void)addMemberTouSuConfirmButton{
    [self removeViewFormButtonView];
    UIButton *buttontmp =[self blueButton];
    [buttontmp setTitle:@"确认收款" forState:UIControlStateNormal];
    [buttontmp addTarget:self
                  action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:buttontmp];
    
    [buttontmp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buttonView);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
    
    UIButton * toushu = [self grayButton];
    if([self.orderData.is_lodge integerValue] == 1){
        [toushu setTitle:@"我要投诉" forState:UIControlStateNormal];
        [toushu addTarget:self
                   action:@selector(tousuClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [toushu setTitle:@"已投诉" forState:UIControlStateNormal];
    }
    

    [self.buttonView addSubview:toushu];

    [toushu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buttontmp.mas_left).offset(-10);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
    UIButton * concact = [self grayButton];
    [concact setTitle:@"联系会员" forState:UIControlStateNormal];
    [concact addTarget:self
                      action:@selector(contactMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:concact];
    
    [concact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toushu.mas_left).offset(-10);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
    
}


-(void)addMemberAndTuikuanButton{
    [self removeViewFormButtonView];
    
    UIButton *buttontmp = [self blueButton];
    [buttontmp setTitle:@"催确认" forState:UIControlStateNormal];
    [buttontmp addTarget:self
                        action:@selector(cuiConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
    buttontmp.layer.borderColor = HEX_UICOLOR(0xF82F9, 1).CGColor;
    [self.buttonView addSubview:buttontmp];
    
    [buttontmp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buttonView);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
    
    UIButton * contactMember=[self grayButton];
    [contactMember setTitle:@"联系会员" forState:UIControlStateNormal];
    [contactMember addTarget:self
                      action:@selector(contactMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:contactMember];
    [contactMember mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buttontmp.mas_left).offset(-10);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
    
}
-(void)addMemberButton{
    
    UIButton * contactMember=[self grayButton];
    [contactMember setTitle:@"联系会员" forState:UIControlStateNormal];
    [contactMember addTarget:self
                      action:@selector(contactMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:contactMember];
    [contactMember mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buttonView);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
}
-(void)addMemberAndPinghzengButton{
    [self removeViewFormButtonView];
    
    UIButton * pingzhengButton =[self blueButton];
    [pingzhengButton setTitle:@"上传付款凭证" forState:UIControlStateNormal];
    [pingzhengButton addTarget:self
                        action:@selector(pingzhengClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:pingzhengButton];
    
    [pingzhengButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buttonView);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@90);
        make.height.mas_equalTo(@24);
    }];
    
    UIButton * contactMember=[self grayButton];
    [contactMember setTitle:@"联系会员" forState:UIControlStateNormal];
    [contactMember addTarget:self
                      action:@selector(contactMember:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:contactMember];
    [contactMember mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pingzhengButton.mas_left).offset(-10);
        make.centerY.equalTo(self.buttonView);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@24);
    }];
}

-(NSString *)getDate:(NSString *)time{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
    NSDateFormatter * fommate = [[NSDateFormatter alloc]init];
    [fommate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [fommate stringFromDate:date];
}

-(NSString *)getTime:(NSString *)time{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
    NSDateFormatter * fommate = [[NSDateFormatter alloc]init];
    [fommate setDateFormat:@"hh:mm:ss"];
    return [fommate stringFromDate:date];
}


-(void)pingzhengClick:(id)sender{
    //上传凭证
    [_delegate uploadPingzheng:self.orderData.order_id];
}
-(void)contactMember:(id)sender{
    //联系会员
    [_delegate contactMemeber:self.orderData.order_id orderType:self.orderType];
}

-(void)cuiConfirmClick:(id)sender{
    //催确认
    [_delegate cuiConfirm:self.orderData.order_id];
}
-(void)confirmClick:(id)sender{
    //确认收款
    [_delegate confirmPay:self.orderData.order_id];
}
-(void)tousuClick:(id)sender{
    //投诉
//    [_delegate complain:self.orderData rderType:self.orderType];
    [_delegate complain:self.orderData orderType:self.orderType];
}
-(void)pingjiaClick:(id)sender{
    //评价
    [_delegate pingjia:self.orderData.order_id orderType:self.orderType];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
