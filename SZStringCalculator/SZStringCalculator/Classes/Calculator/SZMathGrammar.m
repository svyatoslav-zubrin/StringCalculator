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

+ (NSString *)stringForOperation:(SZOperationType)type
{
    switch (type) {
        case SZOperationTypeAdd             : return @"+";
        case SZOperationTypeAddUnary        : return @"u+";
        case SZOperationTypeDivide          : return @"/";
        case SZOperationTypeMultiply        : return @"*";
        case SZOperationTypeSubtract        : return @"-";
        case SZOperationTypeSubtractUnary   : return @"u-";
        default                             : return @"NOP";
    }
}

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

+ (SZNodePrecidency)precidencyForBracket:(SZBracketType)type
{
    return SZNodePrecidencyLevel3; // 1
}

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
