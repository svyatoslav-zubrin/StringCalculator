//
//  SZNumberNode.h
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZNode.h"


@class SZOperationNode;

@interface SZNumberNode : SZNode

@property (nonatomic, strong, readonly) NSNumber *value;

- (id)initWithValue:(NSNumber *)valueNumber;
- (id)initWithValue:(NSNumber *)valueNumber
         parentNode:(SZOperationNode *)operationNode;

@end
