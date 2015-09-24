//
//  ALDemoBaseViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoBaseViewController.h"

@interface ALDemoBaseViewController ()
@end

@implementation ALDemoBaseViewController

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [self.navigationController setToolbarHidden: NO animated: YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden: YES];
    [super viewWillDisappear: animated];
}


#pragma mark - Logging

- (void)log:(NSString *)message
{
    if ( self.adStatusLabel )
    {
        self.adStatusLabel.text = message;
    }
    ALLog(@"[%@] : %@", NSStringFromClass([self class]), message);
}

@end
