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
CGFloat separator_X;


- (void)setUpCellStyleSheet:(NSDictionary *)sheet {
    [super setUpCellStyleSheet:sheet];
    _textfieldFont = [sheet objectForKey:IMOStyledCellTextFieldFontKey] ?: defaultTextFieldFont;
    _textfieldFontColor = [sheet objectForKey:IMOStyledCellTextFieldTextColorKey] ?: defaultTextFieldColor;
    _textCaptionFont = [sheet objectForKey:IMOStyledCellTextCaptionFontKey] ?: defaultCaptionFont;
    _textCaptionFontColor = [sheet objectForKey:IMOStyledCellTextCaptionTextColorKey] ?: defaultCaptionColor;
    
    // separators uses the bottom and top gradient colors
    _leftSeparatorColor = [sheet objectForKey:IMOStyledCellBottomGradientColorKey] ?: [UIColor colorWithWhite:0.838 alpha:1.000];
    _rightSeparatorColor = [sheet objectForKey:IMOStyledCellTopGradientColorKey] ?: [UIColor colorWithWhite:0.983 alpha:1.000];
    
    _placeHolderFont = [sheet objectForKey:IMOStyledCellPlaceHolderFontKey];
    _placeHolderTextColor = [sheet objectForKey:IMOStyledCellPlaceHolderTextColorKey];
}



- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           position:(IMOStyledCellPosition)cellPosition
         styleSheet:(NSDictionary *)styleSheet{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier position:cellPosition styleSheet:styleSheet];
    if (self) {
        _textField = [[IMOStyledTextField alloc] initWithFrame:CGRectZero];
        _textCaption = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [[self contentView] addSubview:_textField];
        [[self contentView] addSubview:_textCaption];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        [_textField setBackgroundColor:[UIColor clearColor]];
        [_textField setTextColor:_textfieldFontColor];
        [_textField setFont:_textfieldFont];
        [_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_textField setAdjustsFontSizeToFitWidth:YES];
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textCaption setFont:_textCaptionFont];
        [_textCaption setTextColor:_textCaptionFontColor];
        [_textCaption setBackgroundColor:[UIColor clearColor]];
#ifdef __IPHONE_6_0
        [_textCaption setTextAlignment:NSTextAlignmentRight];
#else
        [textCaption_ setTextAlignment:UITextAlignmentRight];
#endif
        [_textField setOpaque:NO];
        [_textCaption setOpaque:NO];
        [[self contentView] setOpaque:NO];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            separator_X = 137.f;
        }else{
            separator_X = 102.f;
        }

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
    CGContextMoveToPoint(c, separator_X , offsetY);
    CGContextAddLineToPoint(c, separator_X , rect.size.height - offsetY);
    CGContextStrokePath(c);
    
    // right
    CGContextSetStrokeColorWithColor(c, [[self rightSeparatorColor] CGColor]);
    CGContextSetLineWidth(c, LINE_WIDTH);
    CGContextSetLineCap(c, kCGLineCapSquare);
    CGContextMoveToPoint(c, separator_X + 1.f, offsetY);
    CGContextAddLineToPoint(c, separator_X + 1.f, rect.size.height - offsetY);
    CGContextStrokePath(c);
}



- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    const float cellHeight = [self bounds].size.height;
    const float cellWidth = [self bounds].size.width;
    const float accessoryWidth = 22.f;
    const float kPad = 4.f;
    float kiPadGap;
    
    // If we are on an iPad but not in a UIPopoverController
    if(IPAD_SCREEN_SIZE([self bounds])) {
        // running IOS7 ?
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            kiPadGap = -10.f;
        }else{//IOS6 or less
            kiPadGap = 35.f;
        }
    }else{
        kiPadGap = 0;
    }

    
    CGRect textFieldRect = CGRectMake(round((separator_X - kiPadGap)+ (kPad * 1.f)),
                                      round(kPad),
                                      round(((cellWidth / 4.f) * 3.f) - (accessoryWidth +(kPad * 6.f))),
                                      round(cellHeight - (kPad * 2.f )));
    
    [[self textField] setFrame:textFieldRect];
      
    CGRect captionRect = CGRectMake(round(kPad * 2.f),
                                    round(kPad),
                                    round(separator_X -(kPad * 6.f) - kiPadGap),
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
    
    IMOStyledEditCell *cell = [self parentViewContainerOfClass:[IMOStyledEditCell class]];
    UIColor *color  = [cell placeHolderTextColor];
    UIFont *font    = [cell placeHolderFont];
    
    if (color || font) {
        if (color)      [color setFill];
        if (font)       [self setFont:font];
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            // have to do the vertical alignement manually
            NSDictionary *attributes = @{NSFontAttributeName :font,
                                         NSForegroundColorAttributeName :color};
#pragma unused(attributes)
            CGFloat stringHeight = [font pointSize];
            CGFloat verticalPad = (rect.size.height - stringHeight) / 2.f;
            CGRect centeredRect = CGRectMake(rect.origin.x,
                                             verticalPad,
                                             rect.size.width,
                                             rect.size.height - verticalPad);
#pragma unused(centeredRect)
            
#ifdef __IPHONE_7_0
            [[self placeholder] drawInRect:centeredRect withAttributes:attributes];
#endif
        }else{ // IOS6 - deprecated (and broken) in IOS7
            [[self placeholder] drawInRect:rect withFont:[self font]];
        }
    }else{ // No modification: call super
        [super drawPlaceholderInRect:rect];
    }
}
@end

