//
//  FIOrderTabView.h
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FIOrderTabViewDelegate<NSObject>
-(void)didSelectControlAtIndex:(NSInteger)index;
@end


@interface FIOrderTabView : UIView
@property (weak, nonatomic) IBOutlet UIControl *waiting_matchControl;
@property (weak, nonatomic) IBOutlet UIControl *waiting_payControl;
@property (weak, nonatomic) IBOutlet UIControl *waiting_confirmControl;
@property (weak, nonatomic) IBOutlet UIControl *waiting_envalteControl;
@property (weak, nonatomic) IBOutlet UILabel *waiting_matchLabel;
@property (weak, nonatomic) IBOutlet UILabel *waiting_payLabel;
@property (weak, nonatomic) IBOutlet UILabel *waiting_confirmLabel;
@property (weak, nonatomic) IBOutlet UILabel *waiting_envateLabel;
@property (weak, nonatomic) id<FIOrderTabViewDelegate>delegate;
@property (nonatomic,assign)NSInteger currentIndex;
@end
