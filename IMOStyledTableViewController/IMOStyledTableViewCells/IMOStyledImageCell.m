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
        [customImageView_ setContentMode:UIViewContentModeRight];
        [[self contentView] addSubview:[self customImageView]];
        [[self contentView] setOpaque:NO];
    }
    return self;
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    const CGFloat H = [[self contentView] bounds].size.height;
    const CGFloat W = [[self contentView] bounds].size.width;
    const CGFloat IMAGE_W = 230.f;
    
    
    
    CGRect imageViewRect = CGRectMake(round(W -IMAGE_W),
                                      round(0),
                                      round(IMAGE_W),
                                      round(H));
    [[self customImageView] setFrame:imageViewRect];
//    NSLog(@"W:%f, H:%f Image Rect%@",W, H, NSStringFromCGRect (imageViewRect));
}

@end
