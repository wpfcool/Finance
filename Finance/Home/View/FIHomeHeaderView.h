//
//  FIHomeHeaderView.h
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FIHomeHeaderViewDelegate<NSObject>
-(void)headerOneClick;
-(void)headerTwoClick;
-(void)headerThreeClick;

@end;

@interface FIHomeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dreamMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bonusMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLabel;
@property (weak,nonatomic)id<FIHomeHeaderViewDelegate>delegate;
@end
