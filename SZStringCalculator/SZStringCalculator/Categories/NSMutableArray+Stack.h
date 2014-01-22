//
//  NSMutableArray+Stack.h
//  SZStringCalculator
//
//  Created by zubrin on 1/22/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)

- (id)pop;
- (id)pop_back;
- (void)push:(id)object;

@end
