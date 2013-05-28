//
//  IMOStyledEditCell.m
//
//
//  Created by Cormier Frederic on 12/07/12.
//  Copyright (c) 2012 International MicrOondes. All rights reserved.
//

#import "IMOStyledEditCell.h"


#define defaultTextFieldFont       [UIFont fontWithName:@"Helvetica" size:16.0]
#define defaultTextFieldColor      [UIColor colorWithRed:0.137 green:0.152 blue:0.177 alpha:1.000]
#define defaultCaptionColor        [UIColor colorWithRed:0.521 green:0.577 blue:0.662 alpha:1.000]
#define defaultCaptionFont         [UIFont boldSystemFontOfSize:11.0]

@interface IMOStyledEditCell()
@property(nonatomic, strong)UIFont *textfieldFont;
@property(nonatomic, strong)UIFont *textCaptionFont;
@property(nonatomic, strong)UIColor *textfieldFontColor;
@property(nonatomic, strong)UIColor *textCaptionFontColor;
@property(nonatomic, strong)UIColor *leftSeparatorColor;
@property(nonatomic, strong)UIColor *rightSeparatorColor;
@end

@implementation IMOStyledEditCell
@synthesize textField = textField_;
@synthesize textCaption = textCaption_;
@synthesize textfieldFont = textfieldFont_;
@synthesize textCaptionFont = textCaptionFont_;
@synthesize textfieldFontColor = textfieldFontColor_;
@synthesize textCaptionFontColor = textCaptionFontColor_;
@synthesize leftSeparatorColor = leftSeparatorColor_;
@synthesize rightSeparatorColor = rightSeparatorColor_;




- (void)setUpCellStyleSheet:(NSDictionary *)sheet {
    [super setUpCellStyleSheet:sheet];
   textfieldFont_ = [sheet objectForKey:IMOStyledCellTextFieldFontKey] ? [sheet objectForKey:IMOStyledCellTextFieldFontKey] : defaultTextFieldFont;
   textfieldFontColor_ = [sheet objectForKey:IMOStyledCellTextFieldTextColorKey] ? [sheet objectForKey:IMOStyledCellTextFieldTextColorKey] : defaultTextFieldColor;
   textCaptionFont_ = [sheet objectForKey:IMOStyledCellTextCaptionFontKey] ? [sheet objectForKey:IMOStyledCellTextCaptionFontKey] : defaultCaptionFont;
   textCaptionFontColor_ = [sheet objectForKey:IMOStyledCellTextCaptionTextColorKey] ? [sheet objectForKey:IMOStyledCellTextCaptionTextColorKey] : defaultCaptionColor;
    
    // separators uses the bottom and top gradient colors for now
    leftSeparatorColor_ = [sheet objectForKey:IMOStyledCellBottomGradientColorKey] ? [sheet objectForKey:IMOStyledCellBottomGradientColorKey] : [UIColor colorWithWhite:0.838 alpha:1.000];
    rightSeparatorColor_ = [sheet objectForKey:IMOStyledCellTopGradientColorKey] ? [sheet objectForKey:IMOStyledCellTopGradientColorKey] : [UIColor colorWithWhite:0.983 alpha:1.000];
}



- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           position:(IMOStyledCellPosition)cellPosition
      styleSheet:(NSDictionary *)styleSheet{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier position:cellPosition styleSheet:styleSheet];
    if (self) {
        textField_ = [[UITextField alloc] initWithFrame:CGRectZero];
        textCaption_ = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [[self contentView] addSubview:textField_];
        [[self contentView] addSubview:textCaption_];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        [textField_ setBackgroundColor:[UIColor clearColor]];
        [textField_ setTextColor:textfieldFontColor_];
        [textField_ setFont:textfieldFont_];
        [textField_ setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [textField_ setAdjustsFontSizeToFitWidth:YES];
        [textField_ setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        [textCaption_ setFont:textCaptionFont_];
        [textCaption_ setTextColor:textCaptionFontColor_];
        [textCaption_ setBackgroundColor:[UIColor clearColor]];
#ifdef __IPHONE_6_0
        [textCaption_ setTextAlignment:NSTextAlignmentRight];
#else
        [textCaption_ setTextAlignment:UITextAlignmentRight];
#endif
        [textField_ setOpaque:NO];
        [textCaption_ setOpaque:NO];
        [[self contentView] setOpaque:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    const CGFloat LINE_WIDTH = 1.f;
    const CGFloat separatorX = 102.f;
    const CGFloat offsetY = 1.f;
    
    [super drawRect:rect];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    // left
    CGContextSetStrokeColorWithColor(c, [[self leftSeparatorColor] CGColor]);
    CGContextSetLineWidth(c, LINE_WIDTH);
    CGContextSetLineCap(c, kCGLineCapSquare);
    CGContextMoveToPoint(c, separatorX , offsetY);
    CGContextAddLineToPoint(c, separatorX , rect.size.height - offsetY);
    CGContextStrokePath(c);
    
    // right
    CGContextSetStrokeColorWithColor(c, [[self rightSeparatorColor] CGColor]);
    CGContextSetLineWidth(c, LINE_WIDTH);
    CGContextSetLineCap(c, kCGLineCapSquare);
    CGContextMoveToPoint(c, separatorX + 1.f, offsetY);
    CGContextAddLineToPoint(c, separatorX + 1.f, rect.size.height - offsetY);
    CGContextStrokePath(c);
    
    
}


- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    const float cellHeight = [self bounds].size.height;
    const float cellWidth = [self bounds].size.width;
    const float accessoryWidth = 22.0;
    const float kPad = 4.0;
    
    CGRect textFieldRect = CGRectMake(round((cellWidth / 4.0) + (kPad * 6.f)),
                                      round(kPad),
                                      round(((cellWidth / 4.0) * 3.0) - (accessoryWidth +(kPad * 6.0))),
                                      round(cellHeight - (kPad * 2.0 )));
    
    [[self textField] setFrame:textFieldRect];
    
    CGRect captionRect = CGRectMake(round(kPad * 2),
                                    round(kPad),
                                    round((cellWidth / 4.0) - kPad),
                                    round(cellHeight - (kPad * 2.0 )));
    
    [[self textCaption] setFrame:captionRect];
}

@end
