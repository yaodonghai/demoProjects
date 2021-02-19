//
//  DEBaseNavigationController.h
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import <UIKit/UIKit.h>

extern NSString *const kNavigationWillPushNotificationName;

NS_ASSUME_NONNULL_BEGIN

@interface DEBaseNavigationController : UINavigationController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;


@end

NS_ASSUME_NONNULL_END
