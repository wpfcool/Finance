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

    self.waiting_matchLabel.textColor = HEX_UICOLOR(0x4A4A4A, 1);
    self.waiting_payLabel.textColor = HEX_UICOLOR(0x4A4A4A, 1);
    self.waiting_confirmLabel.textColor = HEX_UICOLOR(0x4A4A4A, 1);
    self.waiting_envateLabel.textColor = HEX_UICOLOR(0x4A4A4A, 1);

    switch (currentIndex) {
        case 0:
            self.waiting_matchLabel.textColor = HEX_UICOLOR(0x4C89FB, 1);
            break;
            
        case 1:
            self.waiting_payLabel.textColor = HEX_UICOLOR(0x4C89FB, 1);

            break;
        case 2:
            self.waiting_confirmLabel.textColor = HEX_UICOLOR(0x4C89FB, 1);

            break;
        case 3:
            self.waiting_envateLabel.textColor = HEX_UICOLOR(0x4C89FB, 1);

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
