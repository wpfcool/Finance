//
//  FIHomeHeaderView.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIHomeHeaderView.h"

@implementation FIHomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)dreamClick:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(headerOneClick)]){
        [_delegate headerOneClick];
    }
}
- (IBAction)priceClick:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(headerTwoClick) ]){
        [_delegate headerTwoClick];
    }
}

- (IBAction)thirdClick:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(headerThreeClick) ]){
        [_delegate headerThreeClick];
    }
}
@end
