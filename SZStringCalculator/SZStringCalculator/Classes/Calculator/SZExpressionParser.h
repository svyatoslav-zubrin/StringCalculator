//
//  SZExpressionParser.h
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZNode;

@interface SZExpressionParser : NSObject

- (SZNode *)parseExpressionString:(NSString *)expressionString;

@end
