//
//  ALDemoInterstitialManualLoadingViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

class ALDemoInterstitialManualLoadingViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate
{
    @IBOutlet weak var showButton: UIBarButtonItem!
    
    var ad: ALAd?
    
    @IBAction func loadInterstitial(sender: AnyObject!)
    {
        self.log("Interstitial loading...")
        ALSdk.shared()!.adService.loadNextAd(ALAdSize.sizeInterstitial(), andNotify: self)
    }
    
    @IBAction func showInterstitial(sender: AnyObject!)
    {
        // Optional: Assign delegates
        ALInterstitialAd.shared().adDisplayDelegate = self
        ALInterstitialAd.shared().adVideoPlaybackDelegate = self
        
        if let ad = self.ad
        {
            /*
             NOTE: We recommend the use of placements (AFTER creating them in your dashboard):
             
             ALInterstitialAd.shared().showOver(UIApplication.sharedApplication().keyWindow!, placement: "MANUAL_LOADING_SCREEN"" andRender: ad)
             
             To learn more about placements, check out https://applovin.com/integration#iosPlacementsIntegration
             */
            
            ALInterstitialAd.shared().showOver(UIApplication.sharedApplication().keyWindow!, andRender: ad)
        }
    }
    
    // MARK: Ad Load Delegate
    
    func adService(adService: ALAdService, didLoadAd ad: ALAd)
    {
        self.log("Interstitial Loaded")
        
        self.ad = ad
        self.showButton.enabled = true
    }
    
    func adService(adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("Interstitial failed to load with error code \(code)")
    }
    
    // MARK: Ad Display Delegate
    
    func ad(ad: ALAd, wasDisplayedIn view: UIView)
    {
        self.log("Interstitial Displayed")
    }
    
    func ad(ad: ALAd, wasHiddenIn view: UIView)
    {
        self.log("Interstitial Dismissed")
    }
    
    func ad(ad: ALAd, wasClickedIn view: UIView)
    {
        self.log("Interstitial Clicked")
    }
    
    // MARK: Ad Video Playback Delegate
    
    func videoPlaybackBeganInAd(ad: ALAd)
    {
        self.log("Video Started")
    }
    
    func videoPlaybackEndedInAd(ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool)
    {
        self.log("Video Ended")
    }
}
