//
//  ALCarouselCardView.h
//  sdk
//
//  Created by Thomas So on 4/20/15.
//
//

#import <UIKit/UIKit.h>

#import "ALCarouselMediaView.h"
#import "ALCarouselViewModel.h"
#import "ALCarouselRenderingProtocol.h"
#import "ALNullabilityAnnotations.h"

@class ALCarouselView;

/**
 *  This view is used for paging of the carousel.
 */
@interface ALCarouselCardView : UIView <ALCarouselRenderingProtocol>

/**
 *  The view containing the ad video or image.
 */
@property (strong, nonatomic) ALCarouselMediaView* __alnonnull  mediaView;

/**
 *  Initializes a newly allocated card view object with the specified sdk
 */
- (alnonnull instancetype) initWithSdk:(alnonnull ALSdk *)sdk;

/**
 *  Redirects to the CTA for the given ad.
 *
 *  @param ad The ad with the CTA URL to redirect to.
 */
- (void)handleClickForAd:(alnonnull ALNativeAd *)ad;

/**
 Call this method when your view is displayed to the user.
 Will track an impression.
 */
- (void)trackImpression;

@property (strong, nonatomic)  UIActivityIndicatorView* __alnullable  activityIndicator;
@property (strong, nonatomic)  UIView*                  __alnullable  activityIndicatorOverlay;

-(alnonnull id) init                        __attribute__((unavailable("Use initWithSdk:parentView:")));
-(alnonnull id) initWithFrame:(CGRect)frame __attribute__((unavailable("Use initWithSdk:parentView:")));

@end