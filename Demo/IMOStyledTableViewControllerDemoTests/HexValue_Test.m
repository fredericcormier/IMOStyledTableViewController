//
//  HexValue_Test.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 09/04/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "HexValue_Test.h"
#import "IMOStyledParser.h"
#import "UIColor+equality.h"

@interface HexValue_Test()
@property(nonatomic, strong)NSString *hex17;
@property(nonatomic, strong)NSString *hex10;
@property(nonatomic, strong)NSString *maxHex;


@end



@implementation HexValue_Test


- (void)setUp{
    [super setUp];
    _hex17 = @"0x000012";
    _hex10 = @"0x00000A";
    _maxHex = @"0xFFFFFF";
}

- (void)tearDown{
    [super tearDown];
}


- (void)testHexValueFromString {
    double hexValue;
    NSScanner *scanner = [NSScanner scannerWithString:[self hex17]];
    [scanner scanHexDouble:&hexValue];
    XCTAssertTrue(hexValue == 18, @"hex 18 is %f", hexValue);
    
    NSScanner *scanner2 = [NSScanner scannerWithString:[self hex10]];
    [scanner2 scanHexDouble:&hexValue];
    XCTAssertTrue(hexValue == 10, @"hex 10 is %f", hexValue);

    NSScanner *scanner3 = [NSScanner scannerWithString:[self maxHex]];
    [scanner3 scanHexDouble:&hexValue];
    XCTAssertTrue(hexValue == 16777215, @"maxhex is %f", hexValue);

}



- (void)testStringToHexHelper {
    
    XCTAssertEquals([[self hex10] hexDoubleValue], 10.0, @"helper should return 10");
    XCTAssertEquals([[self maxHex] hexDoubleValue], 16777215.0, @"helper should return 16777215");
    
    XCTAssertEquals([[self hex10] hexIntegerValue], 10, @"helper should return 10");
    XCTAssertEquals([[self maxHex] hexIntegerValue], 16777215, @"helper should return 16777215");
}



- (void)testUIColorFromHex {
    UIColor *colorFromHex = UIColorFromRGB([@"0x000000" hexIntegerValue]);
    XCTAssertTrue([colorFromHex isEqualToColor: [UIColor blackColor]], @"this should be black");
    
    UIColor *color2FromHex = UIColorFromRGB([@"0xFFFFFF" hexIntegerValue]);
    XCTAssertTrue([color2FromHex isEqualToColor: [UIColor whiteColor]], @"This should be white");
    
    UIColor *color3FromHex = UIColorFromRGB([@"0xFF6400" hexIntegerValue]);
    UIColor *expectedRGB = [UIColor colorWithRed:1 green:0.392157 blue:0 alpha:1];
    NSLog(@"color 3 %@", color3FromHex);
    NSLog(@"expected color %@", expectedRGB);
    XCTAssertTrue([color3FromHex isSameColorComponents:expectedRGB], @"This is some sort of Orange");
    
}

- (void)testColorHexCase {

    XCTAssertTrue([UIColorFromRGB([@"0xFFFFFF" hexIntegerValue]) isSameColorComponents:UIColorFromRGB([@"0xffffff" hexIntegerValue]  )], @"Case does not matter");
}
@end
