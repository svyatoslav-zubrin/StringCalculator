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
    SZOperationType t;
    
    if ([string isEqualToString:@"+"])
    {
        if (isUnary)
            t = SZOperationTypeAddUnary;
        else
            t = SZOperationTypeAdd;
    }
    else if ([string isEqualToString:@"-"])
    {
        if (isUnary)
            t = SZOperationTypeSubtractUnary;
        else
            t = SZOperationTypeSubtract;
    }
    else if ([string isEqualToString:@"*"])
    {
        t = SZOperationTypeMultiply;
    }
    else // "/"
    {
        t = SZOperationTypeDivide;
    }
    
    return [self initWithParentNode:nil
                      FirstArgument:nil
                     secondArgument:nil
                             ofType:t];
}

- (NSString *)description
{
    return [SZMathGrammar stringForOperation:self.type];
}

@end
