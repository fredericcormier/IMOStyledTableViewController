//
//  IMOStyledCell.m
// //
//  Created by Cormier Frederic on 12/07/12.
//  Copyright (c) 2012 International MicrOondes. All rights reserved.
//

#import "IMOStyledCell.h"
#import  "IMOStyledTableViewController.h"



#define defaultSelectedGradientTopColor         [UIColor colorWithRed:0.183 green:0.419 blue:0.920 alpha:1.000]
#define defaultSelectedGradientBottomColor      [UIColor colorWithRed:0.147 green:0.195 blue:0.834 alpha:1.000]
#define defaultGradientTopColor                 [UIColor whiteColor]
#define defaultGradientBottomColor              [UIColor whiteColor]

#define defaultTextLabelFont                    [UIFont boldSystemFontOfSize:17.0]
#define defaultDetailTextLabelFont              [UIFont boldSystemFontOfSize:11.0]

#define defaultTextLabelTextColor               [UIColor blackColor]
#define defaultDetailTextLabelTextColor         [UIColor colorWithRed:0.588 green:0.631 blue:0.702 alpha:1.000]

#define defaultTopSeparatorColor                [UIColor colorWithRed:0.821 green:0.817 blue:0.798 alpha:1.000];
#define defaultBottomSeparatorColor             [UIColor colorWithRed:0.845 green:0.840 blue:0.821 alpha:1.000];

enum IMOStyledCellSeparatorType {
    IMORoundedSeparator,
    IMOFlatSeparator
};
typedef enum IMOStyledCellSeparatorType IMOStyledCellSeparatorType;


//Forward declaration
@interface IMOSelectedCellBackgroundView : UIView

@property(nonatomic,assign) IMOStyledCellPosition position;

- (id)initWithFrame:(CGRect)frame
       cellPosition:(IMOStyledCellPosition)aPosition
   topGradientColor:(UIColor *)theTopColor
bottomGradientColor:(UIColor *)theBottomColor;

@end



/**************************************************************************************************************
 
 
 IMOStyledCell
 
 */
#pragma mark - IMOStyledCell

static NSArray *cellPositionStrings;


@interface IMOStyledCell()

@property(nonatomic, strong)UIColor *gradientTopColor;
@property(nonatomic, strong)UIColor *gradientBottomColor;
@property(nonatomic, strong)UIColor *topSeparatorColor;
@property(nonatomic, strong)UIColor *bottomSeparatorColor;
@property(nonatomic, strong)UIColor *gradientSelectedTopColor;
@property(nonatomic, strong)UIColor *gradientSelectedBottomColor;
@property(nonatomic, strong)UIColor *textLabelTextColor;
@property(nonatomic, strong)UIColor *detailTextLabelTextColor;
@property(nonatomic, strong)UIFont *textLabelFont;
@property(nonatomic, strong)UIFont *detailTextLabelFont;
@property(nonatomic, assign)BOOL doDrawSeparators;

@end




@implementation IMOStyledCell {
    
    IMOStyledCellPosition position;
    CGGradientRef gradient;
}

@synthesize gradientTopColor = gradientTopColor_;
@synthesize gradientBottomColor = gradientBottomColor_;
@synthesize topSeparatorColor = topSeparatorColor_;
@synthesize bottomSeparatorColor = bottomSeparatorColor_;
@synthesize gradientSelectedTopColor = gradientSelectedTopColor_;
@synthesize gradientSelectedBottomColor = gradientSelectedBottomColor_;
@synthesize textLabelTextColor = textLabelTextColor_;
@synthesize detailTextLabelTextColor = detailTextLabelTextColor_;
@synthesize textLabelFont = textLabelFont_;
@synthesize detailTextLabelFont = detailTextLabelFont_;
@synthesize doDrawSeparators = doDrawSeparators_;




