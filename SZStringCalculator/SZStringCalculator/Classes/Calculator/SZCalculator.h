//
//  SZCalculator.h
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZCalculator : NSObject

- (CGFloat)calculateExpression:(NSString *)expressionString
                         error:(NSError **)error;

@end
