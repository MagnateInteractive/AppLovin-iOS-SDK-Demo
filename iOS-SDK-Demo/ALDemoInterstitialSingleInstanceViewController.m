//
//  ALDemoInterstitialSingleInstanceViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoInterstitialSingleInstanceViewController.h"
#import "ALInterstitialAd.h"

@interface ALDemoInterstitialSingleInstanceViewController ()<ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@property (nonatomic, strong) ALInterstitialAd *interstitial;
@end

@implementation ALDemoInterstitialSingleInstanceViewController

#pragma mark - IB Action Methods

- (IBAction)showInterstitial:(id)sender
{
    if ( [ALInterstitialAd isReadyForDisplay] )
    {
        // Make it a class @property so it doesn't get dealloc'd by ARC
        self.interstitial = [[ALInterstitialAd alloc] initWithSdk: [ALSdk shared]]; // You can also explicitly enter sdk key so: [ALSdk sharedWithKey: @"YOUR KEY"] (i.e. if you have multiple keys)
    
        // Optional: Assign delegates.
        self.interstitial.adLoadDelegate = self;
        self.interstitial.adDisplayDelegate = self;
        self.interstitial.adVideoPlaybackDelegate = self; // This will only ever be used if you have video ads enabled.
        
        [self.interstitial show];
    }
    else
    {
        // Ideally, the SDK pre-loads ads when you initialize it in application:didFinishLaunchingWithOptions: of the app delegate
        [self loadInterstitial: nil];
    }
}

- (IBAction)loadInterstitial:(id)sender
{
    [[ALSdk shared].adService loadNextAd: [ALAdSize sizeInterstitial] andNotify: self];
}

#pragma mark - Ad Load Delegate

- (void)adService:(alnonnull ALAdService *)adService didLoadAd:(alnonnull ALAd *)ad
{
    [self log: @"Interstitial Loaded"];
}

- (void) adService:(alnonnull ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: [NSString stringWithFormat: @"Interstitial failed to load with error code = %d", code]];
}

#pragma mark - Ad Display Delegate

- (void)ad:(alnonnull ALAd *)ad wasDisplayedIn:(alnonnull UIView *)view
{
    [self log: @"Interstitial Displayed"];
}

- (void)ad:(alnonnull ALAd *)ad wasHiddenIn:(alnonnull UIView *)view
{
    [self log: @"Interstitial Dismissed"];
}

- (void)ad:(alnonnull ALAd *)ad wasClickedIn:(alnonnull UIView *)view
{
    [self log: @"Interstitial Clicked"];
}

#pragma mark - Ad Video Playback Delegate

- (void)videoPlaybackBeganInAd:(alnonnull ALAd *)ad
{
    [self log: @"Video Started"];
}

- (void)videoPlaybackEndedInAd:(alnonnull ALAd *)ad atPlaybackPercent:(alnonnull NSNumber *)percentPlayed fullyWatched:(BOOL)wasFullyWatched
{
    [self log: @"Video Ended"];
}

@end
