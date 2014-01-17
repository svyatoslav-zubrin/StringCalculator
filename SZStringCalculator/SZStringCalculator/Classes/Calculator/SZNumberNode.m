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

- (id)initWithValue:(NSNumber *)valueNumber
         parentNode:(SZOperationNode *)operationNode
{
    self = [super initWithParentNode:operationNode];
    if (self)
    {
        isLeaf = YES;
        isRoot = NO;
        self.value = valueNumber;
    }
    return self;
}

@end
