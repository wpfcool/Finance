//
//  FIHomeData.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIHomeData.h"

@implementation FIHomeData
-(void)setDramSeed:(NSString *)dramSeed{
    NSString * tmp = [NSString stringWithFormat:@"%.2f",dramSeed.doubleValue];
    _dramSeed = tmp;
}
-(void)setBonusSeed:(NSString *)bonusSeed{
    NSString * tmp = [NSString stringWithFormat:@"%.2f",bonusSeed.doubleValue];
    _bonusSeed = tmp;
}
-(void)setSum:(NSString *)sum{
    NSString * tmp = [NSString stringWithFormat:@"%.2f",sum.doubleValue];
    _sum = tmp;
}
@end
