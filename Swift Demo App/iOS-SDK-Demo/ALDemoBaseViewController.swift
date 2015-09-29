//
//  ALDemoBaseViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

class ALDemoBaseViewController: UIViewController
{
    @IBOutlet weak var adStatusLabel: UILabel?
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        self.navigationController?.setToolbarHidden(true, animated: false)
        super.viewWillDisappear(animated)
    }
    
    func log(message: String!)
    {
        dispatch_async(dispatch_get_main_queue()) {
            if let label = self.adStatusLabel {
                label.text = message
            }
        };
        
    }
}
