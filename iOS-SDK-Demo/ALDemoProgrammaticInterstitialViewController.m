//
//  ALDemoProgrammaticInterstitialViewController.m
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/4/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

#import "ALDemoProgrammaticInterstitialViewController.h"
#import "ALInterstitialAd.h"
#import "YourSDKKey.h"

@interface ALDemoProgrammaticInterstitialViewController ()

@end

@implementation ALDemoProgrammaticInterstitialViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: Add your own SDK key into YourSDKKey.h.
    self.sdkKey = APPLOVIN_SDK_KEY;
}

-(IBAction) loadNextInterstitials: (id) sender
{
    ALSdk* sdk = [ALSdk sharedWithKey: self.sdkKey];
    ALInterstitialAd* inter = [[ALInterstitialAd alloc] initInterstitialAdWithSdk: sdk];
    
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [inter showOver: keyWindow];
}

@end
