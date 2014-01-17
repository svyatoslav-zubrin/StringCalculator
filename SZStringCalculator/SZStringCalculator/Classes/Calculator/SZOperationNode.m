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
@property (nonatomic, strong) SZNode *firstArgument, *secondArgument;
@end


@implementation SZOperationNode

- (id)initWithParentNode:(SZNode *)parentNode
           FirstArgument:(SZNode *)firstArg
          secondArgument:(SZNode *)secondArg
                  ofType:(SZOperationNodeType)type_
{
    self = [super initWithParentNode:parentNode];
    if (self)
    {
        self.type           = type_;
        self.firstArgument  = firstArg;
        self.secondArgument = secondArg;
    }
    return self;
}

@end
