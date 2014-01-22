//
//  SZBracketNode.m
//  SZStringCalculator
//
//  Created by zubrin on 1/22/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZBracketNode.h"

#import "SZMathGrammar.h"


@interface SZBracketNode ()
@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, assign) SZBracketType type;
@property (nonatomic, assign) SZNodePrecidency precidency;
@end

@implementation SZBracketNode

- (id)initWithString:(NSString *)string
{
    self = [super initWithParentNode:nil];
    if (self)
    {
        if ([string isEqualToString:[SZMathGrammar stringForBracket:SZBracketTypeRoundOpen]])
        {
            self.isOpening = YES;
            self.type = SZBracketTypeRoundOpen;
        }
        else if ([string isEqualToString:[SZMathGrammar stringForBracket:SZBracketTypeRoundClose]])
        {
            self.isOpening = NO;
            self.type = SZBracketTypeRoundClose;
        }
        else if ([string isEqualToString:[SZMathGrammar stringForBracket:SZBracketTypeSquareOpen]])
        {
            self.isOpening = YES;
            self.type = SZBracketTypeSquareOpen;
        }
        else if ([string isEqualToString:[SZMathGrammar stringForBracket:SZBracketTypeSquareClose]])
        {
            self.isOpening = NO;
            self.type = SZBracketTypeSquareClose;
        }
        else if ([string isEqualToString:[SZMathGrammar stringForBracket:SZBracketTypeCurlyOpen]])
        {
            self.isOpening = YES;
            self.type = SZBracketTypeCurlyOpen;
        }
        else
        {
            self.isOpening = NO;
            self.type = SZBracketTypeCurlyClose;
        }
        self.precidency = [SZMathGrammar precidencyForBracket:self.type];
    }
    return self;
}

- (NSString *)description
{
    return [SZMathGrammar stringForBracket:self.type];
}

@end
