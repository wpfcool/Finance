//
//  FIBaseViewController.h
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RequestMethod) {
    GET = 0,
    POST
};
@interface FIBaseViewController : UIViewController

@property (nonatomic,strong)UIImageView * emptyImageView;
@property (nonatomic,strong)UILabel * emptyLabel;


- (void)asyncSendRequestWithURL:(NSString *)url param:(NSDictionary*)param RequestMethod:(RequestMethod)method showHUD:(BOOL)showHUD result:(void(^)(id dic,NSError*error))resultBlock;

-(void)showAlert:(NSString *)message;

- (int)navBarBottom;

-(void)emptyViewShow;
-(void)emptyViewHidden;
-(void)showHUD;
-(void)hiddenHUD;
@end
