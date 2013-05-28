//
//  UIColor+equality.h
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 10/04/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface UIColor (equality)

- (BOOL)isEqualToColor:(UIColor *)otherColor;
- (BOOL)isSameColorComponents:(UIColor *)otherColor;
@end