/*  Sublasses may override this one and must call super's implementation */
- (void)setUpCellStyleSheet:(NSDictionary *)sheet {
    topSeparatorColor_ = [sheet objectForKey:IMOStyledCellTopSeparatorColorKey];
    bottomSeparatorColor_ = [sheet objectForKey:IMOStyledCellBottomSeparatorColorKey];
    if (bottomSeparatorColor_ == nil && topSeparatorColor_ == nil) {
        doDrawSeparators_ = NO;
    }else{
        doDrawSeparators_ = YES;
    }
    gradientTopColor_ = [sheet objectForKey:IMOStyledCellTopGradientColorKey] ?: defaultGradientTopColor;
    gradientBottomColor_ = [sheet objectForKey:IMOStyledCellBottomGradientColorKey] ?: defaultGradientBottomColor;
    gradientSelectedTopColor_ = [sheet objectForKey:IMOStyledCellSelectedTopGradientColorKey] ?: defaultSelectedGradientTopColor;
    gradientSelectedBottomColor_ = [sheet objectForKey:IMOStyledCellSelectedBottomGradientColorKey] ?: defaultSelectedGradientBottomColor;
    textLabelTextColor_ = [sheet objectForKey:IMOStyledCellTextLabelTextColorKey] ?: defaultTextLabelTextColor;
    detailTextLabelTextColor_ = [sheet objectForKey:IMOStyledCellDetailTextLabelTextColorKey] ?: defaultDetailTextLabelTextColor;
    textLabelFont_ = [sheet objectForKey:IMOStyledCellTextLabelFontKey] ?: defaultTextLabelFont;
    detailTextLabelFont_ = [sheet objectForKey:IMOStyledCellDetailTextLabelFontKey] ?: defaultDetailTextLabelFont;
}





/* Returns  an IMOStyledCell with the desired variation */
+ (id)cellForTableViewController:(IMOStyledTableViewController *)controller atIndexPath:(NSIndexPath *)indexPath style:(IMOStyledCellStyle)style {
    
    IMOStyledCellPosition position = [IMOStyledCell locationInSectionOfTableView:[controller tableView] atIndexPath:indexPath];
    
    NSString *cellID = [self cellIdentifierAtPosition:position withStyle:style];
    IMOStyledCell *cell = [[controller tableView] dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[self alloc] initWithCellIdentifier:cellID atPosition:position withStyle:style andStyleSheet:[controller styleSheet]];
    }
    return cell;
}




/* returns the desired IMOStyledCell subclass instance */
+ (id)cellForTableViewController:(IMOStyledTableViewController *)controller atIndexPath:(NSIndexPath *)indexPath {
    return [self cellForTableViewController:controller atIndexPath:indexPath style:IMOStyledCellStyleNeverMind];
}





+ (IMOStyledCellPosition)locationInSectionOfTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([tableView style] == UITableViewStylePlain) {
        return IMOStyledCellPositionPlain;
    }else {
        int rows = [tableView numberOfRowsInSection:[indexPath section]];
        
        if (indexPath.row == 0 && rows == 1) {
            return IMOStyledCellPositionSingle;
        }
        else if (indexPath.row == 0) {
            return IMOStyledCellPositionTop;
        }
        else if (indexPath.row != rows - 1) {
            return IMOStyledCellPositionMiddle;
        }
        else {
            return IMOStyledCellPositionBottom;
        }
    }
}




/*
 Returns the cell identifier
 The identifier is "cell class name"+ position +"cell position in section string"
 ie: IMOStyledCellPositionPlain
 */
+ (NSString *)cellIdentifierAtPosition:(IMOStyledCellPosition)cellPosition withStyle:(IMOStyledCellStyle)style {
    if (nil == cellPositionStrings) {
        cellPositionStrings = [[NSArray alloc] initWithObjects:
                               @"Top",
                               @"Middle",
                               @"Bottom",
                               @"Single",
                               @"Plain", nil];
    }
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@Position%@%d",
                                NSStringFromClass([self class]),
                                [cellPositionStrings objectAtIndex:cellPosition],style];
    return cellIdentifier;
}





- (id)initWithCellIdentifier:(NSString *)cellID atPosition:(IMOStyledCellPosition)cellPosition withStyle:(IMOStyledCellStyle)style andStyleSheet:(NSDictionary *)styleSheet {
    return [self initWithStyle:(UITableViewCellStyle)style reuseIdentifier:cellID position:cellPosition styleSheet:styleSheet];
    
}



