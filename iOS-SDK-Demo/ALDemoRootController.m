//
//  ALDemoRootController.m
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

#import "ALDemoRootController.h"

@interface ALDemoRootController ()

@end

@implementation ALDemoRootController

-(void) viewDidLoad
{
    [super viewDidLoad];
    _tableModel = [self navigationModel];
    _sectionNames = [self navigationModelSectionTitles];
    
    _viewControllers = [[NSMutableDictionary alloc] init];
    
    for(NSArray* section in _tableModel)
    {
        for(NSString* storyboardOutlet in section)
        {
            UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier: storyboardOutlet];
            
            _viewControllers[storyboardOutlet] = controller;
        }
    }
    
    self.navigationItem.backBarButtonItem = [self menuButton];
    
}

-(NSArray*) navigationModel
{
    NSArray* sectionSimple;
    NSArray* sectionAdvanced;
    
    sectionSimple = @[
                      @"Banners",
                      @"Interstitials"
                   ];
    
    sectionAdvanced = @[
                        @"Programmatic Banners",
                        @"Programmatic Interstitials",
                        @"Manual Precaching",
                        @"Rewarded Videos"
                        ];
    
    return @[sectionSimple, sectionAdvanced];
}

-(NSArray*) navigationModelSectionTitles
{
    return @[@"Basic Integrations", @"Advanced Integrations"];
}

-(UIBarButtonItem*) menuButton
{
    return [[UIBarButtonItem alloc]
            initWithTitle: @"Menu"
            style: UIBarButtonItemStyleBordered
            target: nil action: nil];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableModel count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableModel[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootPrototype" forIndexPath:indexPath];
    
    NSString* label = _tableModel[[indexPath section]][[indexPath row]];
    cell.textLabel.text = label;
    
    return cell;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionNames[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    [self pushViewControllerForStoryboardID: _tableModel[section][row]];
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

-(void) pushViewControllerForStoryboardID:(NSString*) identifier
{
    UIViewController* vc = _viewControllers[identifier];
    [self.navigationController pushViewController: vc animated: YES];
}


@end
