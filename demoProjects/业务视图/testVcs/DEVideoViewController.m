//
//  DEVideoViewController.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEVideoViewController.h"


@interface DEVideoViewController ()<IJKMediaNativeInvokeDelegate,IJKMediaUrlOpenDelegate>

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UIButton *pauseButton;

@property (nonatomic, strong) UIButton *switchcoderateButton;

@property (nonatomic, strong) UIButton *logButton;

@end

@implementation DEVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUi];
}


- (void)initUi{
    self.view.backgroundColor = [UIColor yellowColor];
    [self addPlayerButtons];
    [self setupPlayer];
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //code rate
   // [self.player prepareToPlay];

}

- (void)addPlayerButtons{
    
    
    CGSize buttonSize = CGSizeMake(80, 80.0);
    self.playButton = [[UIButton alloc]init];
    [self.playButton setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.playButton setTitle:@"play" forState:UIControlStateNormal];
    [self.view addSubview:self.playButton];
    
    
    self.pauseButton = [[UIButton alloc]init];
    [self.pauseButton setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [self.view addSubview:self.pauseButton];
    

    
    self.switchcoderateButton = [[UIButton alloc]init];
    [self.switchcoderateButton setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.switchcoderateButton setTitle:@"switch" forState:UIControlStateNormal];
    [self.view addSubview:self.switchcoderateButton];
    
    self.logButton = [[UIButton alloc]init];
    [self.logButton setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.logButton setTitle:@"log" forState:UIControlStateNormal];
    [self.view addSubview:self.logButton];
    
    
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(buttonSize);
        make.left.bottom.mas_equalTo(self.view);
    }];
    
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(buttonSize);
        make.bottom.mas_equalTo(self.view);
        make.left.equalTo(self.playButton.mas_right);
    }];
    
    
    [self.switchcoderateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(buttonSize);
        make.bottom.mas_equalTo(self.view);
        make.left.equalTo(self.pauseButton.mas_right);
    }];
    
    [self.logButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(buttonSize);
        make.bottom.mas_equalTo(self.view);
        make.left.equalTo(self.switchcoderateButton.mas_right);
    }];
    
    
    @weakify(self);
    [[self.playButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.player play];

    }];
    
    [[self.pauseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
       // [options setPlayerOptionIntValue:1      forKey:@"framedrop"];
                
        //IJKFFMonitor
       // NSInteger dropFrameRate = [self.player dropFrameRate];
       // - (void)setPlayerOptionIntValue:    (int64_t)value forKey:(NSString *)key;
      //  [self.player setPlayerOptionIntValue:1 forKey:@"framedrop"];
        //dropFrameRate
        [self.player pause];
    }];
    
    [[self.switchcoderateButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.player setPlayerOptionIntValue:1080    forKey:@"videotoolbox-max-frame-width"];

       // [self.player setPlayerOptionIntValue:0 forKey:@"framedrop"];
    }];
    
    [[self.logButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        IJKFFMonitor *monitor = self.player.monitor;


        NSLog(@"");
        
    }];
    
}



- (void)setupPlayer{
    
    [IJKFFMoviePlayerController checkIfFFmpegVersionMatch:YES];

    CGRect playerFrame = CGRectMake(0.0, 0.0, [DEUtilities portraitScreenWidth], (0.56*[DEUtilities portraitScreenWidth]));
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1080    forKey:@"videotoolbox-max-frame-width"];



    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:options];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = playerFrame;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = NO;
    self.view.autoresizesSubviews = YES;
    self.player.nativeInvokeDelegate = self;
    self.player.tcpOpenDelegate = self;
    self.player.segmentOpenDelegate = self;
    self.player.httpOpenDelegate = self;

//    @property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> segmentOpenDelegate;
//    @property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> tcpOpenDelegate;
//    @property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> httpOpenDelegate;
//    @property (nonatomic, retain) id<IJKMediaUrlOpenDelegate> liveOpenDelegate;
//
    
    [self.view addSubview:self.player.view];
    [self.player prepareToPlay];

}

#pragma mark -  IJKMediaNativeInvokeDelegate


- (int)invoke:(IJKMediaEvent)event attributes:(NSDictionary *)attributes{
    
    if (attributes) {
        NSString *json = [attributes jsonString];
        //NSLog(@"invoke----|%@|",json);
    }
    return 1;
}

#pragma mark -  IJKMediaUrlOpenDelegate

- (void)willOpenUrl:(IJKMediaUrlOpenData*) urlOpenData{
    
   // NSLog(@"urlOpenData--segmentIndex--|%d|",urlOpenData.segmentIndex);

    //segmentIndex
}

@end
