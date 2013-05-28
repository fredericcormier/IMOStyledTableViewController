//
//  ICTestKeys.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 02/04/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "ICTestKeys.h"
#import "IMOStyledCellKeys.h"

@implementation ICTestKeys

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testKeyValidity
{
    STAssertTrue([[IMOStyledCellKeys sharedManager] isValidKey:@"IMOStyledCellNoteViewFontKey"], @" The key IMOStyledCellNoteViewFontKey is valid");
    STAssertTrue([[IMOStyledCellKeys sharedManager] isValidKey:@"IMOStyledCellHeaderFontKey"], @" The key IMOStyledCellNoteViewFontKey is valid");
    STAssertFalse([[IMOStyledCellKeys sharedManager] isValidKey:@"ThisIsNotACorrectKey"], @"This is not correct key");
}

- (void)testStatementArity {
    STAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:@"IMOStyledCellTextLabelFontKey"], 2, @"IMOStyledCellTextLabelFontKey has 2 arguments");
    STAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:IMOStyledCellNoteViewLineColorKey], 1, @"IMOStyledCellTextLabelFontKey has 1 arguments");
    STAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:IMOStyledCellFooterFontKey], 2, @"IMOStyledCellFooterFontKey has 2 arguments");
    STAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:@"NotAkey"], 0, @"This should return 0");
}

- (void)testTypeChecking {
    STAssertEquals([[IMOStyledCellKeys sharedManager] argumentTypeAtPosition:2 forKey:IMOStyledCellTextLabelFontKey], IMOStyledCellTypeSize, @"The second arguments of IMOStyledCellTextLabelFontKey is a float");
    STAssertEquals([[IMOStyledCellKeys sharedManager] argumentTypeAtPosition:1 forKey:IMOStyledCellTextLabelFontKey], IMOStyledCellTypeFont, @"The first arguments of IMOStyledCellTextLabelFontKey is a string");
    STAssertEquals([[IMOStyledCellKeys sharedManager] argumentTypeAtPosition:2 forKey:IMOStyledCellTopSeparatorColorKey], IMOStyledCellTypeUnknown, @"The second argument of IMOStyledCellTextLabelFontKey does not exist");
}



@end