/* IMOStyledCell subclasses must override this one
 See IMOStyledEditCell*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier position:(IMOStyledCellPosition)cellPosition styleSheet:(NSDictionary *)styleSheet {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUpCellStyleSheet:styleSheet];
        position = cellPosition;
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        
        NSArray *colors = [NSArray arrayWithObjects:
                           (id)[[self gradientTopColor] CGColor],
                           (id)[[self gradientBottomColor] CGColor],
                           nil];
        CGFloat colorLocations[] = {0,0.99};
        gradient = CGGradientCreateWithColors(rgb, (__bridge CFArrayRef)(colors), colorLocations);
        
        CGColorSpaceRelease(rgb);
        
        [[self textLabel] setFont:[self textLabelFont]];
        [[self textLabel] setTextColor:[self textLabelTextColor]];
        
        [[self detailTextLabel] setTextColor:[self detailTextLabelTextColor]];
        
        [self setSelectedBackgroundView:[[IMOSelectedCellBackgroundView alloc] initWithFrame:[self bounds]
                                                                                cellPosition:cellPosition
                                                                            topGradientColor:[self gradientSelectedTopColor]
                                                                         bottomGradientColor:[self gradientSelectedBottomColor]]];
    }
    return self;
}





- (void)drawCellSeparatorTopType:(IMOStyledCellSeparatorType)topType
                      bottomType:(IMOStyledCellSeparatorType)bottomType
                         context:(CGContextRef)c
                        cellRect:(CGRect)rect {
    
    const CGFloat   LINE_WIDTH = 2.0f;
    const CGFloat   GROUPED_CELL_SEPARATOR_ROUNDED_OFFSET   = 18.f;
    const CGFloat   GROUPED_CELL_SEPARATOR_ROUNDED_WIDTH    = 302.f;
    
    const CGFloat   GROUPED_CELL_SEPARATOR_FLAT_OFFSET      = 10.f;
    const CGFloat   GROUPED_CELL_SEPARATOR_FLAT_WIDTH       = 310.f;
    
    CGFloat tstart, twidth, bstart, bwidth;
    
    if (topType == IMORoundedSeparator) {
        tstart = GROUPED_CELL_SEPARATOR_ROUNDED_OFFSET;
        twidth = GROUPED_CELL_SEPARATOR_ROUNDED_WIDTH;
    }else {
        tstart = GROUPED_CELL_SEPARATOR_FLAT_OFFSET;
        twidth = GROUPED_CELL_SEPARATOR_FLAT_WIDTH;
    }
    
    if (bottomType == IMORoundedSeparator) {
        bstart = GROUPED_CELL_SEPARATOR_ROUNDED_OFFSET;
        bwidth = GROUPED_CELL_SEPARATOR_ROUNDED_WIDTH;
    }else {
        bstart = GROUPED_CELL_SEPARATOR_FLAT_OFFSET;
        bwidth = GROUPED_CELL_SEPARATOR_FLAT_WIDTH;
    }
    
    // Top Separator
    CGContextSetStrokeColorWithColor(c, [[self topSeparatorColor] CGColor]);
    CGContextSetLineWidth(c, LINE_WIDTH);
    CGContextSetLineCap(c, kCGLineCapSquare);
    CGContextMoveToPoint(c, tstart, 0.0);
    CGContextAddLineToPoint(c, twidth, 0);
    CGContextStrokePath(c);
    
    //Bottom Separator
    CGContextSetStrokeColorWithColor(c, [[self bottomSeparatorColor] CGColor]);
    CGContextSetLineWidth(c, LINE_WIDTH);
    CGContextSetLineCap(c, kCGLineCapSquare);
    CGContextMoveToPoint(c, bstart, rect.size.height);
    CGContextAddLineToPoint(c, bwidth, rect.size.height);
    CGContextStrokePath(c);
}




-(void)drawRect:(CGRect)rect {
    
    const CGFloat   LINE_WIDTH      = 2.0f;
    const NSInteger CORNER_RADIUS   = 8;
    
    const BOOL TABLE_VIEW_IS_STYLE_GROUPED = [(UITableView *)[ self superview] style] == UITableViewStyleGrouped;
    
    
    if (TABLE_VIEW_IS_STYLE_GROUPED) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            rect = CGRectInset(rect, 45.f, 0);
        }else{
            rect = CGRectInset(rect, 10.f, 0);
        }
    }
    
    const CGFloat MINX = CGRectGetMinX(rect) , MIDX = CGRectGetMidX(rect), MAXX = CGRectGetMaxX(rect) ;
    const CGFloat MINY = CGRectGetMinY(rect) , MIDY = CGRectGetMidY(rect) , MAXY = CGRectGetMaxY(rect) ;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (position) {
        case IMOStyledCellPositionTop:
            CGContextMoveToPoint(context, MINX, MAXY);
            CGContextAddArcToPoint(context, MINX, MINY, MIDX, MINY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MINY, MAXX, MAXY, CORNER_RADIUS);
            CGContextAddLineToPoint(context, MAXX, MAXY);
            
            CGContextClosePath(context);
            
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            if ([self doDrawSeparators]) {
                [self drawCellSeparatorTopType:IMORoundedSeparator bottomType:IMOFlatSeparator context:context cellRect:rect];
            }
            break;
            
        case IMOStyledCellPositionBottom:
            CGContextMoveToPoint(context, MINX, MINY);
            CGContextAddArcToPoint(context, MINX, MAXY, MIDX, MAXY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MAXY, MAXX, MINY, CORNER_RADIUS);
            CGContextAddLineToPoint(context, MAXX, MINY);
            
            CGContextClosePath(context);
            
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            if ([self doDrawSeparators]) {
                [self drawCellSeparatorTopType:IMOFlatSeparator bottomType:IMORoundedSeparator context:context cellRect:rect];
            }
            break;
            
        case IMOStyledCellPositionMiddle:
            CGContextMoveToPoint(context, MINX, MINY);
            CGContextAddLineToPoint(context, MAXX, MINY);
            CGContextAddLineToPoint(context, MAXX, MAXY);
            CGContextAddLineToPoint(context, MINX, MAXY);
            
            CGContextClosePath(context);
            
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            if ([self doDrawSeparators]) {
                [self drawCellSeparatorTopType:IMOFlatSeparator bottomType:IMOFlatSeparator context:context cellRect:rect];
            }
            break;
            
        case IMOStyledCellPositionSingle:
            CGContextMoveToPoint(context, MINX, MIDY);
            CGContextAddArcToPoint(context, MINX, MINY, MIDX, MINY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MINY, MAXX, MIDY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MAXY, MIDX, MAXY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MINX, MAXY, MINX, MIDY, CORNER_RADIUS);
            
            CGContextClosePath(context);
            
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            if ([self doDrawSeparators]) {
                [self drawCellSeparatorTopType:IMORoundedSeparator bottomType:IMORoundedSeparator context:context cellRect:rect];
            }
            break;
            
        case IMOStyledCellPositionPlain:
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY -1.f), CGPointMake(MINX,MAXY -1.f), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            if ([self doDrawSeparators]) {
                CGContextSetStrokeColorWithColor(context, [[self topSeparatorColor] CGColor]);
                CGContextSetLineWidth(context, LINE_WIDTH);
                CGContextSetLineCap(context, kCGLineCapSquare);
                CGContextMoveToPoint(context, 0.0, 0.0);
                CGContextAddLineToPoint(context, rect.size.width, 0);
                CGContextStrokePath(context);
                
                //Bottom Separator
                CGContextSetStrokeColorWithColor(context, [[self bottomSeparatorColor] CGColor]);
                CGContextSetLineWidth(context, LINE_WIDTH);
                CGContextSetLineCap(context, kCGLineCapSquare);
                CGContextMoveToPoint(context, 0.0, rect.size.height);
                CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
                CGContextStrokePath(context);
            }
            break;
            
        default:
            break;
    }
}





- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    //    NSLog(@"Editing %d", editing);
    if (editing == YES) {
        [self setSelectedBackgroundView:nil];
    }else{
        [self setSelectedBackgroundView:[[IMOSelectedCellBackgroundView alloc] initWithFrame:[self bounds]
                                                                                cellPosition:position
                                                                            topGradientColor:[self gradientSelectedTopColor]
                                                                         bottomGradientColor:[self gradientSelectedBottomColor]]];
    }
}



- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    
    UIImage *disclosureImage = [UIImage imageNamed:IMOStyledCellDisclosureImageName];
    UIImage *checkmarkImage = [UIImage imageNamed:IMOStyledCellCheckmarkImageName];
    
    if (accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        if (nil == disclosureImage) {
            [super setAccessoryType:accessoryType];
            return;
        }else {
            UIImageView *disclosureView = [[UIImageView alloc] initWithFrame:(CGRect){0,0, disclosureImage.size}];
            [disclosureView setImage:disclosureImage];
            [self setAccessoryView:disclosureView];
        }
    }else if (accessoryType == UITableViewCellAccessoryCheckmark) {
        if (nil == checkmarkImage) {
            [super setAccessoryType:accessoryType];
            return;
        }else{
            UIImageView *checkmarkView = [[UIImageView alloc] initWithFrame:(CGRect){0,0, checkmarkImage.size}];
            [checkmarkView setImage:checkmarkImage];
            [self setAccessoryView:checkmarkView];
        }
    }else{
        [super setAccessoryType:accessoryType];
    }
}


@end


#pragma mark - IMOSelectedBackgroundView

/***********************************************************************************************
 
 
 
 
 IMOSelectedCellBackgroundView
 
 
 
 */



