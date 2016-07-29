//
//  ALDemoRootViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class ALDemoRootViewController: UITableViewController, MFMailComposeViewControllerDelegate
{
    let kSupportEmail = "support@applovin.com"
    let kSupportLink = "https://support.applovin.com/support/home"
    
    @IBOutlet var muteToggle: UIBarButtonItem!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        
        let logo = UIImageView(image: UIImage(named: "nav_logo"))
        logo.frame = CGRectMake(0, 0, 40, 40)
        logo.contentMode = .ScaleAspectFit
        self.navigationItem.titleView = logo
        
        self.addFooterLabel()
        
        self.muteToggle.image = muteIconForCurrentSdkMuteSetting()
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                openSupportSite()
            }
            else if indexPath.row == 1
            {
                attemptSendEmail()
            }
        }
    }
    
    // MARK: Sound Toggling
    
    @IBAction func toggleMute(sender: UIBarButtonItem!)
    {
        /**
         * Toggling the sdk mute setting will affect whether your video ads begin in a muted state or not.
         */
        let sdk = ALSdk.shared()
        sdk?.settings.muted = !(sdk?.settings.muted)!
        sender.image = muteIconForCurrentSdkMuteSetting()
    }
    
    func muteIconForCurrentSdkMuteSetting() -> UIImage!
    {
        return ALSdk.shared()!.settings.muted ? UIImage(named: "mute") : UIImage(named: "unmute")
    }
    
    // MARK: Table View Actions
    
    func openSupportSite()
    {
        let safariController = SFSafariViewController(URL: NSURL(string: kSupportLink)!, entersReaderIfAvailable: true)
        self.presentViewController(safariController, animated: true, completion: {
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
        })
    }
    
    func attemptSendEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mailController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setSubject("iOS SDK Support")
            mailController.setToRecipients([kSupportEmail])
            mailController.setMessageBody("\n\n---\nSDK Version: \(ALSdk.version())", isHTML: false)
            mailController.navigationBar.tintColor = UIColor.whiteColor()
            
            self.presentViewController(mailController, animated: true, completion: {
                UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
            })
        }
        else
        {
            let message = "Your device is not configured for sending emails.\n\nPlease send emails to \(kSupportEmail)"
            UIAlertView(title: "Email Unavailable", message: message, delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?)
    {
        switch ( result.rawValue )
        {
        case ( MFMailComposeResultSent.rawValue ):
            UIAlertView(title: "Email Sent", message: "Thank you for your email, we will process it as soon as possible.", delegate: nil, cancelButtonTitle: "OK").show()
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addFooterLabel()
    {
        let footer = UILabel()
        footer.font = UIFont.systemFontOfSize(14)
        footer.numberOfLines = 0
        
        let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let sdkVersion = ALSdk.version()
        let systemVersion = UIDevice.currentDevice().systemVersion
        let text = "App Version: \(appVersion)\nSDK Version: \(sdkVersion)\niOS Version: \(systemVersion)\n\nLanguage: Swift"
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        style.minimumLineHeight = 20
        footer.attributedText = NSAttributedString(string: text, attributes: [NSParagraphStyleAttributeName : style])
        
        var frame = footer.frame
        frame.size.height = footer.sizeThatFits(CGSizeMake(CGRectGetWidth(footer.frame), CGFloat.max)).height + 60
        footer.frame = frame
        self.tableView.tableFooterView = footer
    }
}
