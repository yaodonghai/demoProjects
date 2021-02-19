//
//  DEVideoViewController.h
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEBaseViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@class IJKMediaControl;

NS_ASSUME_NONNULL_BEGIN

@interface DEVideoViewController : DEBaseViewController

@property(atomic,strong) NSURL *url;
@property(atomic, strong) IJKFFMoviePlayerController *player;

@end

NS_ASSUME_NONNULL_END
