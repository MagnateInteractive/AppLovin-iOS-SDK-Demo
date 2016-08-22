//
//  ALNativeBannerAd.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Thomas So on 8/18/16.
//  Copyright © 2016 AppLovin. All rights reserved.
//

@import AppLovinSDK;
#import "ALNativeBannerAd.h"

@interface ALNativeBannerAd() <ALNativeAdLoadDelegate, ALNativeAdPrecacheDelegate>

@property (nonatomic, assign) BOOL initialized;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *subtitleLabel;

@property (nonatomic, strong) ALNativeAd *currentAd;

@property (nonatomic, strong) NSArray<ALNativeAd *> *ads;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation ALNativeBannerAd
@dynamic loaded;

const NSUInteger ALNativeBannerAdNumberOfAdsToLoad = 3;


#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if ( self )
    {
        [self initializeIfNeeded];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        [self initializeIfNeeded];
    }
    return self;
}

- (void)initializeIfNeeded
{
    if ( !self.initialized )
    {
        self.initialized = YES;
        
        const NSUInteger loadcount = MAX(0, ALNativeBannerAdNumberOfAdsToLoad);
        [[ALSdk shared].nativeAdService loadNativeAdGroupOfCount: loadcount andNotify: self];
    }
}

#pragma mark - View Rendering

// render and refresh timer

#pragma mark - Native Ad Load Delegate

- (void)nativeAdService:(ALNativeAdService *)service didLoadAds:(NSArray<ALNativeAd *> *)ads
{
    if ( ads.count > 0 )
    {
        self.ads = ads;
        
        // Call back delegate
        
        // Render First Native Ad
    }
    else
    {
        ALLog(@"");
        
        // Call back delegate
    }
}

- (void)nativeAdService:(ALNativeAdService *)service didFailToLoadAdsWithError:(NSInteger)code
{
    if ( [self.delegate respondsToSelector: @selector(didFailToLoadAdForNativeBannerAd:withErrorCode:)] )
    {
        [self.delegate didFailToLoadAdForNativeBannerAd: self withErrorCode: code];
    }
}

#pragma mark - Native Ad Precache Delegate

- (void)nativeAdService:(ALNativeAdService *)service didPrecacheImagesForAd:(ALNativeAd *)ad
{
    
}

- (void)nativeAdService:(ALNativeAdService *)service didPrecacheVideoForAd:(ALNativeAd *)ad
{
    
}

- (void)nativeAdService:(ALNativeAdService *)service didFailToPrecacheImagesForAd:(ALNativeAd *)ad withError:(NSInteger)errorCode
{
    
}

- (void)nativeAdService:(ALNativeAdService *)service didFailToPrecacheVideoForAd:(ALNativeAd *)ad withError:(NSInteger)errorCode
{
    
}

#pragma mark - Dynamic Properties

- (BOOL)isLoaded
{
    return self.currentAd != nil;
}

+ (CGFloat)desiredHeight
{
    // 50.0f for iPhone and ??? for iPad
    return 50.0f;
}

@end
