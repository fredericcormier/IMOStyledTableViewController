//
//  IMOStyledImageCell.m
//  
//
//  Created by Frederic Cormier on 22/02/13.
//  Copyright (c) 2013 International MicrOondes. All rights reserved.
//

#import "IMOStyledImageCell.h"

@implementation IMOStyledImageCell
@synthesize customImageView = customImageView_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier position:(IMOStyledCellPosition)cellPosition styleSheet:(NSDictionary *)styleSheet {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier position:cellPosition styleSheet:styleSheet] ) {
        customImageView_ = [[UIImageView alloc] initWithFrame:CGRectZero];
        [customImageView_ setOpaque:NO];
        [customImageView_ setContentMode:UIViewContentModeCenter];
        [[self contentView] addSubview:[self customImageView]];
        [[self contentView] setOpaque:NO];
    }
    return self;
}



- (void)layoutSubviews {
    
    const CGFloat H = [[self contentView] bounds].size.height;
    const CGFloat W = [[self contentView] bounds].size.width;
    const CGFloat START = 130.f;
    const CGFloat GAP = 10.f;
    
    [super layoutSubviews];
    
    CGRect imageViewRect = CGRectMake(round(START),
                                      round(0),
                                      round(W -(START + (GAP * 2))),
                                      round(H));
    [[self customImageView] setFrame:imageViewRect];
}

@end
