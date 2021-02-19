//
//  DEBaseNavigationController.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEBaseNavigationController.h"
#import "UIImage+AGExtension.h"
#import "UIColor+TVBExtension.h"

NSString *const kNavigationWillPushNotificationName = @"NavigationWillPushNotificationName";

@interface DEBaseNavigationController ()

@end

@implementation DEBaseNavigationController

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if (@available(iOS 13.0, *)) {
            self.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    
    
    UIImage *backImage = [UIImage imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(10, 10)];
    
    UINavigationBar *navbar = [UINavigationBar appearance];
    [self.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor HEX:0xefefef] andSize:CGSizeMake(10, 0.5)]];
    //
    [navbar setTintColor:[UIColor HEX:0x222222]];
    //
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    navbar.backIndicatorImage = [UIImage imageNamed:@"return"];
    navbar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"return"];
    //
    
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    //字体颜色
    UIColor *color = [UIColor HEX:0x222222];

    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    navbar.titleTextAttributes = dict;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0]};
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //设置返回文字为空
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    NSArray *childViewControllers = self.childViewControllers;
    
    if (childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNavigationWillPushNotificationName object:nil];
    
    [super pushViewController:viewController animated:animated];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController * vc = [super popViewControllerAnimated:animated];
    if ([vc respondsToSelector:@selector(removeAllView)]) {
        [vc performSelector:@selector(removeAllView)];
    }
    return vc;
}


 //支持旋转
 -(BOOL)shouldAutorotate{
     return [self.topViewController shouldAutorotate];
 }

 //支持的方向
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
     return [self.topViewController supportedInterfaceOrientations];
 }

@end

