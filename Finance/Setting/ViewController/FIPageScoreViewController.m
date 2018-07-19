//
//  FIPageScoreViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/20.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPageScoreViewController.h"
#import "FIScoreListViewController.h"


@interface FIPageScoreViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic,strong)UIPageViewController * pageViewController;
@property (nonatomic,strong)NSMutableArray * childViewControllersArray;

@property (nonatomic,strong)UIView * lineView;
@end


@implementation FIPageScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  =@"信用评分记录";
    [self wr_setNavBarShadowImageHidden:YES];
    // Do any additional setup after loading the view.
    self.childViewControllersArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        FIScoreListViewController * vc = [[FIScoreListViewController alloc]init];
        vc.type = i;
        [self.childViewControllersArray addObject:vc];
    }
    //
    self.currentPage = self.index;
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"买入信用评分" forState:UIControlStateNormal];
    [button1 setTitleColor: [UIColor colorWithRed:93/255.0 green:136/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
    button1.tag = 100;
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0, [self navBarBottom], SCREEN_WIDTH/2.0, 40);
    button1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"买出信用评分" forState:UIControlStateNormal];
    button2.tag = 101;
    [button2 addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];

    [button2 setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:14];

    button2.frame = CGRectMake( SCREEN_WIDTH/2.0, [self navBarBottom], SCREEN_WIDTH/2.0, 40);
    button2.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:button2];
    
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0,  [self navBarBottom]+40, SCREEN_WIDTH/2.0, 2)];
    _lineView.backgroundColor = [UIColor colorWithRed:93/255.0 green:136/255.0 blue:219/255.0 alpha:1];
    [self.view addSubview:_lineView];
    
//    self.tabView = [[NSBundle mainBundle] loadNibNamed:@"FIOrderTabView" owner:nil options:nil][0];;
//    self.tabView.frame = CGRectMake(0, [self navBarBottom]+10 ,SCREEN_WIDTH, 70);
//    self.tabView.delegate = self;
//    [self.view addSubview:self.tabView];
//
//
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    self.pageViewController.view.frame = CGRectMake(0, [self navBarBottom]+42, SCREEN_WIDTH, SCREEN_HEIGHT - 42-[self navBarBottom]);
    UIViewController * vc = self.childViewControllersArray[self.currentPage];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}



-(void)tabClick:(UIButton *)btn{
    

    UIButton * btn1 = [self.view viewWithTag:100];
    UIButton * btn2 = [self.view viewWithTag:101];
    
    
    [btn1 setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];

    [btn setTitleColor: [UIColor colorWithRed:93/255.0 green:136/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
    NSInteger index = btn.tag - 100;
    if(index == 0){
        _lineView.frame=CGRectMake(0,  [self navBarBottom]+40, SCREEN_WIDTH/2.0, 2);

    }else if(index == 1){
        _lineView.frame=CGRectMake(SCREEN_WIDTH/2.0,  [self navBarBottom]+40, SCREEN_WIDTH/2.0, 2);

    }
    
    UIViewController * vc = self.childViewControllersArray[index];
    
    if(_currentPage > index){
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    else{
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    self.currentPage = index;
}


-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    NSInteger index = [self.childViewControllersArray indexOfObject:viewController];
//    self.tabView.currentIndex = index;
    UIButton * btn1 = [self.view viewWithTag:100];
    UIButton * btn2 = [self.view viewWithTag:101];
    [btn1 setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    if(index == 0){
        [btn1 setTitleColor: [UIColor colorWithRed:93/255.0 green:136/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
        _lineView.frame=CGRectMake(0,  [self navBarBottom]+40, SCREEN_WIDTH/2.0, 2);


    }else if(index == 1){
        [btn2 setTitleColor: [UIColor colorWithRed:93/255.0 green:136/255.0 blue:219/255.0 alpha:1] forState:UIControlStateNormal];
        _lineView.frame=CGRectMake(SCREEN_WIDTH/2.0,  [self navBarBottom]+40, SCREEN_WIDTH/2.0, 2);


    }

    
    


    
    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    
    NSInteger index = [self.childViewControllersArray indexOfObject:viewController];
    
    if (index == self.childViewControllersArray.count - 1 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index++;
    
    return [self.childViewControllersArray objectAtIndex:index];
    
    
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self.childViewControllersArray indexOfObject:viewController];
    
    if (index == 0 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    return [self.childViewControllersArray objectAtIndex:index];
    
    
}


-(void)didSelectControlAtIndex:(NSInteger)index{
    UIViewController * vc = self.childViewControllersArray[index];
    
    if(_currentPage > index){
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    else{
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    self.currentPage = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
