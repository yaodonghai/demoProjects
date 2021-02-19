//
//  DEHomePageViewController.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEHomePageViewController.h"
#import "testNetWorkViewController.h"
#import "testIjkplayerControllerViewController.h"
#import "DEVideoViewController.h"

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
  
    NSString *playUrl = @"http://qiniuvip.mddcloud.com.cn:80/J015798/HLS/master_playlist_20200812192917070790.m3u8?sign=20c6ec0df3ccecae956f3771a84df11f&t=602fa0a5&sctid=ff80808173e704ba0173fbe270b7168b&cat=184111d429685e632595cb420bed74e33ba2470607&dd=202102191627&rnd=9450";
    NSURL *URl =  [NSURL URLWithString:playUrl];
    
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        DEVideoViewController *vc = [[DEVideoViewController alloc]init];
        vc.url = URl;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
}


@end
