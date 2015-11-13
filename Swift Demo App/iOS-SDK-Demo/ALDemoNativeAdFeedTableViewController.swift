//
//  ALDemoNativeAdFeedTableViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

//
// IMPORTANT: Before integrating native ads into your application, please be sure it is turned 'ON' in the Manage Apps section.
//

class ALDemoNativeAdFeedTableViewController: UITableViewController
{
    let kArticleCellIdentifier = "articleCell"
    let kAdCellIdentifier      = "adCell"
    
    let kCellTagTitleLabel       = 2
    let kCellTagSubtitleLabel    = 3
    let kCellTagDescriptionLabel = 4
    
    var articles = [ALDemoArticle]()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        ALDemoRSSFeedRetriever.sharedRetriever().startParsingWithCompletion { (error: NSError?, articles: [ALDemoArticle]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                
                guard error == nil && articles.count > 0 else {

                    let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) -> Void in
                        self.navigationController?.popViewControllerAnimated(true)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    return
                }
                
                self.articles = articles
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return articles.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return articles[indexPath.row].isAd ? 360 : 280
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell!
        let article = articles[indexPath.row]
        
        if article.isAd
        {
            // You can configure carousels in ALCarouselViewSettings.h
            cell = tableView.dequeueReusableCellWithIdentifier(kAdCellIdentifier, forIndexPath: indexPath)
        }
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier(kArticleCellIdentifier, forIndexPath: indexPath)
            (cell.viewWithTag(kCellTagTitleLabel)       as! UILabel).text = article.title
            (cell.viewWithTag(kCellTagSubtitleLabel)    as! UILabel).text = article.creator + " - " + article.pubDate
            (cell.viewWithTag(kCellTagDescriptionLabel) as! UILabel).text = article.articleDescription
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        UIApplication.sharedApplication().openURL(articles[indexPath.row].link)
    }
}