#define defaultTopUIColor      [UIColor colorWithRed:0.020 green:0.549 blue:0.961 alpha:1.000]
#define defaultBottomUIColor   [UIColor colorWithRed:0.004 green:0.365 blue:0.902 alpha:1.000]


@interface IMOSelectedCellBackgroundView(){
    const float *topCol, *bottomCol;
    CGGradientRef gradient;
}

@end


@implementation IMOSelectedCellBackgroundView

@synthesize position;
/* Otherwise rounded corners will let pass the background residue underneath*/
- (BOOL) isOpaque{
    return NO;
}


- (id)initWithFrame:(CGRect)frame
       cellPosition:(IMOStyledCellPosition)aPosition
   topGradientColor:(UIColor *)theTopColor
bottomGradientColor:(UIColor *)theBottomColor {
    
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        topCol = CGColorGetComponents([theTopColor CGColor]);
        bottomCol = CGColorGetComponents([theBottomColor CGColor]);
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        
        NSArray *colors = [NSArray arrayWithObjects:(id)[theTopColor CGColor], (id)[theBottomColor CGColor], nil];
        CGFloat colorLocations[] = {0.0,1.0};
        gradient = CGGradientCreateWithColors(rgb, (__bridge CFArrayRef)colors, colorLocations);
        
        CGColorSpaceRelease(rgb);
        
        position = aPosition;
    }
    return self;
    
}



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self  = [self initWithFrame:frame
                       cellPosition:IMOStyledCellPositionPlain
                   topGradientColor:defaultTopUIColor
                bottomGradientColor:defaultBottomUIColor];
    }
    return self;
}



