//
//  FIBaseTableViewCell.m
//  Finance
//
//  Created by wenpeifang on 2018/7/19.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation FIBaseTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];

}

-(void)initUI
{
    _lineVew = [[UIView alloc]init];
    _lineVew.backgroundColor = HEX_UICOLOR(0xe7e7e7, 1);
    [self.contentView addSubview:_lineVew];
    _lineVew.hidden = YES;
    [_lineVew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@0.5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
