//
//  IMOStyledCellKeys.m
//  IMOStyledTableViewControllerDemo
//
//  Created by Frederic Cormier on 21/03/13.
//  Copyright (c) 2013 Frederic Cormier. All rights reserved.
//

#import "IMOStyledCellKeys.h"

NSString * const IMOStyledCellNavBarTintColorKey                 = @"IMOStyledCellNavBarTintColorKey";

NSString * const IMOStyledCellTopSeparatorColorKey               = @"IMOStyledCellTopSeparatorColorKey";
NSString * const IMOStyledCellBottomSeparatorColorKey            = @"IMOStyledCellBottomSeparatorColorKey";

NSString * const IMOStyledCellBackgroundImageKey                 = @"IMOStyledCellBackgroundImageKey";
NSString * const IMOStyledCellBackgroundColorKey                 = @"IMOStyledCellBackgroundColorKey";

NSString * const IMOStyledCellTopGradientColorKey                = @"IMOStyledCellTopGradientColorKey";
NSString * const IMOStyledCellBottomGradientColorKey             = @"IMOStyledCellBottomGradientColorKey";
NSString * const IMOStyledCellSelectedTopGradientColorKey        = @"IMOStyledCellSelectedTopGradientColorKey";
NSString * const IMOStyledCellSelectedBottomGradientColorKey     = @"IMOStyledCellSelectedBottomGradientColorKey";
NSString * const IMOStyledCellTextLabelTextColorKey              = @"IMOStyledCellTextLabelTextColorKey";
NSString * const IMOStyledCellDetailTextLabelTextColorKey        = @"IMOStyledCellDetailTextLabelTextColorKey";
NSString * const IMOStyledCellTextLabelFontKey                   = @"IMOStyledCellTextLabelFontKey";
NSString * const IMOStyledCellDetailTextLabelFontKey             = @"IMOStyledCellDetailTextLabelFontKey";

NSString * const IMOStyledCellUseCustomHeaderKey                 = @"IMOStyledCellUseCustomHeaderKey";
NSString * const IMOStyledCellHeaderFontKey                      = @"IMOStyledCellHeaderFontKey";
NSString * const IMOStyledCellHeaderTextColorKey                 = @"IMOStyledCellHeaderTextColorKey";

NSString * const IMOStyledCellUseCustomFooterKey                 = @"IMOStyledCellUseCustomFooterKey";
NSString * const IMOStyledCellFooterFontKey                      = @"IMOStyledCellFooterFontKey";
NSString * const IMOStyledCellFooterTextColorKey                 = @"IMOStyledCellFooterTextColorKey";


NSString * const IMOStyledCellTextFieldFontKey                   = @"IMOStyledCellTextFieldFontKey";
NSString * const IMOStyledCellTextFieldTextColorKey              = @"IMOStyledCellTextFieldTextColorKey";
NSString * const IMOStyledCellTextCaptionFontKey                 = @"IMOStyledCellTextCaptionFontKey";
NSString * const IMOStyledCellTextCaptionTextColorKey            = @"IMOStyledCellTextCaptionTextColorKey";


NSString * const IMOStyledCellNoteViewFontKey                    = @"IMOStyledCellNoteViewFontKey";
NSString * const IMOStyledCellNoteViewTextColorKey               = @"IMOStyledCellNoteViewTextColorKey";
NSString * const IMOStyledCellNoteViewLineColorKey               = @"IMOStyledCellNoteViewLineColorKey";


@interface IMOStyledCellKeys()

@property(nonatomic, strong)NSMutableArray *allKeys;

@end


@implementation IMOStyledCellKeys

@synthesize allKeys = allKeys_;

+ (IMOStyledCellKeys *)sharedManager {
    static dispatch_once_t once;
    static IMOStyledCellKeys *clearCellKeys;
    dispatch_once(&once, ^ { clearCellKeys = [[IMOStyledCellKeys alloc] init]; });
    return clearCellKeys;
}




- (id)init{
    if (self = [super init]) {
        allKeys_ = [[NSMutableArray alloc] initWithObjects:
                    @[IMOStyledCellNavBarTintColorKey,               @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellTextLabelTextColorKey,            @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellTopSeparatorColorKey,             @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellBottomSeparatorColorKey,          @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellBackgroundColorKey,               @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellBackgroundImageKey,               @(IMOStyledCellTypeImage)],
                    @[IMOStyledCellTopGradientColorKey,              @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellBottomGradientColorKey,           @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellSelectedTopGradientColorKey,      @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellSelectedBottomGradientColorKey,   @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellTextLabelTextColorKey,            @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellDetailTextLabelTextColorKey,      @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellTextLabelFontKey,                 @(IMOStyledCellTypeFont), @(IMOStyledCellTypeSize)],
                    @[IMOStyledCellDetailTextLabelFontKey,           @(IMOStyledCellTypeFont), @(IMOStyledCellTypeSize)],
                    @[IMOStyledCellUseCustomHeaderKey,               @(IMOStyledCellTypeBool)],
                    @[IMOStyledCellHeaderFontKey,                    @(IMOStyledCellTypeFont), @(IMOStyledCellTypeSize)],
                    @[IMOStyledCellHeaderTextColorKey,               @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellUseCustomFooterKey,               @(IMOStyledCellTypeBool)],
                    @[IMOStyledCellFooterFontKey,                    @(IMOStyledCellTypeFont), @(IMOStyledCellTypeSize)],
                    @[IMOStyledCellFooterTextColorKey,               @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellTextFieldFontKey,                 @(IMOStyledCellTypeFont), @(IMOStyledCellTypeSize)],
                    @[IMOStyledCellTextFieldTextColorKey,            @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellTextCaptionFontKey,               @(IMOStyledCellTypeFont), @(IMOStyledCellTypeSize)],
                    @[IMOStyledCellTextCaptionTextColorKey,          @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellNoteViewFontKey,                  @(IMOStyledCellTypeFont), @(IMOStyledCellTypeSize)],
                    @[IMOStyledCellNoteViewTextColorKey,             @(IMOStyledCellTypeColor)],
                    @[IMOStyledCellNoteViewLineColorKey,             @(IMOStyledCellTypeColor)],
                    nil];
    }
    return self;
}



- (BOOL)isValidKey:(NSString *)aKey {
    for (NSArray *k in [self allKeys]) {
        if ([k[0] isEqualToString:aKey]) {
            return YES;
        }
    }
    return NO;
}



- (NSInteger)arityForKey:(NSString *)key{
    for (NSArray *k in [self allKeys]) {
        if ([k[0] isEqualToString:key]) {
            return [k count] -1;
        }
    }
    return 0;
}


- (IMOStyledParserDataType)argumentTypeAtPosition:(NSInteger)position forKey:(NSString *)key{
    for (NSArray *k in [self allKeys]) {
        if ([k[0]isEqualToString:key]) {
            if ([k count] > position) {
                return [k[position] integerValue];
            }
        }
    }
    return IMOStyledCellTypeUnknown;
}

@end
