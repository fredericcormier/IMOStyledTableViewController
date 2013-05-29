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
@property(nonatomic, strong)UIFont  *placeHolderFont;
@property(nonatomic, strong)UIColor *placeHolderTextColor;
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
@synthesize placeHolderFont = placeHolderFont_;
@synthesize placeHolderTextColor = placeHolderTextColor_;

const CGFloat kSeparator_X = 102.f;


- (void)setUpCellStyleSheet:(NSDictionary *)sheet {
    [super setUpCellStyleSheet:sheet];
    textfieldFont_ = [sheet objectForKey:IMOStyledCellTextFieldFontKey] ? [sheet objectForKey:IMOStyledCellTextFieldFontKey] : defaultTextFieldFont;
    textfieldFontColor_ = [sheet objectForKey:IMOStyledCellTextFieldTextColorKey] ? [sheet objectForKey:IMOStyledCellTextFieldTextColorKey] : defaultTextFieldColor;
    textCaptionFont_ = [sheet objectForKey:IMOStyledCellTextCaptionFontKey] ? [sheet objectForKey:IMOStyledCellTextCaptionFontKey] : defaultCaptionFont;
    textCaptionFontColor_ = [sheet objectForKey:IMOStyledCellTextCaptionTextColorKey] ? [sheet objectForKey:IMOStyledCellTextCaptionTextColorKey] : defaultCaptionColor;
    
    // separators uses the bottom and top gradient colors for now
    leftSeparatorColor_ = [sheet objectForKey:IMOStyledCellBottomGradientColorKey] ? [sheet objectForKey:IMOStyledCellBottomGradientColorKey] : [UIColor colorWithWhite:0.838 alpha:1.000];
    rightSeparatorColor_ = [sheet objectForKey:IMOStyledCellTopGradientColorKey] ? [sheet objectForKey:IMOStyledCellTopGradientColorKey] : [UIColor colorWithWhite:0.983 alpha:1.000];
    
    placeHolderFont_ = [sheet objectForKey:IMOStyledCellPlaceHolderFontKey];
    placeHolderTextColor_ = [sheet objectForKey:IMOStyledCellPlaceHolderTextColorKey];
}



- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           position:(IMOStyledCellPosition)cellPosition
         styleSheet:(NSDictionary *)styleSheet{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier position:cellPosition styleSheet:styleSheet];
    if (self) {
        textField_ = [[IMOStyledTextField alloc] initWithFrame:CGRectZero];
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
    const CGFloat offsetY = 1.f;
    
    [super drawRect:rect];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    // left
    CGContextSetStrokeColorWithColor(c, [[self leftSeparatorColor] CGColor]);
    CGContextSetLineWidth(c, LINE_WIDTH);
    CGContextSetLineCap(c, kCGLineCapSquare);
    CGContextMoveToPoint(c, kSeparator_X , offsetY);
    CGContextAddLineToPoint(c, kSeparator_X , rect.size.height - offsetY);
    CGContextStrokePath(c);
    
    // right
    CGContextSetStrokeColorWithColor(c, [[self rightSeparatorColor] CGColor]);
    CGContextSetLineWidth(c, LINE_WIDTH);
    CGContextSetLineCap(c, kCGLineCapSquare);
    CGContextMoveToPoint(c, kSeparator_X + 1.f, offsetY);
    CGContextAddLineToPoint(c, kSeparator_X + 1.f, rect.size.height - offsetY);
    CGContextStrokePath(c);
}



- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    const float cellHeight = [self bounds].size.height;
    const float cellWidth = [self bounds].size.width;
    const float accessoryWidth = 22.f;
    const float kPad = 4.f;
    
    CGRect textFieldRect = CGRectMake(round(kSeparator_X + (kPad * 1.f)),
                                      round(kPad),
                                      round(((cellWidth / 4.f) * 3.f) - (accessoryWidth +(kPad * 6.f))),
                                      round(cellHeight - (kPad * 2.f )));
    
    [[self textField] setFrame:textFieldRect];
    
    
    CGRect captionRect = CGRectMake(round(kPad * 2.f),
                                    round(kPad),
                                    round(kSeparator_X -(kPad * 6.f)),
                                    round(cellHeight - (kPad * 2.f)));
    
    [[self textCaption] setFrame:captionRect];
}

@end


/**************************************************************************************************************
 
 
            IMOStyledTextField
 
 */
#pragma mark - IMOStyledTextField -


@implementation IMOStyledTextField

- (void) drawPlaceholderInRect:(CGRect)rect {
    
    UIColor *color  = [(IMOStyledEditCell *)[[self superview] superview] placeHolderTextColor];
    UIFont *font    = [(IMOStyledEditCell *)[[self superview] superview] placeHolderFont];
    
    if (color || font) {
        if (color) {
            [color setFill];
        }
        if (font) {
            [self setFont:font];
        }
        [[self placeholder] drawInRect:rect withFont:[self font]];
    }else{
        // No modification: call super
        [super drawPlaceholderInRect:rect];
    }
}
@end

