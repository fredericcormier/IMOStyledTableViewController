//
//  IMOStyledTableViewController.h
//  IMOStyledTableViewController
//
//  Created by Frederic Cormier on 14/02/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMOStyledCell.h"
#import "IMOStyledEditCell.h"
#import "IMOStyledNoteViewCell.h"
#import "IMOStyledImageCell.h"




@interface IMOStyledTableViewController : UITableViewController <UITextFieldDelegate>

@property(nonatomic, copy)NSString *headerText;
@property(nonatomic, copy)NSString *footerText;

- (id)initWithStyle:(UITableViewStyle)style styleSheet:(NSDictionary *)styleSheet;
- (NSDictionary *)styleSheet;
@end
