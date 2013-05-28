//
//  IMOStyledTableViewController.m
//  IMOStyledTableViewController
//
//  Created by Frederic Cormier on 14/02/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "IMOStyledTableViewController.h"
#import "IMOStyledParser.h"

#define DefaultHeaderFont                   [UIFont boldSystemFontOfSize:17.0]
#define DefaultHeaderTextColor              [UIColor blackColor]
#define DefaultFooterFont                   [UIFont boldSystemFontOfSize:14.0]
#define DefaultFooterTextColor              [UIColor colorWithWhite:0.902 alpha:1.000]

@interface IMOStyledTableViewController ()

@property(nonatomic, strong)NSMutableDictionary *sheet;

@property(nonatomic, strong)UIImage *backgroundImage;
@property(nonatomic, assign)BOOL useCustomHeader;
@property(nonatomic, strong)UIFont *headerFont;
@property(nonatomic, strong)UIColor *headerFontColor;
@property(nonatomic, assign)BOOL useCustomFooter;
@property(nonatomic, strong)UIFont *footerFont;
@property(nonatomic, strong)UIColor *footerFontColor;
@end


@implementation IMOStyledTableViewController

@synthesize headerText = headerText_;
@synthesize footerText = footerText_;
@synthesize sheet = sheet_;
@synthesize backgroundImage = backgroundImage_;
@synthesize useCustomHeader = useCustomHeader_;
@synthesize headerFont = headerFont_;
@synthesize headerFontColor = headerFontColor_;
@synthesize useCustomFooter = useCustomFooter_;
@synthesize footerFont = footerFont_;
@synthesize footerFontColor = footerFontColor_;

- (id)initWithStyle:(UITableViewStyle)style {
    return [self initWithStyle:style styleSheet:nil];
}


- (id)initWithStyle:(UITableViewStyle)style styleSheet:(NSDictionary *)styleSheet {
    
    self = [super initWithStyle:style];
    if (self) {
        // start by checking if we have a ".imo" file
        if ([[IMOStyledStyleParser sharedParser] parsedStyleDictionary]) {
            sheet_ = [[IMOStyledStyleParser sharedParser] parsedStyleDictionary];
        }
        
        // If a stylesheet is provided, assign it to sheet_ - possibly erasing previous dictionary
        if (styleSheet) {
            sheet_ = (NSMutableDictionary *)styleSheet;
        }
       backgroundImage_ = [[self sheet] objectForKey:IMOStyledCellBackgroundImageKey];
       useCustomHeader_ = (YES == [[[self sheet] objectForKey:IMOStyledCellUseCustomHeaderKey] boolValue] ) ? YES : NO;
       headerFont_ = [[self sheet] objectForKey:IMOStyledCellHeaderFontKey] ? [[self sheet] objectForKey:IMOStyledCellHeaderFontKey] : DefaultHeaderFont;
       headerFontColor_ = [[self sheet] objectForKey:IMOStyledCellHeaderTextColorKey] ? [[self sheet] objectForKey:IMOStyledCellHeaderTextColorKey] : DefaultHeaderTextColor;
       useCustomFooter_ = (YES ==[[[self sheet] objectForKey:IMOStyledCellUseCustomFooterKey] boolValue]) ? YES : NO;
       footerFont_ = [[self sheet] objectForKey:IMOStyledCellFooterFontKey] ? [[self sheet] objectForKey:IMOStyledCellFooterFontKey] : DefaultFooterFont;
       footerFontColor_ = [[self sheet] objectForKey:IMOStyledCellFooterTextColorKey] ? [[self sheet] objectForKey:IMOStyledCellFooterTextColorKey] : DefaultFooterTextColor;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Only draw the separators for plainstyle when there's no stylesheet
    if ([[self tableView] style] == UITableViewStylePlain && [self sheet] == nil ) {
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }else{
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self backgroundImage]) {
        UIColor *backgroundColor = [UIColor colorWithPatternImage:[self backgroundImage]];
        UIView* backgroundView = [[UIView alloc] init];
        // set the background color or image
        [backgroundView setBackgroundColor:backgroundColor];
        //make it the tableView Background view
        [[self tableView] setBackgroundView:backgroundView];
    }
}




#pragma mark - UITableViewDelegate stuff

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (![self useCustomHeader]) {
        return 0;
    }else{
        return 10.0f;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headerLabel;
    if ([self useCustomHeader] ) {
        headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [headerLabel setBackgroundColor:[UIColor clearColor]];
        [headerLabel setFont:[self headerFont]];
        [headerLabel setTextColor:[self headerFontColor]];
        [headerLabel setText:[self headerText]];
        return headerLabel;
        
    }else{
        return nil;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (![self useCustomFooter]) {
        return 0;
    }else{
        return 10.0f;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *footerLabel;
    if ([self useCustomFooter] ) {
        footerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [footerLabel setBackgroundColor:[UIColor clearColor]];
        [footerLabel setFont:[self footerFont]];
        [footerLabel setTextColor:[self footerFontColor]];
        [footerLabel setText:[self footerText]];
        return footerLabel;
        
    }else{
        return nil;
    }
}



- (NSDictionary *)styleSheet {
    return sheet_;
}



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
