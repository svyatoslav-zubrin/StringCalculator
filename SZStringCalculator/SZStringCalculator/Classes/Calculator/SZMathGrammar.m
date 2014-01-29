//
//  SZMathGrammar.m
//  SZStringCalculator
//
//  Created by zubrin on 1/22/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZMathGrammar.h"

#import "SZNode.h"
#import "SZNumberNode.h"
#import "SZBracketNode.h"
#import "SZOperationNode.h"


@implementation SZMathGrammar

#pragma mark - Characters

+ (NSString *)allowedCharactersString
{
    return @"0123456789.";
}

+ (NSString *)allowedBracketsString
{
    return @"()";
}

+ (NSString *)allowedOperationsString
{
    return @"+-/*";
}

#pragma mark - Operations

+ (SZOperationType)unaryVersionOfType:(SZOperationType)type
{
    switch (type) {
        case SZOperationTypeAdd             :
        case SZOperationTypeAddUnary        : return SZOperationTypeAddUnary;
        case SZOperationTypeDivide          : return SZOperationTypeDivide;
        case SZOperationTypeMultiply        : return SZOperationTypeMultiply;
        case SZOperationTypeSubtract        :
        case SZOperationTypeSubtractUnary   : return SZOperationTypeSubtractUnary;
    }
}

+ (NSString *)stringForOperation:(SZOperationType)type
{
    switch (type) {
        case SZOperationTypeAdd             :
        case SZOperationTypeAddUnary        : return @"+";
        case SZOperationTypeDivide          : return @"/";
        case SZOperationTypeMultiply        : return @"*";
        case SZOperationTypeSubtract        :
        case SZOperationTypeSubtractUnary   : return @"-";
        default                             : return @"NOP";
    }
}

+ (SZNodePrecidency)precidencyForOperation:(SZOperationType)type
{
    switch (type) {
        case SZOperationTypeAddUnary        :
        case SZOperationTypeSubtractUnary   : return SZNodePrecidencyLevel2;
        case SZOperationTypeDivide          :
        case SZOperationTypeMultiply        : return SZNodePrecidencyLevel1;
        case SZOperationTypeAdd             :
        case SZOperationTypeSubtract        :
        default                             : return SZNodePrecidencyLevel0;
    }
}

#pragma mark - Brackets

+ (NSString *)stringForBracket:(SZBracketType)type
{
    switch (type) {
        case SZBracketTypeRoundOpen     : return @"(";
        case SZBracketTypeRoundClose    : return @")";
        case SZBracketTypeSquareOpen    : return @"[";
        case SZBracketTypeSquareClose   : return @"]";
        case SZBracketTypeCurlyOpen     : return @"{";
        case SZBracketTypeCurlyClose    : return @"}";
        default                         : return @"NOP";
    }
}

+ (SZNodePrecidency)precidencyForBracket:(SZBracketType)type
{
    return SZNodePrecidencyLevel3; // 1
}

#pragma mark - Nodes

+ (SZNode *)createNodeFromString:(NSString *)string
                           unary:(BOOL)isUnary
{
    SZNode *node = nil;
    
    if ([string isEqualToString:@"+"]
        || [string isEqualToString:@"-"]
        || [string isEqualToString:@"/"]
        || [string isEqualToString:@"*"])
    {
        node = [[SZOperationNode alloc] initWithString:string
                                                 unary:isUnary];
    }
    else if ([string isEqualToString:@"("]
             || [string isEqualToString:@")"]
             || [string isEqualToString:@"["]
             || [string isEqualToString:@"]"]
             || [string isEqualToString:@"{"]
             || [string isEqualToString:@"}"])
    {
        node = [[SZBracketNode alloc] initWithString:string];
    }
    else
    {
        node = [[SZNumberNode alloc] initWithValue:[NSNumber numberWithFloat:[string floatValue]]];
    }
    
    return node;
}

@end
