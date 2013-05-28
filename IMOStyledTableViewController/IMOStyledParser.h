//
//  IMOStyledParser.h
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 21/03/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import <Foundation/Foundation.h>


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface IMOStyledStyleParser : NSObject

@property(nonatomic, strong)NSMutableDictionary *parsedStyleDictionary;

+ (IMOStyledStyleParser *)sharedParser;

@end



@interface NSString(IMOExtensions)

- (double)hexDoubleValue;
- (NSInteger)hexIntegerValue;

@end

