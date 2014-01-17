//
//  SZNode.h
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZNode : NSObject
{
    BOOL isLeaf;
}

@property (nonatomic, assign, setter = makeRoot:) BOOL isRoot;
@property (nonatomic, strong) SZNode *parentNode;

- (id)initWithParentNode:(SZNode *)node;

@end
