//
//  UIColor+equality.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 10/04/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "UIColor+equality.h"


@implementation UIColor (equality)

- (BOOL)isEqualToColor:(UIColor *)otherColor {
    /*
     http://stackoverflow.com/questions/970475/how-to-compare-uicolors
     By Sam Vernette
     Modified to fix float rounding errors
     */

    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            return [UIColor colorWithCGColor:CGColorCreate(colorSpaceRGB, components)];
        } else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(self);
    otherColor = convertColorToRGBSpace(otherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isSameColorComponents:otherColor];
}



- (BOOL)isSameColorComponents:(UIColor *)otherColor {
    const CGFloat *selfColorComponents = CGColorGetComponents([self CGColor]);
    const CGFloat *otherColorComponents = CGColorGetComponents([otherColor CGColor]);
    for (int i = 0; i < 4; i++) {
        NSLog(@"self : %f - other : %f", selfColorComponents[i], otherColorComponents[i]);
        // Need to convert float to string to round them enough to match
        NSString *selfFloatString = [NSString stringWithFormat:@"%.6f", selfColorComponents[i]];
        NSString *otherFloatString = [NSString stringWithFormat:@"%.6f", otherColorComponents[i]];
        if ([selfFloatString isEqualToString:otherFloatString] == NO) {
            return NO;
        }
    }
    return YES;
}

@end
