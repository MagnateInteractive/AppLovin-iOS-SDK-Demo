//
//  ALDemoNativeAdProgrammaticViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

// Additional documentation - https://applovin.com/integration#iosNative

class ALDemoNativeAdProgrammaticViewController: ALDemoBaseViewController, ALNativeAdLoadDelegate, ALNativeAdPrecacheDelegate, ALPostbackDelegate
{
    @IBOutlet weak var precacheButton: UIBarButtonItem!
    @IBOutlet weak var showButton: UIBarButtonItem!
    
    @IBOutlet weak var impressionStatusLabel: UILabel!
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mediaView: ALCarouselMediaView!
    @IBOutlet weak var ctaButton: UIButton!
    
    var nativeAd: ALNativeAd?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.appIcon.layer.masksToBounds = true
        self.appIcon.layer.cornerRadius = 3
        
        self.ctaButton.layer.masksToBounds = true
        self.ctaButton.layer.cornerRadius = 3
        
        setUIElementsHidden(true)
    }

    // MARK: Action Methods
    
    @IBAction func loadNativeAd(sender: AnyObject!)
    {
        self.log("Native ad loading...")
        
        self.precacheButton.enabled = false
        self.showButton.enabled = false
        
        self.impressionStatusLabel.text = "No impression to track"
        
        ALSdk.shared()?.nativeAdService.loadNativeAdGroupOfCount(1, andNotify: self)
    }
    
    @IBAction func precacheNativeAd(sender: AnyObject!)
    {
        // You can use our pre-caching to retrieve assets (app icon, ad image, ad video) locally. OR you can do it with your preferred caching framework.
        // iconURL, imageURL, videoURL needs to be retrieved manually before you can render them
        
        self.log("Native ad precaching...")
        
        if let ad = self.nativeAd
        {
            ALSdk.shared()?.nativeAdService.precacheResourcesForNativeAd(ad, andNotify: self)
        }
    }
    
    @IBAction func showNativeAd(sender: AnyObject!)
    {
        self.log("Native ad rendered")
        
        if let ad = self.nativeAd, iconURL = ad.iconURL
        {
            self.appIcon.image = UIImage(data: NSData(contentsOfURL: iconURL)!) // Local URL
            self.titleLabel.text = ad.title
            self.descriptionLabel.text = ad.descriptionText
            self.ctaButton.setTitle(ad.ctaText, forState: .Normal)
            
            let starFilename = "Star_Sprite_\(ad.starRating?.stringValue)"
            self.rating.image = UIImage(named: starFilename)
            
            // NOTE - Videos have aspect ratio of 1:1.85
            self.mediaView.renderViewForNativeAd(ad)
            
            setUIElementsHidden(false)

            //
            // You are responsible for firing all necessary postback URLs
            //
            trackImpression(ad)
            
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func ctaPressed(sender: AnyObject!)
    {
        self.nativeAd?.launchClickTarget()
    }

    // MARK: Impression Tracking
    
    func trackImpression(ad: ALNativeAd!)
    {
        // Callbacks may not happen on main queue
        dispatch_async(dispatch_get_main_queue()) {
            ALSdk.shared()?.postbackService.dispatchPostbackAsync(ad.impressionTrackingURL, andNotify: self)
        }
    }
    
    func postbackService(postbackService: ALPostbackService, didExecutePostback postbackURL: NSURL)
    {
        // Callbacks may not happen on main queue
        dispatch_async(dispatch_get_main_queue()) {
            // Impression tracked!
            self.impressionStatusLabel.text = "Impression tracked"
        }
    }
    
    func postbackService(postbackService: ALPostbackService, didFailToExecutePostback postbackURL: NSURL?, errorCode: Int)
    {
        // Callbacks may not happen on main queue
        dispatch_async(dispatch_get_main_queue()) {
            // Impression could not be tracked. Retry the postback later.
            self.impressionStatusLabel.text = "Impression failed to track with error code \(errorCode)"
        }
    }
    
    // MARK: Native Ad Load Delegate
    
    func nativeAdService(service: ALNativeAdService, didLoadAds ads: [AnyObject])
    {
        self.log("Native ad loaded, assets not retrieved yet.")
        
        // Callbacks may not happen on main queue
        dispatch_async(dispatch_get_main_queue()) {
            self.nativeAd = ads.first as? ALNativeAd
            self.precacheButton.enabled = true
        }
    }
    
    func nativeAdService(service: ALNativeAdService, didFailToLoadAdsWithError code: Int)
    {
        self.log("Native ad failed to load with error code \(code)")
    }
    
    // MARK: Native Ad Precache Delegate
    
    func nativeAdService(service: ALNativeAdService, didPrecacheImagesForAd ad: ALNativeAd)
    {
        self.log("Native ad precached images")
    }
    func nativeAdService(service: ALNativeAdService, didPrecacheVideoForAd ad: ALNativeAd)
    {
        // This delegate method will get called whether an ad actually has a video to precache or not
        self.log("Native ad done precaching")
        
        // Callbacks may not happen on main queue
        dispatch_async(dispatch_get_main_queue()) {
            self.showButton.enabled = true
            self.precacheButton.enabled = false
        }
    }
    
    func nativeAdService(service: ALNativeAdService, didFailToPrecacheImagesForAd ad: ALNativeAd, withError errorCode: Int)
    {
        self.log("Native ad failed to precache images with error code \(errorCode)")
    }
    
    func nativeAdService(service: ALNativeAdService, didFailToPrecacheVideoForAd ad: ALNativeAd, withError errorCode: Int)
    {
        self.log("Native ad failed to precache video with error code \(errorCode)")
    }
   
    // MARK: Utility
    
    func setUIElementsHidden(hidden: Bool)
    {
        self.appIcon.hidden = hidden
        self.titleLabel.hidden = hidden
        self.rating.hidden = hidden
        self.descriptionLabel.hidden = hidden
        self.mediaView.hidden = hidden
        self.ctaButton.hidden = hidden
    }
}