-(void)drawRect:(CGRect)rect {
    
    const int CORNER_RADIUS = 6;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    const CGFloat MINX = CGRectGetMinX(rect) , MIDX = CGRectGetMidX(rect), MAXX = CGRectGetMaxX(rect) ;
    const CGFloat MINY = CGRectGetMinY(rect) , MIDY = CGRectGetMidY(rect), MAXY = CGRectGetMaxY(rect) ;
    
    switch (position) {
        case IMOStyledCellPositionTop:
            CGContextMoveToPoint(context, MINX, MAXY);
            CGContextAddArcToPoint(context, MINX, MINY, MIDX, MINY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MINY, MAXX, MAXY, CORNER_RADIUS);
            CGContextAddLineToPoint(context, MAXX, MAXY);
            CGContextClosePath(context);
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            break;
            
        case IMOStyledCellPositionBottom:
            CGContextMoveToPoint(context, MINX, MINY);
            CGContextAddArcToPoint(context, MINX, MAXY, MIDX, MAXY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MAXY, MAXX, MINY, CORNER_RADIUS);
            CGContextAddLineToPoint(context, MAXX, MINY);
            CGContextClosePath(context);
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            break;
            
        case IMOStyledCellPositionMiddle:
            CGContextMoveToPoint(context, MINX, MINY);
            CGContextAddLineToPoint(context, MAXX, MINY);
            CGContextAddLineToPoint(context, MAXX, MAXY);
            CGContextAddLineToPoint(context, MINX, MAXY);
            CGContextClosePath(context);
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            break;
        case IMOStyledCellPositionSingle:
            CGContextMoveToPoint(context, MINX, MIDY);
            CGContextAddArcToPoint(context, MINX, MINY, MIDX, MINY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MINY, MAXX, MIDY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MAXX, MAXY, MIDX, MAXY, CORNER_RADIUS);
            CGContextAddArcToPoint(context, MINX, MAXY, MINX, MIDY, CORNER_RADIUS);
            CGContextClosePath(context);
            CGContextSaveGState(context);
            CGContextClip(context);
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            CGContextRestoreGState(context);
            
            break;
        case IMOStyledCellPositionPlain:
            CGContextDrawLinearGradient(context, gradient, CGPointMake(MINX,MINY), CGPointMake(MINX,MAXY), kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
            break;
            
        default:
            break;
    }
}



- (void)dealloc {
    CGGradientRelease(gradient);
}



- (void) setPosition:(IMOStyledCellPosition)inPosition{
    if([self position] != inPosition){
        [self setPosition:inPosition];
        [self setNeedsDisplay];
    }
}

@end