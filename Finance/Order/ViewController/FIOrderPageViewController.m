//
//  FIOrderPageViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderPageViewController.h"
#import "FIOrderTabView.h"
#import "FIOrderListViewController.h"
@interface FIOrderPageViewController ()<FIOrderTabViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic,strong)FIOrderTabView * tabView;
@property (nonatomic,strong)UIPageViewController * pageViewController;
@property (nonatomic,strong)NSMutableArray * childViewControllersArray;
@end

@implementation FIOrderPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.orderCataory == 1){
        self.navigationItem.title = @"买入订单";
    }else if(self.orderCataory == 2){
        self.navigationItem.title = @"卖出订单";
        
    }
    // Do any additional setup after loading the view.
    self.childViewControllersArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        FIOrderListViewController * vc = [[FIOrderListViewController alloc]init];
        vc.type = i;
        vc.orderCataory = self.orderCataory;
        [self.childViewControllersArray addObject:vc];
    }
//
    self.currentPage = self.index;
    
    self.tabView = [[NSBundle mainBundle] loadNibNamed:@"FIOrderTabView" owner:nil options:nil][0];;
    self.tabView.frame = CGRectMake(0, [self navBarBottom]+10 ,SCREEN_WIDTH, 70);
    self.tabView.delegate = self;
    [self.view addSubview:self.tabView];

    
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    self.pageViewController.view.frame = CGRectMake(0, [self navBarBottom]+80, SCREEN_WIDTH, SCREEN_HEIGHT - 80-[self navBarBottom]);
    UIViewController * vc = self.childViewControllersArray[self.currentPage];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.tabView.currentIndex = self.currentPage;
    
}


-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{

    
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    NSInteger index = [self.childViewControllersArray indexOfObject:viewController];
   self.tabView.currentIndex = index;
    
    
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
