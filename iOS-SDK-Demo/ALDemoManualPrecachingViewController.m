//
//  ALDemoManualPrecachingViewController.m
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/4/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

#import "ALDemoManualPrecachingViewController.h"
#import "ALSdk.h"
#import "ALAdService.h"
#import "ALAd.h"
#import "ALInterstitialAd.h"
#import "YourSDKKey.h"

@interface ALDemoManualPrecachingViewController () <ALAdLoadDelegate>
@property (strong, nonatomic) IBOutlet UILabel *adLoadStatus;
@property (strong, nonatomic) ALSdk* sdk;
@property (strong,    atomic) ALAd* lastLoadedAd;
@end

@implementation ALDemoManualPrecachingViewController

/* 
 This UIViewController demonstrates manually pre-caching and
 rendering ads. Note that the AppLovin SDK will attempt to do
 this for you using the standard integration demonstrated in
 ALDemoBannerViewController / ALDemoInterstitialViewController;
 taking manual control of the process is generally only recommended
 if you have a specific need to do so.
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sdk = [ALSdk sharedWithKey: APPLOVIN_SDK_KEY];
}

- (IBAction)precacheInterstitial:(id)sender
{
    self.adLoadStatus.text = @"Pre-loading an ad...";
    ALAdService* adService = self.sdk.adService;
    [adService loadNextAd: [ALAdSize sizeInterstitial] andNotify: self];
}

- (IBAction)showInterstitialIfAvailable:(id)sender
{
    // If an ad has been loaded...
    if(self.lastLoadedAd)
    {
        // Show an interstitial
        ALInterstitialAd* interstitial = [[ALInterstitialAd alloc] initInterstitialAdWithSdk: self.sdk];
        [interstitial showOver: [UIApplication sharedApplication].keyWindow andRender: self.lastLoadedAd];
        
        // Also, clear out this ad, since we've just used it.
        self.lastLoadedAd = nil;
        
        self.adLoadStatus.text = @"Showed an interstitial.";
    }
    else
    {
        self.adLoadStatus.text = @"No ad ready!";
    }
    
}

#pragma mark Ad Load Delegate implementation.

-(void) adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    self.adLoadStatus.text = @"Loaded an interstitial.";
    self.lastLoadedAd = ad;
}

-(void) adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    self.adLoadStatus.text = [NSString stringWithFormat: @"Failed to load: %d", code];
}

@end
