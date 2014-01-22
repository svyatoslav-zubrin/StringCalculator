//
//  SZMathGrammar.h
//  SZStringCalculator
//
//  Created by zubrin on 1/22/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum SZOperationType
{
    SZOperationTypeAdd = 0,
    SZOperationTypeSubtract = 1,
    SZOperationTypeMultiply = 2,
    SZOperationTypeDivide = 3,
    SZOperationTypeAddUnary = 4,
    SZOperationTypeSubtractUnary = 5
} SZOperationType;

typedef enum SZNodePrecidency
{
    SZNodePrecidencyLevel0 = 0,    // +,-
    SZNodePrecidencyLevel1 = 1,    // *,/
    SZNodePrecidencyLevel2 = 2,    // unary -,+
    SZNodePrecidencyLevel3 = 3     // ()[]{}
} SZNodePrecidency;

typedef enum SZBracketType
{
    SZBracketTypeRoundOpen   = 0,
    SZBracketTypeRoundClose  = 1,
    SZBracketTypeSquareOpen  = 2,
    SZBracketTypeSquareClose = 3,
    SZBracketTypeCurlyOpen   = 4,
    SZBracketTypeCurlyClose  = 5
} SZBracketType;


@class SZNode;


@interface SZMathGrammar : NSObject

+ (NSString *)stringForOperation:(SZOperationType)type;
+ (SZNodePrecidency)precidencyForOperation:(SZOperationType)type;

+ (NSString *)stringForBracket:(SZBracketType)type;
+ (SZNodePrecidency)precidencyForBracket:(SZBracketType)type;

+ (SZNode *)createNodeFromString:(NSString *)string
                           unary:(BOOL)isUnary;

@end
