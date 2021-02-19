//
//  DEMainViewController.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEMainViewController.h"
#import "DEMainTabBarController.h"
#import "DEHomePageViewController.h"
#import "DEOtherPageViewController.h"
#import "DEBaseNavigationController.h"

@interface DEMainViewController ()

@property (nonatomic, strong) DEMainTabBarController *tabBarController;



@end

@implementation DEMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}


#pragma mark - UI 

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController = [DEMainTabBarController new];
    [self addViewFromController:self.tabBarController];
    [self createViewCtrollers];
}


- (void)createViewCtrollers{
    
    
    DEHomePageViewController *homeVc = [[DEHomePageViewController alloc]init];
    DEBaseNavigationController *homeNa = [[DEBaseNavigationController alloc]initWithRootViewController:homeVc];
    homeNa.tabBarItem.title= @"首页";

    
    DEOtherPageViewController *otherVc = [[DEOtherPageViewController alloc]init];
    DEBaseNavigationController *otherNa = [[DEBaseNavigationController alloc]initWithRootViewController:otherVc];
    otherNa.tabBarItem.title= @"其它";
    self.tabBarController.viewControllers = @[homeNa,otherNa];
    
}

#pragma mark - Private Method

//添加视图到控制器
- (void)addViewFromController:(UIViewController *)vc
{
    [self addChildViewController:vc];
    UIView *destView = vc.view;
    destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:destView atIndex:0];
    [vc didMoveToParentViewController:self];
}



@end
