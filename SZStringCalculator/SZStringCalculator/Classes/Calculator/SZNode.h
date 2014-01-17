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
    BOOL isRoot;
}

@property (nonatomic, strong, readonly) SZNode *parentNode;

- (id)initWithParentNode:(SZNode *)node;

@end
