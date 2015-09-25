//
//  ALDemoRootViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoRootViewController.h"
#import "ALSdk.h"
#import <MEssageUI/MFMailComposeViewController.h>

@interface ALDemoRootViewController()<MFMailComposeViewControllerDelegate>
@end

@implementation ALDemoRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden: YES];

    UIImageView *logo = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.image = [UIImage imageNamed: @"nav_logo"];
    self.navigationItem.titleView = logo;

    [self addFooterLabel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if ( indexPath.section == 1 )
    {
        if ( indexPath.row == 0 )
        {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"https://support.applovin.com/support/home"]];
        }
        else if ( indexPath.row == 1 )
        {
            [self attemptSendEmail];
        }
    }
}

- (void)attemptSendEmail
{
    static NSString *const supportEmail = @"support@applovin.com";
    
    if ( [MFMailComposeViewController canSendMail] )
    {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        [mailController setSubject: @"iOS SDK support"];
        [mailController setToRecipients: @[supportEmail]];
        [mailController setMessageBody: [NSString stringWithFormat: @"\n\n---\nSDK Version: %@", [ALSdk version]] isHTML: NO];
        mailController.navigationBar.tintColor = [UIColor whiteColor];
        [self presentViewController: mailController animated: YES completion:^{
             [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
        }];
    }
    else
    {
        NSString *message = [NSString stringWithFormat: @"Your device is not configured for sending emails.\n\nPlease send emails to %@", supportEmail];
        [[[UIAlertView alloc] initWithTitle: @"Email Unavailable"
                                    message: message
                                   delegate: nil
                          cancelButtonTitle: @"OK"
                          otherButtonTitles: nil, nil] show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch ( result )
    {
        case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle: @"Email Sent"
                                        message: @"Thank you for your email, we will process it as soon as possible."
                                       delegate: nil
                              cancelButtonTitle: @"OK"
                              otherButtonTitles: nil, nil] show];
        case MFMailComposeResultCancelled:
        case MFMailComposeResultSaved:
        case MFMailComposeResultFailed:
        default:
            break;
    }

    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)addFooterLabel
{
    UILabel *footer = [[UILabel alloc] init];
    footer.font = [UIFont systemFontOfSize: 14.0f];
    footer.numberOfLines = 0;
    
    NSString *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *sdkVersion = [ALSdk version];
    NSString *sdkKey = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"AppLovinSdkKey"];
    NSString *text = [NSString stringWithFormat: @"App Version: %@\nSDK Version: %@\nSDK Key: %@", appVersion, sdkVersion, sdkKey];
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.alignment =  NSTextAlignmentCenter;
    style.minimumLineHeight = 20.f;
    footer.attributedText = [[NSAttributedString alloc] initWithString: text attributes: @{NSParagraphStyleAttributeName : style}];
    
    CGRect frame = footer.frame;
    frame.size.height = [footer sizeThatFits: CGSizeMake(CGRectGetWidth(footer.frame), CGFLOAT_MAX)].height + 60.0f;
    footer.frame = frame;
    self.tableView.tableFooterView = footer;
}

@end
