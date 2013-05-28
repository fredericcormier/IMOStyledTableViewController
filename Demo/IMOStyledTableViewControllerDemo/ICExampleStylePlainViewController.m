//
//  ICExampleStylePlainViewController.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 14/02/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "ICExampleStylePlainViewController.h"

@interface ICExampleStylePlainViewController ()

@end

@implementation ICExampleStylePlainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"Plain Style Demo"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IMOStyledCell *cell = [IMOStyledCell cellForTableViewController:self atIndexPath:indexPath style:IMOStyledCellStyleValue1];
    [[cell textLabel] setText:@"TextLabel"];
    [[cell detailTextLabel] setText:@"DetailTextLabel"];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
