//
//  ALDemoNativeAdFeedTableViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/24/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoNativeAdFeedTableViewController.h"
#import "ALCarouselView.h"

//
// This view controller demonstrates how to display native ads using our open-source carousel views.
//

@interface ALDemoNativeAdFeedTableViewController()
@property (nonatomic, strong) NSArray *data;
@end

@implementation ALDemoNativeAdFeedTableViewController
static NSString *const kArticleCellIdentifier = @"articleCell";
static NSString *const kAdCellIdentifier = @"adCell";

//
// IMPORTANT: Before integrating native ads into your application, please be sure it is turned 'ON' in the Manage Apps section.
//

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [self generateData];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *article = self.data[indexPath.row];
    return article.count > 0 ? 280.0f : 360.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSDictionary *article = self.data[indexPath.row];
    if ( article.count > 0 )
    {
        cell = [tableView dequeueReusableCellWithIdentifier: kArticleCellIdentifier forIndexPath:indexPath];
        ((UILabel *)[cell viewWithTag: 2]).text = article[@"title"];
        ((UILabel *)[cell viewWithTag: 3]).text = article[@"subtitle"];
        ((UILabel *)[cell viewWithTag: 4]).text = article[@"content"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier: kAdCellIdentifier forIndexPath:indexPath];
       
        // You can configure carousels in ALCarouselViewSettings.h
    }

    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];

    NSDictionary *article = self.data[indexPath.row];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: article[@"link"]]];
}

#pragma mark - Data

- (NSArray *)generateData
{
    return @[
             @{@"title"    : @"Mobile marketers can learn from mobile gaming",
               @"subtitle" : @"by Patrick Gorman - September 22, 2015",
               @"link"     : @"http://www.fiercecmo.com/mobilemarketer/story/mobile-marketers-can-learn-mobile-gaming/2015-09-22",
               @"content"  : @"Mobile gaming has seen incredible success in engaging audiences—not only with their products, but with marketing messages as well. While mobile gaming is a unique vertical, there are some lessons to be learned from how mobile gaming marketers are getting their messages heard in a very competitive market."},
             @{@"title"    : @"Pandora Presses Play On Direct-Response Mobile Video",
               @"subtitle" : @"by Allison Schiff - September 21, 2015",
               @"link"     : @"http://adexchanger.com/mobile/pandora-presses-play-on-direct-response-mobile-video/",
               @"content"  : @"Pandora knows sound. Now the music streaming service is experimenting with sight and motion in its quest for new users – and mobile is the central battleground. More than three-quarters of Pandora’s roughly 80 million monthly active users listen on mobile."},
             @{@"title"    : @"3 mobile marketing lessons brands should steal out of the gaming playbook",
               @"subtitle" : @"by Mark Rosner - September 21, 2015",
               @"link"     : @"http://venturebeat.com/2015/09/21/5-mobile-marketing-lessons-brands-should-steal-out-of-the-gaming-playbook/",
               @"content"  : @"There’s a reason why mobile games now generate more revenue than online games: When it comes to marketing and customer acquisition, the mobile gaming industry has it down. Mobile game developers make the most of their marketing budgets, and they use data to inform the user experience and acquisition. Competition is fierce in the gaming vertical, so game developers have to continually innovate not just their products, but their marketing strategies."},
             @{ /* ad */ },
             @{@"title"    : @"Mentor Relationships: The Secret Weapon for Women in Tech",
               @"subtitle" : @"by Katie Jansen - August 10, 2015",
               @"link"     : @"http://women2.com/2015/08/10/mentoring-relationships-in-tech/",
               @"content"  : @"When I attended Think Differently!, a recruiting event hosted by Women 2.0, I couldn’t help but notice how thrilled other AppLovin employees were to be there.\nLater Anusha Ramesh and Sonal Gupta, both engineers, told me about how exhilarating it was to be at an event with so many successful women in tech. “Seeing and meeting dozens of women working in tech who have carved out remarkable careers — and have a lot to say about how to be a successful working mom — really builds my confidence at this stage in my career,” one of them told me.\nThat got me thinking about women and mentoring in tech — specifically about how important it is. And how there isn’t enough of it. Why?"},
             @{@"title"    : @"AppLovin is on fire with $210 million run-rate",
               @"subtitle" : @"by Sean Anderson - May 22, 2015",
               @"link"     : @"http://www.bizjournals.com/sanfrancisco/print-edition/2015/05/22/tech-award-best-ad-tech-applovin-adam-foroughi.html",
               @"content"  : @"\"The difference between us and similar companies is that our initial focus on hiring was — and continues to be — on engineering instead of sales,\" said Foroughi. \"We didn’t hire anyone from sales for the first year and a half.\"\nOut of the company’s approximately 90 employees, only a handful work in the sales division. The rest are all toiling on Applovin’s technology. Foroughi says Applovin’s heavy focus on tech instead of the more traditional sales model is what has allowed it to offer a more automated product on mobile platforms than its competitors."}
             ];
}

@end
