//
//  ALDemoInterstitialViewController.m
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/3/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

#import "ALDemoInterstitialViewController.h"
#import "ALInterstitialAd.h"

@interface ALDemoInterstitialViewController () <ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@property (strong, nonatomic) IBOutlet UILabel *adLoadStatus;
@end

@implementation ALDemoInterstitialViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    // Optional: Assign delegates.
    [ALInterstitialAd shared].adLoadDelegate = self;
    [ALInterstitialAd shared].adDisplayDelegate = self;
    
    // This will only ever be used if you have video ads enabled.
    [ALInterstitialAd shared].adVideoPlaybackDelegate = self;
}

-(IBAction)loadNextInterstitial:(id)sender
{
    [[ALInterstitialAd shared] showOver: [UIApplication sharedApplication].keyWindow];
}

-(void) logMessage: (NSString*) message
{
    self.adLoadStatus.text = message;
    NSLog(@"AppLovin SDK Demo >>>> %@", message);
}

#pragma mark AppLovin delegate implementation (Optional)

-(void) adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self logMessage: @"Interstitial loaded."];
}

-(void) adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    [self logMessage: @"Interstitial failed to load."];
}

-(void) ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self logMessage: @"Interstitial displayed."];
}

-(void) ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self logMessage: @"Interstitial clicked."];
}

-(void) ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self logMessage: @"Interstitial hidden."];
}

-(void) videoPlaybackBeganInAd:(ALAd *)ad
{
    [self logMessage: @"Interstitial began video."];
}

-(void) videoPlaybackEndedInAd:(ALAd *)ad atPlaybackPercent:(NSNumber *)percentPlayed fullyWatched:(BOOL)wasFullyWatched
{
    [self logMessage: @"Interstitial ended video."];
}

@end
