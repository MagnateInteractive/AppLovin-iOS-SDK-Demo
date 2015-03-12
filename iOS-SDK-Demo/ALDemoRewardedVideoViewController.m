//
//  ALDemoRewardedVideoViewController.m
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/4/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

#import "ALDemoRewardedVideoViewController.h"
#import "ALIncentivizedInterstitialAd.h"
#import "ALAdRewardDelegate.h"

@interface ALDemoRewardedVideoViewController () <ALAdLoadDelegate, ALAdRewardDelegate>
@property (assign, atomic, getter=isVideoAvailable) BOOL videoAvailable;
@property (strong, nonatomic) IBOutlet UILabel *adLoadStatus;
@end

@implementation ALDemoRewardedVideoViewController

- (IBAction)loadRewardedVideo:(id)sender
{
    self.adLoadStatus.text = @"Loading rewarded video...";
    [[ALIncentivizedInterstitialAd shared] preloadAndNotify: self];
}

- (IBAction)showRewardedVideo:(id)sender
{
    if(self.videoAvailable)
    {
        UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
        [[ALIncentivizedInterstitialAd shared] showOver: keyWindow andNotify: self];
    }
}

#pragma mark ALAdLoadDelegate implementation... mandatory for rewarded videos

-(void) adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    self.videoAvailable = YES;
    self.adLoadStatus.text = @"Rewarded video loaded.";
}

-(void) adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    self.videoAvailable = NO;
    self.adLoadStatus.text = [NSString stringWithFormat: @"Failed to load: %d", code];
}

#pragma mark ALAdRewardDelegate implementation... mandatory for rewarded videos

-(void) rewardValidationRequestForAd:(ALAd *)ad didSucceedWithResponse:(NSDictionary *)response
{
    // Grant your user coins, or better yet, set up postbacks in the UI and refresh the balance from your server.
    
    NSString* currencyName = [response objectForKey: @"currency"];
    // For example - "Coins", "Gold", whatever you set in the UI.
    
    NSString* amountGivenString = [response objectForKey: @"amount"];
    // For example, "5" or "5.00" if you've specified an amount in the UI.
    // Obviously NSStrings aren't super helpful for numerica data, so you'll probably want to convert to NSNumber.
    
    NSNumber* amountGiven = [NSNumber numberWithFloat: [amountGivenString floatValue]];
    
    // Do something with this information.
    // [MYCurrencyManagerClass updateUserCurrency: currencyName withChange: amountGiven];
    
    // By default we'll show a UIAlertView informing your user of the currency & amount earned.
    // If you don't want this, you can turn it off in the Manage Apps UI.
}

-(void) rewardValidationRequestForAd:(ALAd *)ad didFailWithError:(NSInteger)responseCode
{
    if(responseCode == kALErrorCodeIncentivizedUserClosedVideo)
    {
        // Your user exited the video prematurely. It's up to you if you'd still like to grant
        // a reward in this case. Most developers choose not to. Note that this case can occur
        // after a reward was initially granted (since reward validation happens as soon as a
        // video is launched).
    }
    
    if(responseCode == kALErrorCodeAdRequestNetworkTimeout || responseCode == kALErrorCodeIncentivizedUnknownServerError)
    {
        // Some server issue happened here. Don't grant a reward. By default we'll show the user
        // a UIAlertView telling them to try again later, but you can change this in the
        // Manage Apps UI.
    }
}

-(void) rewardValidationRequestForAd:(ALAd *)ad didExceedQuotaWithResponse:(NSDictionary *)response
{
    // Your user has already earned the max amount you allowed for the day at this point, so
    // don't give them any more money. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
}

-(void) rewardValidationRequestForAd:(ALAd *)ad wasRejectedWithResponse:(NSDictionary *)response
{
    // Your user couldn't be granted a reward for this view. This could happen if you've blacklisted
    // them, for example. Don't grant them any currency. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
}

@end
