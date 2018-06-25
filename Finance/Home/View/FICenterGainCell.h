//
//  FICenterGainCell.h
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FICenterGainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *buylabel;
@property (weak, nonatomic) IBOutlet UILabel *selloutLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitlabel;

@end
