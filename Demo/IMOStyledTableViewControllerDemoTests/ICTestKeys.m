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
    XCTAssertTrue([[IMOStyledCellKeys sharedManager] isValidKey:@"IMOStyledCellNoteViewFontKey"], @" The key IMOStyledCellNoteViewFontKey is valid");
    XCTAssertTrue([[IMOStyledCellKeys sharedManager] isValidKey:@"IMOStyledCellHeaderFontKey"], @" The key IMOStyledCellNoteViewFontKey is valid");
    XCTAssertFalse([[IMOStyledCellKeys sharedManager] isValidKey:@"ThisIsNotACorrectKey"], @"This is not correct key");
}

- (void)testStatementArity {
    XCTAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:@"IMOStyledCellTextLabelFontKey"], 2, @"IMOStyledCellTextLabelFontKey has 2 arguments");
    XCTAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:IMOStyledCellNoteViewLineColorKey], 1, @"IMOStyledCellTextLabelFontKey has 1 arguments");
    XCTAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:IMOStyledCellFooterFontKey], 2, @"IMOStyledCellFooterFontKey has 2 arguments");
    XCTAssertEquals([[IMOStyledCellKeys sharedManager] arityForKey:@"NotAkey"], 0, @"This should return 0");
}

- (void)testTypeChecking {
    XCTAssertEquals([[IMOStyledCellKeys sharedManager] argumentTypeAtPosition:2 forKey:IMOStyledCellTextLabelFontKey], IMOStyledCellTypeSize, @"The second arguments of IMOStyledCellTextLabelFontKey is a float");
    XCTAssertEquals([[IMOStyledCellKeys sharedManager] argumentTypeAtPosition:1 forKey:IMOStyledCellTextLabelFontKey], IMOStyledCellTypeFont, @"The first arguments of IMOStyledCellTextLabelFontKey is a string");
    XCTAssertEquals([[IMOStyledCellKeys sharedManager] argumentTypeAtPosition:2 forKey:IMOStyledCellTopSeparatorColorKey], IMOStyledCellTypeUnknown, @"The second argument of IMOStyledCellTextLabelFontKey does not exist");
}



@end
