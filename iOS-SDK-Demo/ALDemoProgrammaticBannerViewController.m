//
//  ALDemoProgrammaticBannerViewController.m
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/3/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

#import "ALDemoProgrammaticBannerViewController.h"
#import "ALSdk.h"
#import "ALAdView.h"
#import "YourSDKKey.h"

@interface ALDemoProgrammaticBannerViewController ()
@property (strong, nonatomic) ALAdView* bannerView;
@end

@implementation ALDemoProgrammaticBannerViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: Add your own SDK key into YourSDKKey.h.
    self.sdkKey = APPLOVIN_SDK_KEY;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [self createBanner];
}

-(void) createBanner
{
    ALSdk* sdk = [ALSdk sharedWithKey: self.sdkKey];
    ALAdSize* banner = [ALAdSize sizeBanner];
    
    NSUInteger heightOffset = self.view.frame.origin.y + 100;
    
    CGRect frame = CGRectMake(0, heightOffset, 320, 50);
    
    /* 320x50 is the standard banner size, though our banners will work
     at wider sizes - so feel free to pin it with autolayout to the leading/trailing
     space of its parent view. */
    
    self.bannerView = [[ALAdView alloc] initWithFrame: frame size: banner sdk: sdk];
    [self.bannerView loadNextAd];
    
    [self.view addSubview: self.bannerView];
    [self.view bringSubviewToFront: self.bannerView];
}

-(void) loadNextBanner: (id) sender
{
    // This may or may not do anything depending on the refresh settings you've set on the AppLovin.com UI.
    // (Check the "Manage Apps" section to fiddle with the behavior.)
    [self.bannerView loadNextAd];
}

@end
