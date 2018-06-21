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
    _contentLabel = [[UILabel alloc]init];
    [self addSubview:_contentLabel];
}
-(void)setBadge:(NSInteger)badge{
    _badge = badge;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
