//
//  IMOStyledCellKeys.h
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 21/03/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IMOStyledCellPositionTop,
    IMOStyledCellPositionMiddle,
    IMOStyledCellPositionBottom,
    IMOStyledCellPositionSingle,
    IMOStyledCellPositionPlain
} IMOStyledCellPosition;


typedef enum {
    IMOStyledCellStyleDefault,
    IMOStyledCellStyleValue1,
    IMOStyledCellStyleValue2,
    IMOStyledCellStyleSubtitle,
    IMOStyledCellStyleNeverMind = IMOStyledCellStyleDefault
} IMOStyledCellStyle;



typedef enum {
    IMOStyledCellTypeUnknown,
    IMOStyledCellTypeColor,
    IMOStyledCellTypeFont,
    IMOStyledCellTypeSize,
    IMOStyledCellTypeBool,
    IMOStyledCellTypeImage
    
} IMOStyledParserDataType;

//Keys
extern NSString * const IMOStyledCellTopSeparatorColorKey;
extern NSString * const IMOStyledCellBottomSeparatorColorKey;

extern NSString * const IMOStyledCellBackgroundImageKey;
extern NSString * const IMOStyledCellTopGradientColorKey;
extern NSString * const IMOStyledCellBottomGradientColorKey;
extern NSString * const IMOStyledCellSelectedTopGradientColorKey;
extern NSString * const IMOStyledCellSelectedBottomGradientColorKey;
extern NSString * const IMOStyledCellTextLabelTextColorKey;
extern NSString * const IMOStyledCellDetailTextLabelTextColorKey;
extern NSString * const IMOStyledCellTextLabelFontKey;
extern NSString * const IMOStyledCellDetailTextLabelFontKey;

extern NSString * const IMOStyledCellUseCustomHeaderKey;
extern NSString * const IMOStyledCellHeaderFontKey;
extern NSString * const IMOStyledCellHeaderTextColorKey;

extern NSString * const IMOStyledCellUseCustomFooterKey;
extern NSString * const IMOStyledCellFooterFontKey;
extern NSString * const IMOStyledCellFooterTextColorKey;

//textfield
extern NSString * const IMOStyledCellTextFieldFontKey;
extern NSString * const IMOStyledCellTextFieldTextColorKey;
//textCaption
extern NSString * const IMOStyledCellTextCaptionFontKey;
extern NSString * const IMOStyledCellTextCaptionTextColorKey;

extern NSString * const IMOStyledCellNoteViewFontKey;
extern NSString * const IMOStyledCellNoteViewTextColorKey;
extern NSString * const IMOStyledCellNoteViewLineColorKey;

@interface IMOStyledCellKeys : NSObject

+ (IMOStyledCellKeys *)sharedManager;
- (BOOL)isValidKey:(NSString *)aKey;
- (NSInteger)arityForKey:(NSString *)key;
- (IMOStyledParserDataType)argumentTypeAtPosition:(NSInteger)position forKey:(NSString *)key;

@end