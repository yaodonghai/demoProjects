//
//  DEHomePageViewController.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEHomePageViewController.h"
#import "testNetWorkViewController.h"


@interface DEHomePageViewController ()

@end

@implementation DEHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUi];
    // Do any additional setup after loading the view.
}


- (void)initUi{
    
    [self addButton];
}


- (void)addButton{
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"next" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(0);
    }];
  
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        testNetWorkViewController *vc = [[testNetWorkViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
}


@end
