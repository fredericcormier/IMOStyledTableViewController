//
//  IMOStyledCell.h
//  
//
//  Created by Cormier Frederic on 12/07/12.
//  Copyright (c) 2012 International MicrOondes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMOStyledCellKeys.h"


@class IMOStyledTableViewController;

@interface IMOStyledCell : UITableViewCell







+ (id)cellForTableViewController:(IMOStyledTableViewController *)controller atIndexPath:(NSIndexPath *)indexPath style:(IMOStyledCellStyle)style ;
/* Style Variations only apply to IMOStyledCells : 
 IMOStyledCellStyleDefault,
 IMOStyledCellStyleValue1,
 IMOStyledCellStyleValue2,
 IMOStyledCellStyleSubtitle
*/

+ (id)cellForTableViewController:(IMOStyledTableViewController *)controller atIndexPath:(NSIndexPath *)indexPath;
/* No style variation - Use for subclasses */







// subclasses might override this next 2 methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier position:(IMOStyledCellPosition)cellPosition styleSheet:(NSDictionary *)styleSheet;
/* subclasses must override this one in order to set up their properties */

- (void)setUpCellStyleSheet:(NSDictionary *)sheet;
/* subclasses must override this one in order to setup cell styles */
@end



@interface UIView (container)
- (id)parentViewContainerOfClass:(Class)containerClass;
@end


@interface UITableViewCell (tableViewAccess)
- (BOOL)parentTableViewIsGrouped;
- (UITableView *)tableView;
@end
