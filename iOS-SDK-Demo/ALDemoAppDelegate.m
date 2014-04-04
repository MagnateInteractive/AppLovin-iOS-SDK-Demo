//
//  ALDemoAppDelegate.m
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/3/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

#import "ALDemoAppDelegate.h"
#import "ALSdk.h"

@implementation ALDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initializing our SDK at launch is very important as it'll start pre-loading ads in the background.
    [ALSdk initializeSdk];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
