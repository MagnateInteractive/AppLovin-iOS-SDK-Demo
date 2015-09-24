//
//  ALDemoRootViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoRootViewController.h"
#import "ALSdk.h"

@interface ALDemoRootViewController ()
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
    
    UILabel *footer = [[UILabel alloc] init];
    footer.font = [UIFont systemFontOfSize: 14.0f];
    footer.numberOfLines = 0;
    
    NSString *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *text = [NSString stringWithFormat: @"App Version: %@\nSDK Version: %@", appVersion, [ALSdk version]];
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
