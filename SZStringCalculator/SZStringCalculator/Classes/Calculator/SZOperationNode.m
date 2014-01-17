//
//  SZOperationNode.m
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZOperationNode.h"


@interface SZOperationNode ()
@property (nonatomic, assign) SZOperationNodeType type;
@end


@implementation SZOperationNode

/*
 * Designated initializer
 */
- (id)initWithParentNode:(SZNode *)parentNode
           FirstArgument:(SZNode *)firstArg
          secondArgument:(SZNode *)secondArg
                  ofType:(SZOperationNodeType)type_
{
    self = [super initWithParentNode:parentNode];
    if (self)
    {
        isLeaf              = NO;
        self.type           = type_;
        self.firstArgument  = firstArg;
        self.secondArgument = secondArg;
        [self makeRoot:NO];
    }
    return self;
}

- (id)initWithType:(SZOperationNodeType)type
{
    return [self initWithParentNode:nil
                      FirstArgument:nil
                     secondArgument:nil
                             ofType:type];
}

@end
