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
    let kAdCellIdentifier = "adCell"
    
    var data = [[String:String]]()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        data = generateData()
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return data[indexPath.row].count > 0 ? 280 : 360
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell!
        let article = data[indexPath.row]
        if article.count > 0
        {
            cell = tableView.dequeueReusableCellWithIdentifier(kArticleCellIdentifier, forIndexPath: indexPath)
            (cell.viewWithTag(2) as! UILabel).text = article["title"]
            (cell.viewWithTag(3) as! UILabel).text = article["subtitle"]
            (cell.viewWithTag(4) as! UILabel).text = article["content"]
        }
        else
        {
            // You can configure carousels in ALCarouselViewSettings.h
            cell = tableView.dequeueReusableCellWithIdentifier(kAdCellIdentifier, forIndexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let article = data[indexPath.row]
        if article.count > 0
        {
            let URL = NSURL(string: article["link"]! )
            UIApplication.sharedApplication().openURL(URL!)
        }
    }
    
    // MARK: Data
    
    func generateData() -> [Dictionary<String, String>]
    {
        var theData = [[String:String]]()
        theData.append(
            ["title"    : "Mobile marketers can learn from mobile gaming",
                "subtitle" : "by Patrick Gorman - September 22, 2015",
                "link"     : "http://www.fiercecmo.com/mobilemarketer/story/mobile-marketers-can-learn-mobile-gaming/2015-09-22",
                "content"  : "Mobile gaming has seen incredible success in engaging audiences—not only with their products, but with marketing messages as well. While mobile gaming is a unique vertical, there are some lessons to be learned from how mobile gaming marketers are getting their messages heard in a very competitive market."])
        theData.append(
            ["title"    : "Pandora Presses Play On Direct-Response Mobile Video",
                "subtitle" : "by Allison Schiff - September 21, 2015",
                "link"     : "http://adexchanger.com/mobile/pandora-presses-play-on-direct-response-mobile-video/",
                "content"  : "Pandora knows sound. Now the music streaming service is experimenting with sight and motion in its quest for new users – and mobile is the central battleground. More than three-quarters of Pandora’s roughly 80 million monthly active users listen on mobile."])
        theData.append( [String:String]() )
        theData.append(
            ["title"    : "3 mobile marketing lessons brands should steal out of the gaming playbook",
                "subtitle" : "by Mark Rosner - September 21, 2015",
                "link"     : "http://venturebeat.com/2015/09/21/5-mobile-marketing-lessons-brands-should-steal-out-of-the-gaming-playbook/",
                "content"  : "There’s a reason why mobile games now generate more revenue than online games: When it comes to marketing and customer acquisition, the mobile gaming industry has it down. Mobile game developers make the most of their marketing budgets, and they use data to inform the user experience and acquisition. Competition is fierce in the gaming vertical, so game developers have to continually innovate not just their products, but their marketing strategies."])
        theData.append(
            ["title"    : "Mentor Relationships: The Secret Weapon for Women in Tech",
                "subtitle" : "by Katie Jansen - August 10, 2015",
                "link"     : "http://women2.com/2015/08/10/mentoring-relationships-in-tech/",
                "content"  : "When I attended Think Differently!, a recruiting event hosted by Women 2.0, I couldn’t help but notice how thrilled other AppLovin employees were to be there.\nLater Anusha Ramesh and Sonal Gupta, both engineers, told me about how exhilarating it was to be at an event with so many successful women in tech. “Seeing and meeting dozens of women working in tech who have carved out remarkable careers — and have a lot to say about how to be a successful working mom — really builds my confidence at this stage in my career,” one of them told me.\nThat got me thinking about women and mentoring in tech — specifically about how important it is. And how there isn’t enough of it. Why?"])
        theData.append(
            ["title"    : "AppLovin is on fire with $210 million run-rate",
                "subtitle" : "by Sean Anderson - May 22, 2015",
                "link"     : "http://www.bizjournals.com/sanfrancisco/print-edition/2015/05/22/tech-award-best-ad-tech-applovin-adam-foroughi.html",
                "content"  : "\"The difference between us and similar companies is that our initial focus on hiring was — and continues to be — on engineering instead of sales,\" said Foroughi. \"We didn’t hire anyone from sales for the first year and a half.\"\nOut of the company’s approximately 90 employees, only a handful work in the sales division. The rest are all toiling on Applovin’s technology. Foroughi says Applovin’s heavy focus on tech instead of the more traditional sales model is what has allowed it to offer a more automated product on mobile platforms than its competitors."])
        
        return theData
    }
}
