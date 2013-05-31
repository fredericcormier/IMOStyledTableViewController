//
//  ICSheetTableViewController.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 29/05/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "ICSheetTableViewController.h"

@interface ICSheetTableViewController ()

@end

@implementation ICSheetTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"My Custom Controller"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}


- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rows = 0;
    switch (section) {
        case 0:
            rows = 7;
            break;
        case 1:
            rows = 1;
            break;
        default:
            break;
    }
    return rows;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMOStyledCell *cell;
    if ([indexPath section] == 0) {
        
        switch ([indexPath row]) {
                //name-------------------------------------------------
            case 0:{
                cell = [IMOStyledEditCell cellForTableViewController:self  atIndexPath:indexPath];
                [[(IMOStyledEditCell *)cell textCaption] setText:@"Product"];
                [[(IMOStyledEditCell *)cell textField] setDelegate:self];
                [[(IMOStyledEditCell *) cell textField] setTag:0];
                [[(IMOStyledEditCell *)cell textField] setPlaceholder:@"Product"];
                
            }
                break;
            case 1:{
                cell = [IMOStyledEditCell cellForTableViewController:self  atIndexPath:indexPath] ;
                [[(IMOStyledEditCell *)cell textCaption] setText:@"Quantity"];
                [[(IMOStyledEditCell *)cell textField] setDelegate:self];
                [[(IMOStyledEditCell *)cell textField] setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                [[(IMOStyledEditCell *) cell textField] setTag:1];
                [[(IMOStyledEditCell *)cell textField] setPlaceholder:@"Quantity"];
            }
                break;
            case 2:{
                cell = [IMOStyledEditCell cellForTableViewController:self  atIndexPath:indexPath ];
                [[(IMOStyledEditCell *)cell textCaption] setText:@"Price"];
                [[(IMOStyledEditCell *)cell textField] setDelegate:self];
                [[(IMOStyledEditCell *) cell textField] setTag:3];
                [[(IMOStyledEditCell *) cell textField] setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                [[(IMOStyledEditCell *)cell textField] setPlaceholder:@"Price"];
            }
                break;
                // Shop------------------------------------------------
            case 3:{
                cell = [IMOStyledCell cellForTableViewController:self  atIndexPath:indexPath style:IMOStyledCellStyleValue1];
                [[(IMOStyledCell  *)cell textLabel] setText:@"Shop"];
                
                [[(IMOStyledCell  *)cell detailTextLabel] setText:@"Shop"];
                
                
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
                break;
                // Category-------------------------------------------------
            case 4:{
                cell = [IMOStyledCell  cellForTableViewController:self  atIndexPath:indexPath style:IMOStyledCellStyleValue1];
                [[(IMOStyledCell  *)cell textLabel] setText:@"Category"];
                [[(IMOStyledCell  *)cell detailTextLabel] setText:@"Unknown"];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
                break;
                
                // priority ---------------------------------------------------
            case 5: {
                cell = [IMOStyledImageCell cellForTableViewController:self  atIndexPath:indexPath];
                [[(IMOStyledImageCell *)cell textLabel] setText:@"Priority"];
                [[(IMOStyledImageCell *)cell customImageView] setImage:[UIImage imageNamed:@"3StarBig"]];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
                break;
            case 6:{
                cell = [IMOStyledCell  cellForTableViewController:self  atIndexPath:indexPath style:IMOStyledCellStyleDefault];
                [[cell textLabel] setText:@"More"];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            default:
                break;
        }
    }
    
    if ([indexPath section] == 1 && [indexPath row] == 0) {
        cell = [IMOStyledCell  cellForTableViewController:self  atIndexPath:indexPath style:IMOStyledCellStyleDefault];
        
#ifdef __IPHONE_6_0
        [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
#else
        [[cell textLabel] setTextAlignment:UITextAlignmentCenter];
#endif
        
        [[cell textLabel] setText:@"Save as favorite..."];
    }
    return cell;
}


@end
