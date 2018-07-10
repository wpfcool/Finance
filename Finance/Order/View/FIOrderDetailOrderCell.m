//
//  FIOrderDetailOrderCell.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderDetailOrderCell.h"
@interface FIOrderDetailOrderCell()
@property (weak, nonatomic) IBOutlet UILabel *orederNOLabel;
@property (weak, nonatomic) IBOutlet UILabel *pcsLabel;
@property (weak, nonatomic) IBOutlet UILabel *macthLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@end
@implementation FIOrderDetailOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setOrderData:(FIOrderData *)orderData{
    _orderData = orderData;
    self.orederNOLabel.text = orderData.orderNo;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",orderData.price];
    self.pcsLabel.text = [NSString stringWithFormat:@"%@  pcs",orderData.number];
    self.macthLabel.text = [NSString stringWithFormat:@"%@",[self getDate:orderData.app_time]];
    self.userNameLabel.text = orderData.buy_name;
//    self.timeLabel.text = [self getTime:orderData.pay_time];
}
-(void)setOrderType:(OrderType)orderType{
    _orderType = orderType;
    _bottomButton.hidden = YES;

    if(_orderType & OrderTypeBuy){
        self.userNameTypeLabel.text = @"卖出会员";
        if(_orderType & OrderTypeWaitingPay){
            _bottomButton.hidden = NO;
            [_bottomButton setTitle:@"上传付款凭证" forState:UIControlStateNormal];
        }
        else if(_orderType & OrderTypeWaitingConfirm){
            _bottomButton.hidden = NO;
            [_bottomButton setTitle:@"催付款" forState:UIControlStateNormal];
        }
        
        
    }else if(_orderType & OrderTypeSell){
        self.userNameTypeLabel.text = @"买入会员";
        if(_orderType & OrderTypeWaitingConfirm){
            _bottomButton.hidden = NO;
            [_bottomButton setTitle:@"查看付款凭证" forState:UIControlStateNormal];
        }
        
    }

}

- (IBAction)buttonClick:(id)sender {
    
    if(_orderType & OrderTypeBuy){

        if(_orderType & OrderTypeWaitingPay){
            [_bottomButton setTitle:@"上传付款凭证" forState:UIControlStateNormal];
        }
        else if(_orderType & OrderTypeWaitingConfirm){
            [_bottomButton setTitle:@"催付款" forState:UIControlStateNormal];
        }
        
        
    }else if(_orderType & OrderTypeSell){
        if(_orderType & OrderTypeWaitingConfirm){
            [_bottomButton setTitle:@"查看付款凭证" forState:UIControlStateNormal];
        }
        
    }
}
-(NSString *)getDate:(NSString *)time{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
    NSDateFormatter * fommate = [[NSDateFormatter alloc]init];
    [fommate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [fommate stringFromDate:date];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
