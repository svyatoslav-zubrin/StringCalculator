//
//  SZOperationNode.h
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZNode.h"


typedef enum SZOperationNodeType
{
    SZOperationNodeTypeAdd      = 0,
    SZOperationNodeTypeSubtract = 1,
    SZOperationNodeTypeMultiply = 2,
    SZOperationNodeTypeDivide   = 3
} SZOperationNodeType;


@interface SZOperationNode : SZNode

@property (nonatomic, assign, readonly) SZOperationNodeType type;
@property (nonatomic, strong) SZNode *firstArgument, *secondArgument;

- (id)initWithType:(SZOperationNodeType)type;
- (id)initWithParentNode:(SZNode *)parentNode
           FirstArgument:(SZNode *)firstArg
          secondArgument:(SZNode *)secondArg
                  ofType:(SZOperationNodeType)type;

@end
