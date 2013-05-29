//
//  ICAppDelegate.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 13/02/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "ICAppDelegate.h"
#import "ICExampleStyleGroupedViewController.h"
#import "ICExampleStylePlainViewController.h"

@implementation ICAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSDictionary *plainStyleSheet = @{IMOStyledCellBackgroundImageKey: [UIImage imageNamed:@"clouds.png"],
                                      IMOStyledCellTopGradientColorKey: [UIColor colorWithWhite:0.865 alpha:0.220],
                                      IMOStyledCellBottomGradientColorKey: [UIColor colorWithWhite:0.439 alpha:0.570],
                                      IMOStyledCellTextLabelTextColorKey: [UIColor whiteColor],
                                      IMOStyledCellTopSeparatorColorKey: [UIColor whiteColor],
                                      IMOStyledCellBottomSeparatorColorKey: [UIColor lightGrayColor]};
    
    
    NSDictionary *groupedStyleSheet = @{IMOStyledCellBackgroundImageKey :            [UIImage imageNamed:@"carot"],
                                        IMOStyledCellBackgroundColorKey:             [UIColor orangeColor],
                                        IMOStyledCellTopGradientColorKey :           [UIColor colorWithRed:1.000 green:0.786 blue:0.621 alpha:1.000],
                                        IMOStyledCellBottomGradientColorKey:         [UIColor colorWithRed:0.829 green:0.576 blue:0.252 alpha:1.000],
                                        IMOStyledCellTextLabelFontKey:               [UIFont fontWithName:@"HelveticaNeue" size:20.0],
                                        IMOStyledCellTextLabelTextColorKey:          [UIColor colorWithRed:0.185 green:0.362 blue:0.201 alpha:1.000],
                                        IMOStyledCellDetailTextLabelTextColorKey:    [UIColor colorWithRed:0.264 green:0.271 blue:0.473 alpha:1.000],
                                        IMOStyledCellUseCustomHeaderKey:             @YES,
                                        IMOStyledCellHeaderTextColorKey:             [UIColor colorWithRed:0.424 green:0.139 blue:0.054 alpha:1.000],
                                        IMOStyledCellHeaderFontKey:                  [UIFont fontWithName:@"ChalkboardSE-Bold" size:20.0f],
                                        IMOStyledCellUseCustomFooterKey:             @YES,
                                        IMOStyledCellTextCaptionTextColorKey:        [UIColor colorWithRed:0.451 green:0.365 blue:0.217 alpha:1.000],
                                        IMOStyledCellSelectedBottomGradientColorKey: [UIColor colorWithRed:0.633 green:0.000 blue:0.007 alpha:1.000],
                                        IMOStyledCellSelectedTopGradientColorKey:    [UIColor redColor]
                                        };
    
    ICExampleStylePlainViewController *stylePlainViewController = [[ICExampleStylePlainViewController alloc]
                                                                   initWithStyle:UITableViewStylePlain
                                                                   styleSheet:nil];
    [[stylePlainViewController tabBarItem] setTitle:@"Plain Style"];
    [[stylePlainViewController tabBarItem] setImage:[UIImage imageNamed:@"plain"]];
    
    
    ICExampleStyleGroupedViewController *styleGroupedViewController = [[ICExampleStyleGroupedViewController alloc]
                                                                       initWithStyle:UITableViewStyleGrouped
                                                                       styleSheet:groupedStyleSheet];

    [[styleGroupedViewController tabBarItem] setTitle:@"Grouped Style"];
    [[styleGroupedViewController tabBarItem] setImage:[UIImage imageNamed:@"list"]];


    UINavigationController *plainNavController = [[UINavigationController alloc] initWithRootViewController:stylePlainViewController];
    UINavigationController *groupNavController = [[UINavigationController alloc] initWithRootViewController:styleGroupedViewController];
    
    NSArray *controllers = @[plainNavController, groupNavController];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:controllers];
    [tabBarController setSelectedViewController:[tabBarController viewControllers][0]];
    
    [[self window] setRootViewController:tabBarController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
