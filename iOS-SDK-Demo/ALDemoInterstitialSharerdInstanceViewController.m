//
//  ALDemoInterstitialSharerdInstanceViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoInterstitialSharerdInstanceViewController.h"
#import "ALInterstitialAd.h"

@interface ALDemoInterstitialSharerdInstanceViewController ()<ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@end

@implementation ALDemoInterstitialSharerdInstanceViewController

#pragma mark - IB Action Methods

- (IBAction)showInterstitial:(id)sender
{
    if ( [ALInterstitialAd isReadyForDisplay] )
    {
        // Optional: Assign delegates.
        [ALInterstitialAd shared].adLoadDelegate = self;
        [ALInterstitialAd shared].adDisplayDelegate = self;
        [ALInterstitialAd shared].adVideoPlaybackDelegate = self; // This will only ever be used if you have video ads enabled.
        
        [[ALInterstitialAd shared] show];
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
