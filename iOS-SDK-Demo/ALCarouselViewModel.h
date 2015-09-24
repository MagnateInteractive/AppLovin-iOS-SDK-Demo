//
//  ALCarouselModel.h
//  sdk
//
//  Created by Matt Szaro on 4/20/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ALNullabilityAnnotations.h"

@class ALNativeAd;
@class ALCarouselCardState;
@class ALSdk;

@interface ALCarouselViewModel : NSObject

@property (strong, nonatomic, readonly) NSArray* __alnullable nativeAds;
@property (assign, nonatomic, readonly) NSUInteger nativeAdsCount;

-(alnonnull instancetype) initWithNativeAds: (alnonnull NSArray *)ads;
-(alnullable ALCarouselCardState*) cardStateForNativeAd: (alnonnull ALNativeAd*) ad;
-(alnullable ALCarouselCardState*) cardStateAtNativeAdIndex: (NSUInteger) index;
-(alnullable ALNativeAd*) nativeAdAtIndex: (NSUInteger) index;

-(void) removeAllObjects;

@end