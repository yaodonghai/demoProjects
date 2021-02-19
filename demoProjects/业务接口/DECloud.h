//
//  DECloud.h
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DECloudMethod) {
    DECloudMethodGET,
    DECloudMethodPOST,
    DECloudMethodPUT,
    DECloudMethodPATCH,
    DECloudMethodDELETE,
};


NS_ASSUME_NONNULL_BEGIN

@interface DECloud : NSObject

+ (AFHTTPSessionManager *)sharedSessionManager ;

+ (NSArray *)methods ;

@end

NS_ASSUME_NONNULL_END
