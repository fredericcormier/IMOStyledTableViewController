//
//  IMOStyledParser.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 21/03/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//


#import "IMOStyledParser.h"
#import "IMOStyledCellKeys.h"



#pragma mark - Parser


static NSString * const IMOStyledCellPrefix = @"IMOStyledCell";
static NSString * const IMOStyledCellSuffix = @"Key";
static NSString * const IMOStyledCellCommentSymbol = @"//";


@implementation IMOStyledStyleParser




+ (IMOStyledStyleParser *)sharedParser {
    static dispatch_once_t once;
    static IMOStyledStyleParser *parser;
    dispatch_once(&once, ^ { parser = [[IMOStyledStyleParser alloc] init]; });
    return parser;
}




- (id)init {
    if (self = [super init]) {
        
        NSString *styleFile = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"imo"];
        if (styleFile == nil) {
            return nil;
        }
        
        NSError *error;
        NSString *styleInfo = [NSString stringWithContentsOfFile:styleFile encoding:NSUTF8StringEncoding error:&error];
        if (!styleInfo) {
            NSLog(@"Error reading style %@", [error userInfo]);
            return nil;
        }
        
        _parsedStyleDictionary = [[NSMutableDictionary alloc] init];
        NSArray *statements =[self tokenize:styleInfo];
        
        [self evaluate:statements];
    }
    return self;
}



/*
 In the styleSheet, if the property is named "TopGradientColor then
 IMOStyledCell+TopGradientColor+key => IMOStyledCellTopGradientColorKey
 */

- (NSString *)keyNameForProperty:(NSString *)property {
    return [NSString stringWithFormat:@"%@%@%@", IMOStyledCellPrefix, property, IMOStyledCellSuffix];
}



- (NSArray *)tokenize:(NSString *)info {
    
    NSMutableArray *statements = [[NSMutableArray alloc] init];
    
    NSArray *lines = [info componentsSeparatedByString:@"\n"];
    
    for (NSString *l in lines) {
        /* skip empty lines and Comments - carriage return are already gone*/
        if ([l isEqualToString:@""] || [l hasPrefix:IMOStyledCellCommentSymbol]) {
            continue;
        }
        
        NSArray *lineElements = [l componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [lineElements count]; i++) {
            if (![lineElements[i] isEqualToString:@""]) { // skip spaces
                [tempArray addObject:lineElements[i]];
            }
        }
        [statements addObject:tempArray];
    }
    return statements;
}




- (void)evaluate:(NSArray *)statements {
    
    IMOStyledParserDataType propertyType;
    NSString *propertyKey;
    
    
    for (NSArray *statement in statements) {
        propertyKey = [self keyNameForProperty:statement[0]];
        NSAssert1([[IMOStyledCellKeys sharedManager] isValidKey:propertyKey], @"%@ is not a valid key", propertyKey );
        
        propertyType = [[IMOStyledCellKeys sharedManager] argumentTypeAtPosition:1 forKey:propertyKey];
        // we know the type of th 'i-eth' argument
        switch (propertyType) {
            case IMOStyledCellTypeFont:
                [[self parsedStyleDictionary] setObject:[UIFont fontWithName:statement[1] size:[statement[2] floatValue]] forKey:propertyKey];
                break;
                
            case IMOStyledCellTypeColor:
                
                if ([statement count] > 2) { //RGBA
                    NSAssert([statement count] == 5, @"A color argument is missing for %@", propertyKey);
                    for (int i = 1; i <= 4; i++) {
                        NSAssert1(([statement[i] floatValue] >= 0) && ([statement[i] floatValue] <= 1.f), @"Value out of range for property %@", propertyKey );
                    }
                    [[self parsedStyleDictionary] setObject:[UIColor colorWithRed:[statement[1] floatValue]
                                                                             green:[statement[2] floatValue]
                                                                              blue:[statement[3] floatValue]
                                                                             alpha:[statement[4] floatValue]]
                                                      forKey:propertyKey];
                }else{ //Hexadecimal
                    NSAssert([statement count] == 2, @"Hexadecimal colors take one argument");
                    UIColor *parsedHexColor = [self UIColorFromHexString:statement[1]];
                    if (parsedHexColor) {
                        [[self parsedStyleDictionary] setObject:parsedHexColor forKey:propertyKey];
                    }
                }
                break;
                
            case IMOStyledCellTypeBool:
                [ [self parsedStyleDictionary] setObject:@((BOOL)statement[1]) forKey:propertyKey];
                break;
                
            case IMOStyledCellTypeImage:
                [ [self parsedStyleDictionary] setObject:[UIImage imageNamed:statement[1]] forKey:propertyKey];
                break;
                
            case IMOStyledCellTypeUnknown:
                NSAssert(FALSE, @"We should not get here - IMOStyledCell unknown argument type");
                break;
                
            default:
                break;
        }
    }
    // Mark the dictionary for deletion if it 's empty
    if ([ [self parsedStyleDictionary] count] == 0) {
        [self setParsedStyleDictionary:nil];
    }
}




- (UIColor *) UIColorFromHexString:(NSString *)hexString {
    NSAssert1([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"#"], @"%@ syntax is incorrect, it should start with \"0x\" or \"#\"", hexString);
    
    if ([hexString hasPrefix:@"#"]) {
        NSAssert([hexString length] == 4 || [hexString length] == 7, @"Valid hex numbers prefixed with \"#\" are 3 or 6 digits long");
        NSMutableString *finalString = [[NSMutableString alloc] initWithString:@"0x"];
        for (int i = 1; i < [hexString length]; i++) {
            [finalString appendString:[hexString substringWithRange:NSMakeRange(i, 1)]];
            // deal with css short notation (#FA6 -> #FFAA66) if necessary.
            //  duplicate each hex value.
            if ([hexString length] == 4) {//duplicate
                [finalString appendString:[hexString substringWithRange:NSMakeRange(i, 1)]];
            }
        }
        return UIColorFromRGB([finalString hexIntegerValue]);
    }
    if ([hexString hasPrefix:@"0x"]) {
        NSAssert([hexString length] == 8, @"Valid hex number prefixed with \"0x\" are 6 digits long");
        return UIColorFromRGB([hexString hexIntegerValue]);
    }
    NSAssert(FALSE, @"We should not get here - Supposed to return a UIColor");
    return nil;
}

@end




/**************************************************************************************************************
 
 
 NSString(IMOExtensions)
 
 */

#pragma mark - NSString Category

@implementation NSString(IMOExtensions)

- (double)hexDoubleValue{
    double result;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanHexDouble:&result];
    return result;
    
}


- (NSInteger)hexIntegerValue{
    return round([self hexDoubleValue]);
}

@end
