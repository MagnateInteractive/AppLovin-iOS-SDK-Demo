//
//  ALCarouselRenderingProtocol.h
//  sdk
//
//  Created by Matt Szaro on 5/7/15.
//
//

#import <Foundation/Foundation.h>
#import "ALNativeAd.h"
#import "ALCarouselCardState.h"

@protocol ALCarouselRenderingProtocol <NSObject>

@optional
- (void)renderViewForNativeAd:(alnonnull ALNativeAd *)ad;

@required
- (void)renderViewForNativeAd:(alnonnull ALNativeAd *)ad cardState:(alnonnull ALCarouselCardState *)cardState;

/**
 *  Resets the current card's view properties.
 */
- (void)clearView;

@end