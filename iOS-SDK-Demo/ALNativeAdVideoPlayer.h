//
//  ALVideoPlayer.h
//  sdk
//
//  Created by Matt Szaro on 6/23/14.
//
//

#import "ALNativeAdVideoView.h"
#import "ALSdk.h"

@import AVFoundation;
@import CoreMedia;

@interface ALNativeAdVideoPlayer : NSObject

@property (strong, nonatomic, readonly)  ALNativeAdVideoView* videoView;
@property (strong, nonatomic, readonly)  AVPlayerItem* playerItem;
@property (strong, nonatomic, readonly)  AVAsset* playerAsset;
@property (strong, nonatomic, readwrite)  NSURL* mediaSource;

-(instancetype) initWithMediaSource: (NSURL*) aMediaSource;

-(void) playVideo;
-(void) stopVideo;

@end


