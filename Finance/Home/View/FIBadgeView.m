//
//  FIBadgeView.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBadgeView.h"
#import <Masonry/Masonry.h>
@interface FIBadgeView()
@property (nonatomic,strong)UILabel * contentLabel;
@end
@implementation FIBadgeView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initUI];
    }
    return self;

}
-(void)initUI{
    self.layer.cornerRadius = 7;
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont systemFontOfSize:10];
    _contentLabel.textColor = [UIColor whiteColor];
    [self addSubview:_contentLabel];
    
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
-(void)setBadge:(NSInteger)badge{
    _badge = badge;
    _contentLabel.text = [NSString stringWithFormat:@"%@",@(_badge)];;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
