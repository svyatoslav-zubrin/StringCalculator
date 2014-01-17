//
//  SZNumberNode.m
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZNumberNode.h"
#import "SZOperationNode.h"

@class SZOperationNode;

@interface SZNumberNode ()
@property (nonatomic, strong) NSNumber *value;
@end

@implementation SZNumberNode

/*
 * Designated initializer
 */
- (id)initWithValue:(NSNumber *)valueNumber
         parentNode:(SZOperationNode *)operationNode
{
    self = [super initWithParentNode:operationNode];
    if (self)
    {
        isLeaf      = YES;
        self.value  = valueNumber;
        [self makeRoot:NO];
    }
    return self;
}

- (id)initWithValue:(NSNumber *)valueNumber
{
    return [self initWithValue:valueNumber parentNode:nil];
}


@end
