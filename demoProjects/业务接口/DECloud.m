//
//  DECloud.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DECloud.h"

@implementation DECloud


+ (AFHTTPSessionManager *)sharedSessionManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPMaximumConnectionsPerHost = 20;
        manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        
    });
    return manager;
}



+ (NSArray *)methods {
    static NSArray *methods;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        methods = @[
                    @"GET",
                    @"POST",
                    @"PUT",
                    @"PATCH",
                    @"DELETE"
                    ];
    });
    return methods;
}

@end
