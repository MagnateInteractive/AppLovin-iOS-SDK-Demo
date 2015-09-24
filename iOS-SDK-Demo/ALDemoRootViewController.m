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
    
    NSString *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    
    UILabel *footer = [[UILabel alloc] init];
    footer.text = [NSString stringWithFormat: @"App Version: %@\n\nSDK Version: %@", appVersion, [ALSdk version]];
    footer.textAlignment = NSTextAlignmentCenter;
    footer.font = [UIFont systemFontOfSize: 14.0f];
    footer.numberOfLines = 0;
    CGRect frame = footer.frame;
    frame.size.height = [footer sizeThatFits: CGSizeMake(CGRectGetWidth(footer.frame), CGFLOAT_MAX)].height + 60.0f;
    footer.frame = frame;
    self.tableView.tableFooterView = footer;
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.image = [UIImage imageNamed: @"nav_logo"];
    self.navigationItem.titleView = logo;
    
    [self.navigationController setToolbarHidden: YES];
}

@end
