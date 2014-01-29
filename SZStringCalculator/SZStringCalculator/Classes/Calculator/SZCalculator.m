//
//  SZCalculator.m
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZCalculator.h"
#import "SZExpressionParser.h"
#import "SZNode.h"


@interface SZCalculator ()
@property (nonatomic, strong) SZExpressionParser *parser;
@end

@implementation SZCalculator

- (id)init
{
    self = [super init];
    if (self)
    {
        self.parser = [[SZExpressionParser alloc] init];
    }
    return self;
}

#pragma mark - Publics

- (CGFloat)calculateExpression:(NSString *)expressionString
                         error:(NSError * __autoreleasing *)error
{
    SZNode *rootNode = [self.parser parseExpressionString:expressionString];
    return [rootNode calculateWithError:error];
}

@end
