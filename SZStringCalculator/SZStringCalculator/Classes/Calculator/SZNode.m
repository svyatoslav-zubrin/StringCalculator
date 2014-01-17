//
//  SZNode.m
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZNode.h"


@interface SZNode ()
@property (nonatomic, strong) SZNode *parentNode;
@end


@implementation SZNode

/*
 * Designated initializer
 */
- (id)initWithParentNode:(SZNode *)node
{
    self = [super init];
    if (self)
    {
        isLeaf = NO;
        isRoot = YES;
        self.parentNode = node;
    }
    return self;
}

- (id)init
{
    return [self initWithParentNode:nil];
}

@end
