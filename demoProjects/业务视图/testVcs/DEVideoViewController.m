//
//  DEVideoViewController.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEVideoViewController.h"


@interface DEVideoViewController ()

@end

@implementation DEVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)initUi{
    
}


- (void)setupPlayer{
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];

    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:options];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = self.view.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:self.player.view];
    }


@end
