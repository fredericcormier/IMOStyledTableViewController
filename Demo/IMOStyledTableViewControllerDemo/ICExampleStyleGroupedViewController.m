//
//  ICExampleStyleGroupedViewController.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 14/02/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "ICExampleStyleGroupedViewController.h"


enum cellEditTags {
    editNameCell,
    editPasswordCell
};
typedef enum cellEditTags cellEditTags;



@interface ICExampleStyleGroupedViewController ()

@end

@implementation ICExampleStyleGroupedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"Grouped Style Demo"];
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Headers and Footers
// resize at will
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

// Set the Header text before returning parent's method
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    [self setHeaderText:[NSString stringWithFormat:@"\tSection %d", section]];
    return [super tableView:tableView viewForHeaderInSection:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        [self setFooterText:@"\t\tI'm Footer 0"];
    }else {
        [self setFooterText:[NSString stringWithFormat:@"\t\tBlahblahblah…"]];
    }
    return [super tableView:tableView viewForFooterInSection:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 2 && [indexPath row] == 0) {
        return 120.0f;
    }else{
        return 44.0f;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell;
    if ([indexPath section] == 0) {
        cell = [IMOStyledCell cellForTableViewController:self atIndexPath:indexPath style:IMOStyledCellStyleValue1];
        [[cell textLabel] setText:@"textLabel"];
        [[cell detailTextLabel] setText:@"detailTextLabel"];
        
    }
    if ([indexPath section] == 1) {
        switch ([indexPath row]) {
            case 0:
                cell = [IMOStyledEditCell cellForTableViewController:self atIndexPath:indexPath];
                [[cell textCaption] setText:@"textCaption:"];
                [[cell textField] setPlaceholder:@"textField"];
                [cell setTag:editNameCell];
                [[cell textField] setDelegate:self];
                break;
            case 1:
                cell = [IMOStyledEditCell cellForTableViewController:self atIndexPath:indexPath];
                [[cell textCaption] setText:@"password:"];
                [[cell textField] setPlaceholder:@"XXXXXXXXXXXXX"];
                [[cell textField] setSecureTextEntry:YES];
                [cell setTag:editPasswordCell];
                [[cell textField] setDelegate:self];
                break;
                
            default:
                break;
        }
    }
    if ([indexPath section] == 2) {
        switch ([indexPath row]) {
            case 0:
                cell = [IMOStyledNoteViewCell cellForTableViewController:self atIndexPath:indexPath ];
                break;
                
            default:
                cell = [IMOStyledCell cellForTableViewController:self atIndexPath:indexPath style:IMOStyledCellStyleValue1];
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                
                break;
        }
    }
    
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
