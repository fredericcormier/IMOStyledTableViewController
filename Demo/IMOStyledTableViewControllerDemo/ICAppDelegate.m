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
#import "ICSheetTableViewController.h"

@interface ICAppDelegate()

@property(nonatomic, strong)NSDictionary *plainStyleSheet;
@property(nonatomic, strong)NSDictionary *groupedStyleSheet;

- (void)setUpStyleDictionaries;

@end


@implementation ICAppDelegate

@synthesize plainStyleSheet = plainStyleSheet_;
@synthesize groupedStyleSheet = groupedStyleSheet_;

- (void)setUpStyleDictionaries {
    plainStyleSheet_    = @{IMOStyledCellBackgroundImageKey:            [UIImage imageNamed:@"clouds.png"],
                            IMOStyledCellNavBarTintColorKey:            [UIColor colorWithRed:0.145 green:0.185 blue:0.359 alpha:1.000],
                            IMOStyledCellTopGradientColorKey:           [UIColor colorWithWhite:0.945 alpha:0.220],
                            IMOStyledCellBottomGradientColorKey:        [UIColor colorWithRed:0.628 green:0.632 blue:0.684 alpha:0.570],
                            IMOStyledCellTextLabelFontKey:              [UIFont fontWithName:@"HelveticaNeue" size:18.0],
                            IMOStyledCellTextLabelTextColorKey:         [UIColor whiteColor],
                            IMOStyledCellTopSeparatorColorKey:          [UIColor colorWithRed:0.771 green:0.793 blue:0.820 alpha:1.000],
                            IMOStyledCellBottomSeparatorColorKey:       [UIColor lightGrayColor]};
    
    
    groupedStyleSheet_ = @{IMOStyledCellBackgroundImageKey :            [UIImage imageNamed:@"carot"],
                           IMOStyledCellNavBarTintColorKey:             [UIColor colorWithRed:0.735 green:0.242 blue:0.004 alpha:1.000],
                           IMOStyledCellBackgroundColorKey:             [UIColor colorWithRed:0.811 green:0.605 blue:0.343 alpha:1.000],
                           IMOStyledCellTopGradientColorKey :           [UIColor colorWithRed:1.000 green:0.786 blue:0.621 alpha:1.000],
                           IMOStyledCellBottomGradientColorKey:         [UIColor colorWithRed:0.829 green:0.576 blue:0.252 alpha:1.000],
                           IMOStyledCellTextLabelFontKey:               [UIFont fontWithName:@"TrebuchetMS-Bold" size:20.0],
                           IMOStyledCellTextLabelTextColorKey:          [UIColor colorWithRed:0.185 green:0.362 blue:0.201 alpha:1.000],
                           IMOStyledCellDetailTextLabelTextColorKey:    [UIColor colorWithWhite:0.298 alpha:1.000],
                           IMOStyledCellTextCaptionFontKey:             [UIFont fontWithName:@"TrebuchetMS-Bold" size:12.0],
                           IMOStyledCellTextCaptionTextColorKey:        [UIColor colorWithRed:0.185 green:0.362 blue:0.201 alpha:1.000],
                           IMOStyledCellUseCustomHeaderKey:             @YES,
                           IMOStyledCellHeaderTextColorKey:             [UIColor colorWithRed:0.424 green:0.139 blue:0.054 alpha:1.000],
                           IMOStyledCellHeaderFontKey:                  [UIFont fontWithName:@"TrebuchetMS-Bold" size:20.0f],
                           IMOStyledCellFooterFontKey:                  [UIFont boldSystemFontOfSize:12.f],
                           IMOStyledCellFooterTextColorKey:             [UIColor colorWithRed:0.001 green:0.330 blue:0.001 alpha:1.000],
                           IMOStyledCellUseCustomFooterKey:             @YES,
                           IMOStyledCellTextCaptionTextColorKey:        [UIColor colorWithRed:0.451 green:0.365 blue:0.217 alpha:1.000],
                           IMOStyledCellSelectedBottomGradientColorKey: [UIColor colorWithRed:0.633 green:0.000 blue:0.007 alpha:1.000],
                           IMOStyledCellSelectedTopGradientColorKey:    [UIColor redColor],
                           IMOStyledCellNoteViewLineColorKey:           [UIColor colorWithRed:0.541 green:0.313 blue:0.098 alpha:1.000],
                           IMOStyledCellPlaceHolderTextColorKey:        [UIColor colorWithRed:0.775 green:0.509 blue:0.456 alpha:1.000],
                           IMOStyledCellPlaceHolderFontKey:             [UIFont fontWithName:@"TrebuchetMS-Bold" size:14.f]
                           };
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self setUpStyleDictionaries];
    
    ICSheetTableViewController *sheetTableViewController = [[ICSheetTableViewController alloc] initWithStyle:UITableViewStyleGrouped styleSheet:nil];
    [[sheetTableViewController tabBarItem] setTitle:@"Sheet Style"];
    [[sheetTableViewController tabBarItem] setImage:[UIImage imageNamed:@"sheet"]];
    
    ICExampleStylePlainViewController *stylePlainViewController = [[ICExampleStylePlainViewController alloc]
                                                                   initWithStyle:UITableViewStylePlain
                                                                   styleSheet:[self plainStyleSheet]];
    [[stylePlainViewController tabBarItem] setTitle:@"Plain Style"];
    [[stylePlainViewController tabBarItem] setImage:[UIImage imageNamed:@"plain"]];
    
    
    ICExampleStyleGroupedViewController *styleGroupedViewController = [[ICExampleStyleGroupedViewController alloc]
                                                                       initWithStyle:UITableViewStyleGrouped
                                                                       styleSheet:[self groupedStyleSheet]];
    
    [[styleGroupedViewController tabBarItem] setTitle:@"Grouped Style"];
    [[styleGroupedViewController tabBarItem] setImage:[UIImage imageNamed:@"list"]];
    
    
    UINavigationController *plainNavController = [[UINavigationController alloc] initWithRootViewController:stylePlainViewController];
    UINavigationController *groupNavController = [[UINavigationController alloc] initWithRootViewController:styleGroupedViewController];
    UINavigationController *sheetNavController = [[UINavigationController alloc] initWithRootViewController:sheetTableViewController];
        
    NSArray *controllers = @[sheetNavController, plainNavController, groupNavController];
    
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
