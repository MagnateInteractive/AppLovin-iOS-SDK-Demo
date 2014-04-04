//
//  ALDemoRootController.h
//  iOS-SDK-Demo
//
//  Created by Matt Szaro on 4/3/14.
//  Copyright (c) 2014 AppLovin. All rights reserved.
//

/*
 This controller has nothing to do with the SDK, it's just
 responsible for the main menu. However, feel free to use this code
 in your own project if it's helpful to you.
*/

#import <UIKit/UIKit.h>

@interface ALDemoRootController : UITableViewController

@property (strong, nonatomic) NSArray* tableModel;
@property (strong, nonatomic) NSArray* sectionNames;
@property (strong, nonatomic) NSMutableDictionary* viewControllers;

@end
