//
//  IMOStyledNoteViewCell.m
//
//
//  Created by Cormier Frederic on 12/07/12.
//  Copyright (c) 2012 International MicrOondes. All rights reserved.
//

#import "IMOStyledNoteViewCell.h"

#define defaultNoteViewFont         [UIFont boldSystemFontOfSize:14.0f];
#define defaultNoteViewFontColor    [UIColor colorWithRed:0.124 green:0.062 blue:0.000 alpha:1.000]
#define defaultNoteViewLineColor    [UIColor colorWithWhite:0.888 alpha:1.000]


@interface IMOStyledNoteView : UITextView
@property(nonatomic, strong)UIColor *lineColor;
- (id)initWithFrame:(CGRect)frame accessoryToolBarColor:(UIColor *)toolbarColor;
@end


#pragma mark - NoteViewCell

@interface IMOStyledNoteViewCell()

@property(nonatomic, strong)UIFont *noteFont;
@property(nonatomic, strong)UIColor *fontColor;
@property(nonatomic, strong)UIColor *lineColor;
@property(nonatomic, strong)IMOStyledNoteView *noteView;
@property(nonatomic, strong)UIColor *toolbarColor;

@end

@implementation IMOStyledNoteViewCell
@synthesize noteFont = noteFont_;
@synthesize fontColor = fontColor_;
@synthesize lineColor = lineColor_;
@synthesize noteView = noteView_;
@synthesize toolbarColor = toolbarColor_;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           position:(IMOStyledCellPosition)cellPosition
         styleSheet:(NSDictionary *)styleSheet {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier position:cellPosition styleSheet:styleSheet];
    if (self) {
        
        noteFont_ = [styleSheet objectForKey:IMOStyledCellNoteViewFontKey] ?: defaultNoteViewFont;
        fontColor_ = [styleSheet objectForKey:IMOStyledCellNoteViewTextColorKey] ?: defaultNoteViewFontColor;
        lineColor_ = [styleSheet objectForKey:IMOStyledCellNoteViewLineColorKey] ?: defaultNoteViewLineColor;
        toolbarColor_ = [styleSheet objectForKey:IMOStyledCellNavBarTintColorKey];
        
        noteView_ = [[IMOStyledNoteView alloc] initWithFrame:CGRectZero accessoryToolBarColor:toolbarColor_];
        [[self contentView] addSubview:[self noteView]];
        [self setBackgroundColor:[UIColor clearColor]];
        
        [[self noteView] setFont:[self noteFont]];
        [[self noteView] setTextColor:[self fontColor]];
        [[self noteView] setLineColor:[self lineColor]];
    }
    return self;
}

- (NSString *)noteText {
    return [[self noteView] text];
}


- (void)setNoteText:(NSString *)aText {
    [[self noteView] setText:aText];
}



- (void)layoutSubviews {
    CGFloat kDistanceFromBorder = 30.f;
    CGFloat kHeightPad = 2.f;
    CGFloat kiPadGap;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        kiPadGap = 43.f;
    else
        kiPadGap = 10.f;
    

    [super layoutSubviews];
    
    CGRect noteViewRect = CGRectMake(round(kDistanceFromBorder),
                                     round(kHeightPad),
                                     round([self bounds].size.width - ((kiPadGap + kDistanceFromBorder) * 2 )),
                                     round([self bounds].size.height - (kHeightPad * 2)));
    
     [[self noteView] setFrame:noteViewRect];
}

@end

/**********************************************************************************************/

#pragma mark - NoteView

@implementation IMOStyledNoteView

- (id)initWithFrame:(CGRect)frame accessoryToolBarColor:(UIColor *)toolbarColor{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setContentMode:UIViewContentModeRedraw];
        [self setInputAccessoryView:[self accessoryToolBar]];
        if (toolbarColor) {
            [(UIToolbar *)[self inputAccessoryView] setTintColor:toolbarColor];
        }
    }
    return self;
}




- (UIToolbar *)accessoryToolBar {
    UIToolbar *accessoryBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 44.0f)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:NULL action:NULL];
    [accessoryBar setItems:@[flexButton, doneButton]];
    return accessoryBar;
}


- (void)done:(id)sender {
    [self resignFirstResponder];
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [self lineColor].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    //Start a new Path
    CGContextBeginPath(context);
    
    NSUInteger numberOfLines = (self.contentSize.height + self.bounds.size.height) / self.font.leading;
    CGFloat baselineOffset = 6.0f;
    
    for (int x = 1; x < numberOfLines; x++) {
        CGContextMoveToPoint(context, self.bounds.origin.x, self.font.leading*x + 0.5f + baselineOffset);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.font.leading*x + 0.5f + baselineOffset);
    }
    
    CGContextClosePath(context);
    CGContextStrokePath(context);
}
@end
