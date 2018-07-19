//
//  FIHomeOrderViewCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIHomeOrderViewCell.h"
#import "FIBadgeView.h"
@interface FIHomeOrderViewCell()
@property (weak, nonatomic) IBOutlet FIBadgeView *macthBadge;
@property (weak, nonatomic) IBOutlet FIBadgeView *fukuanBadge;
@property (weak, nonatomic) IBOutlet FIBadgeView *confirmBadge;
@property (nonatomic,strong)FIHomeData * homeData;

@property (weak, nonatomic) IBOutlet FIBadgeView *pingjiaBadge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pipeiWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fukunWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pingjiaWidth;

@end

@implementation FIHomeOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _macthBadge.hidden = YES;
    _fukuanBadge.hidden = YES;
    _confirmBadge.hidden = YES;
    _pingjiaBadge.hidden = YES;

}

-(void)setHomeData:(FIHomeData *)homeData type:(NSInteger)type{
    _homeData = homeData;
    _macthBadge.hidden = YES;
    _fukuanBadge.hidden = YES;
    _confirmBadge.hidden = YES;
    _pingjiaBadge.hidden = YES;
    if(type == 1){
        //买入订单
        if(_homeData.b1.integerValue !=0){
            _macthBadge.hidden = NO;
            _macthBadge.badge = _homeData.b1.integerValue;
        }
        if(_homeData.b2.integerValue !=0){
            _fukuanBadge.hidden = NO;
            _fukuanBadge.badge = _homeData.b2.integerValue;
        }
        if(_homeData.b3.integerValue !=0){
            _confirmBadge.hidden = NO;
            _confirmBadge.badge = _homeData.b3.integerValue;
        }
        if(_homeData.b4.integerValue !=0){
            _pingjiaBadge.hidden = NO;
            _pingjiaBadge.badge = _homeData.b4.integerValue;
        }
        
        if(homeData.b1.length > 1){
            self.pipeiWidth.constant = 20;
        }else{
            self.pipeiWidth.constant = 14;
        }
        
        
        if(homeData.b2.length > 1){
            self.fukunWidth.constant = 20;
        }else{
            self.fukunWidth.constant = 14;
        }
        
        
        if(homeData.b3.length > 1){
            self.confirmWidth.constant = 20;
        }else{
            self.confirmWidth.constant = 14;
        }
        
        
        if(homeData.b4.length > 1){
            self.pingjiaWidth.constant = 20;
        }else{
            self.pingjiaWidth.constant = 14;
        }


    }
    else if(type ==2){
        if(_homeData.s1.integerValue !=0){
            _macthBadge.hidden = NO;
            _macthBadge.badge = _homeData.s1.integerValue;
        }
        if(_homeData.s2.integerValue !=0){
            _fukuanBadge.hidden = NO;
            _fukuanBadge.badge = _homeData.s2.integerValue;
        }
        if(_homeData.s3.integerValue !=0){
            _confirmBadge.hidden = NO;
            _confirmBadge.badge = _homeData.s3.integerValue;
        }
        if(_homeData.s4.integerValue !=0){
            _pingjiaBadge.hidden = NO;
            _pingjiaBadge.badge = _homeData.s4.integerValue;
        }
        
        
        if(homeData.s1.length > 1){
            self.pipeiWidth.constant = 20;
        }else{
            self.pipeiWidth.constant = 14;
        }
        
        
        if(homeData.s2.length > 1){
            self.fukunWidth.constant = 20;
        }else{
            self.fukunWidth.constant = 14;
        }
        
        
        if(homeData.s3.length > 1){
            self.confirmWidth.constant = 20;
        }else{
            self.confirmWidth.constant = 14;
        }
        
        
        if(homeData.s4.length > 1){
            self.pingjiaWidth.constant = 20;
        }else{
            self.pingjiaWidth.constant = 14;
        }


    }
    
}

- (IBAction)matchClick:(id)sender {
    [_delegate waitingMatchClick:self];
}
- (IBAction)payClick:(id)sender {
    [_delegate waitingPayClick:self];
}
- (IBAction)confirmCLick:(id)sender {
    [_delegate waitingConfirmClick:self];
}
- (IBAction)pingjiaCLick:(id)sender {
    [_delegate waitingAppraise:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
