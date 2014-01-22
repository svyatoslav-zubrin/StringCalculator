//
//  NSMutableArray+Stack.m
//  SZStringCalculator
//
//  Created by zubrin on 1/22/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (id)pop
{
    id result = [self lastObject];
    if (result)
        [self removeLastObject];
    return result;
}

- (id)pop_back
{
    return [self lastObject];
}

- (void)push:(id)object
{
    [self addObject:object];
}

@end
