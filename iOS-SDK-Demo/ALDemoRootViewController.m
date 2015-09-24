//
//  ALDemoRootViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoRootViewController.h"

@interface ALDemoRootViewController ()
@end

@implementation ALDemoRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f ,0.0f, 40.0f, 40.0f)];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.image = [UIImage imageNamed:@"nav_logo"];
    self.navigationItem.titleView = logo;
    
    [self.navigationController setToolbarHidden: YES];
}

@end
