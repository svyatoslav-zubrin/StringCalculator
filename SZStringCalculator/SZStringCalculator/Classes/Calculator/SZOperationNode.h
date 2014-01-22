//
//  SZOperationNode.h
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZNode.h"

@interface SZOperationNode : SZNode

@property (nonatomic, assign, readonly) BOOL isUnary;
@property (nonatomic, assign, readonly) SZOperationType type;
@property (nonatomic, strong) SZNode *firstArgument, *secondArgument;

- (id)initWithString:(NSString *)string unary:(BOOL)isUnary;
- (id)initWithType:(SZOperationType)type;
- (id)initWithParentNode:(SZNode *)parentNode
           FirstArgument:(SZNode *)firstArg
          secondArgument:(SZNode *)secondArg
                  ofType:(SZOperationType)type;

@end
