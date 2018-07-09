//
//  FIOrderTabView.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderTabView.h"

@implementation FIOrderTabView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.waiting_matchControl addTarget:self action:@selector(waiting:) forControlEvents:UIControlEventTouchUpInside];
    [self.waiting_payControl addTarget:self action:@selector(waiting:) forControlEvents:UIControlEventTouchUpInside];
    [self.waiting_confirmControl addTarget:self action:@selector(waiting:) forControlEvents:UIControlEventTouchUpInside];
    [self.waiting_envalteControl addTarget:self action:@selector(waiting:) forControlEvents:UIControlEventTouchUpInside];
    self.currentIndex = 0;
}


-(void)setCurrentIndex:(NSInteger)currentIndex{
    self.waiting_matchLabel.font = [UIFont systemFontOfSize:13];
    self.waiting_payLabel.font = [UIFont systemFontOfSize:13];
    self.waiting_confirmLabel.font = [UIFont systemFontOfSize:13];
    self.waiting_envateLabel.font = [UIFont systemFontOfSize:13];

    switch (currentIndex) {
        case 0:
            self.waiting_matchLabel.font = [UIFont boldSystemFontOfSize:13];
            break;
            
        case 1:
            self.waiting_payLabel.font = [UIFont boldSystemFontOfSize:13];

            break;
        case 2:
            self.waiting_confirmLabel.font = [UIFont boldSystemFontOfSize:13];

            break;
        case 3:
            self.waiting_envateLabel.font = [UIFont boldSystemFontOfSize:13];

            break;
        default:
            break;
    }
}

-(void)waiting:(UIControl *)control{
    NSInteger tag = control.tag - 100;
    self.currentIndex = tag;
    if(_delegate && [_delegate respondsToSelector:@selector(didSelectControlAtIndex:)]){
        [_delegate didSelectControlAtIndex:tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
