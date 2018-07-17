//
//  FIAccountCardView.m
//  Finance
//
//  Created by wenpeifang on 2018/7/4.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIAccountCardView.h"
#import <Masonry/Masonry.h>
@implementation FIAccountCardView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initialUI];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initialUI];
    }
    return self;
}

-(void)initialUI{
    
    self.layer.cornerRadius = 10;
    [self setClipsToBounds:YES];
    CAGradientLayer * layer = [CAGradientLayer layer];
    layer.colors = @[(id)HEX_UICOLOR(0xF0CD5C, 1).CGColor,(id)HEX_UICOLOR(0xF88C3F, 1).CGColor];
    layer.locations = @[@0,@1];
    layer.frame= CGRectMake(0, 0, SCREEN_WIDTH - 40, 130);
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint   = CGPointMake(1, 0);
    [self.layer addSublayer:layer];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:17];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
//    _typeLabel = [[UILabel alloc]init];
//    _typeLabel.font = [UIFont systemFontOfSize:14];
//    _typeLabel.textColor = [UIColor whiteColor];
//    [self addSubview:_typeLabel];
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.font = [UIFont systemFontOfSize:14];
    _numberLabel.textColor = [UIColor whiteColor];
    [self addSubview:_numberLabel];
    
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(40);
//        make.top.equalTo(self.mas_top).offset(22);
        make.bottom.equalTo(self.mas_centerY).offset(-5);
    }];
//    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(40);
//        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
//    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(40);
        make.top.equalTo(self.mas_centerY).offset(5);
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
