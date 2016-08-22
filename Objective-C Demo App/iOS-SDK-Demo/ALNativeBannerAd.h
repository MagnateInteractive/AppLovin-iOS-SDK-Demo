//
//  ALNativeBannerAd.h
//  iOS-SDK-Demo-ObjC
//
//  Created by Thomas So on 8/18/16.
//  Copyright © 2016 AppLovin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AppLovinSDK;

NS_ASSUME_NONNULL_BEGIN

@class ALNativeBannerAd;

@protocol ALNativeBannerAdDelegate <NSObject>
@optional
- (void)didLoadAdForNativeBannerAd:(ALNativeBannerAd *)nativeBannerAd;
- (void)didFailToLoadAdForNativeBannerAd:(ALNativeBannerAd *)nativeBannerAd withErrorCode:(NSInteger)code;
@end

// TODO: Better name for this?
@protocol ALNativeBannerAdDataSource <NSObject>

@optional
- (NSTimeInterval)refreshTimeIntervalForNativeBannerAd:(ALNativeBannerAd *)nativeBannerAd;
@end


@interface ALNativeBannerAd : UIView

/**
 * The number of native ads that will be preloaded and stored for rotation.
 */
extern const NSUInteger ALNativeBannerAdNumberOfAdsToLoad;

@property (nonatomic, assign, readonly, getter=isLoaded) BOOL loaded;

@property (nonatomic, weak, nullable) id<ALNativeBannerAdDelegate> delegate;
@property (nonatomic, weak, nullable) id<ALNativeBannerAdDataSource> dataSource;

// TODO: Create appearance proxy?
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subtitleLabel;


+ (CGFloat)desiredHeight;

@end

NS_ASSUME_NONNULL_END
