//
//  IMOUserGraphiteCell.h
//  
//
//  Created by Cormier Frederic on 12/07/12.
//  Copyright (c) 2012 International MicrOondes. All rights reserved.
//

#import "IMOStyledCell.h"

@interface IMOStyledTextField : UITextField
- (void) drawPlaceholderInRect:(CGRect)rect;
@end


@interface IMOStyledEditCell : IMOStyledCell

@property (nonatomic, strong)IMOStyledTextField *textField;
@property (nonatomic, strong)UILabel *textCaption;

@end
