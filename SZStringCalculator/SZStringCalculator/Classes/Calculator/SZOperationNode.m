//
//  SZOperationNode.m
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZOperationNode.h"


@interface SZOperationNode ()
@property (nonatomic, assign) SZOperationType type;
@property (nonatomic, assign) SZNodePrecidency precidency;
@property (nonatomic, assign) BOOL isUnary;
@end


@implementation SZOperationNode

/*
 * Designated initializer
 */
- (id)initWithParentNode:(SZNode *)parentNode
           FirstArgument:(SZNode *)firstArg
          secondArgument:(SZNode *)secondArg
                  ofType:(SZOperationType)type_
{
    self = [super initWithParentNode:parentNode];
    if (self)
    {
        isLeaf              = NO;
        self.type           = type_;
        self.precidency     = [SZMathGrammar precidencyForOperation:self.type];
        self.firstArgument  = firstArg;
        self.secondArgument = secondArg;
        if (self.type == SZOperationTypeAddUnary
                || self.type == SZOperationTypeSubtractUnary)
        {
            self.isUnary = YES;
        }
        else
        {
            self.isUnary = NO ;
        }
        [self makeRoot:NO];
    }
    return self;
}

- (id)initWithType:(SZOperationType)type
{
    return [self initWithParentNode:nil
                      FirstArgument:nil
                     secondArgument:nil
                             ofType:type];
}

- (id)initWithString:(NSString *)string unary:(BOOL)isUnary
{
    for (int t = SZOperationTypeFirst; t < SZOperationTypeLast; t++)
    {
        if ([string isEqualToString:[SZMathGrammar stringForOperation:t]])
        {
            SZOperationType realType = isUnary ? [SZMathGrammar unaryVersionOfType:t] : t;
            
            return [self initWithParentNode:nil
                              FirstArgument:nil
                             secondArgument:nil
                                     ofType:realType];
        }
    }
    
    return nil;
}

- (CGFloat)calculateWithError:(NSError * __autoreleasing *)error
{
    if ([self isUnary])
    {
        if (self.type == SZOperationTypeAddUnary)
            return [self.firstArgument calculateWithError:error];
        else
            return -[self.firstArgument calculateWithError:error];
    }
    else
    {
        CGFloat secondArg = [self.secondArgument calculateWithError:error];
        if (self.type == SZOperationTypeDivide
                && secondArg == 0)
        {
            *error = [NSError errorWithDomain:@"math.parser"
                                         code:1000
                                     userInfo:@{NSLocalizedDescriptionKey : @"Division by zero"}];
            return FLT_MAX;
        }
        else
        {
            CGFloat firstArg = [self.firstArgument calculateWithError:error];
            if (!*error)
            {
                if (self.type == SZOperationTypeAdd)
                {
                    return firstArg + secondArg;
                }
                else if (self.type == SZOperationTypeSubtract)
                {
                    return firstArg - secondArg;
                }
                else if (self.type == SZOperationTypeMultiply)
                {
                    return firstArg * secondArg;
                }
                else // divide
                {
                    return firstArg/secondArg;
                }
            }
            else
            {
                return FLT_MAX;
            }
        }
    }
}

- (NSString *)description
{
    return [SZMathGrammar stringForOperation:self.type];
}

@end
