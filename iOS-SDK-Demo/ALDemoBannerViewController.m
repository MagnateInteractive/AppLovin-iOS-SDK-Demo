//
//  ALDemoBannerViewController.m
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/3/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

#import "ALDemoBannerViewController.h"
#import "ALAdView.h"
#import "ALAdLoadDelegate.h"

@interface ALDemoBannerViewController () <ALAdLoadDelegate, ALAdDisplayDelegate>
@property (strong, nonatomic) IBOutlet UILabel *adLoadStatus;
@property (strong, nonatomic) IBOutlet ALAdView *bannerView;
@end

@implementation ALDemoBannerViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    // Assigning delegates is optional.
    self.bannerView.adLoadDelegate = self;
    self.bannerView.adDisplayDelegate = self;
}

-(IBAction)loadNextBanner:(id)sender
{
    [self.bannerView loadNextAd];
}

-(void) logMessage: (NSString*) message
{
    self.adLoadStatus.text = message;
    NSLog(@"AppLovin SDK Demo >>>> %@", message);
}

#pragma mark AppLovin delegate implementations (Optional)

-(void) adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self logMessage: @"Banner loaded."];
}

-(void) adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    if(code == kALErrorCodeNoFill)
    {
        // We couldn't fill your request with an ad - this can happen if you're testing
        // from a country where we don't have a large rotation, if you have opted your
        // device out, etc. If you're testing from a location outside of North America
        // or Western Europe, you might want to use a VPN within the United States for
        // testing purposes.
    }
    
   [self logMessage: [NSString stringWithFormat: @"Banner failed to load: %d", code]];
}

-(void) ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self logMessage: self.adLoadStatus.text = @"Banner loaded & displayed."];
}

-(void) ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self logMessage: @"Banner clicked."];
}

-(void) ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self logMessage: @"Banner hidden."];
}

@end
