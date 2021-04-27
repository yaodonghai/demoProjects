//
//  testNetWorkViewController.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "testNetWorkViewController.h"
#import "DECloud.h"
#import <Foundation/Foundation.h>
#import <MyFrameWork/MyTool.h>

@interface testNetWorkViewController ()

@end

@implementation testNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestJson];
}


- (void)requestJson{
    MyTool *tool = [[MyTool alloc]init];
    NSInteger numiber = [tool statisticalSum:2 addNumber:3];
    
    NSLog(@"numiber------|%ld|",numiber);
    
    NSMutableURLRequest *req = nil;
    
    NSError *error = nil;
    //http://www.tianqiapi.com/api?version=v9&appid=14472854&appsecret=uHMIF5Ap
    NSDictionary *param = @{};
//https://www.juhe.cn/box/newtest
    NSString *url = @"http://www.tianqiapi.com/api?version=v9&appid=14472854&appsecret=uHMIF5Ap";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
    //requesttypesel=GET&apiid=1214&params=%7B%7D
    req = [[AFHTTPRequestSerializer serializer] requestWithMethod:[DECloud methods][DECloudMethodGET] URLString:url parameters:nil error:&error];

   // req = [[AFJSONRequestSerializer serializer] requestWithMethod:[DECloud methods][DECloudMethodPOST] URLString:url parameters:param error:&error];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   // [req setHTTPBody:jsonData];
    
    AFHTTPSessionManager *manager = [DECloud sharedSessionManager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 50;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    __block  NSURLSessionDataTask *task = [manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (responseObject) {
           
        }
        else {
            if (error) {
             
            }
        }
        
    }];
    [task resume];
}



@end
