//
//  SZExpressionParser.m
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZExpressionParser.h"

#import "SZNode.h"
#import "SZNumberNode.h"
#import "SZOperationNode.h"


@interface SZExpressionParser ()
@property (nonatomic, strong) NSString *operationsSymbolString;
@end


@implementation SZExpressionParser

- (id)init
{
    self = [super init];
    if (self)
    {
        self.operationsSymbolString = @"+-/*=";
    }
    return self;
}

- (SZNode *)parseExpressionString:(NSString *)expressionString
{
    // split expression string on tokens
    // 1. leave only allowed characters
    NSMutableCharacterSet *allowedSymbols = [[NSMutableCharacterSet alloc] init];
    [allowedSymbols formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    [allowedSymbols formUnionWithCharacterSet:
        [NSCharacterSet characterSetWithCharactersInString:self.operationsSymbolString]];
    NSMutableCharacterSet *forbiddenSymbols = [[NSMutableCharacterSet alloc] init];
    [forbiddenSymbols formUnionWithCharacterSet:[allowedSymbols invertedSet]];
    [forbiddenSymbols formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *cleanExpressionString = [[expressionString componentsSeparatedByCharactersInSet:forbiddenSymbols]
                                            componentsJoinedByString:@""];
    
    // 2. insert whitespaces around operations, than split with witespaces
    for (int i = 0; i < [self.operationsSymbolString length]; i++ )
    {
        NSRange currentOperationRange = NSMakeRange(i, 1);
        NSString *currentCharacter = [self.operationsSymbolString substringWithRange:currentOperationRange];
        NSString *replacementCharacter = [NSString stringWithFormat:@" %@ ", currentCharacter];
        cleanExpressionString = [cleanExpressionString stringByReplacingOccurrencesOfString:currentCharacter
                                                                                 withString:replacementCharacter];
    }
    NSArray *expressionItems = [cleanExpressionString componentsSeparatedByString:@" "];

    // parse array of tokens and construct tree (root node)
    SZNode *rootNode = nil;
    for (NSString *currentItem in expressionItems)
    {
        SZNode *currentNode = [self createNodeFromString:currentItem];
     
        // FIXME: take into account priority of the operation
        if (!rootNode)
        {
            [currentNode makeRoot:NO];
            rootNode = currentNode;
        }
        else if ([currentNode isKindOfClass:[SZOperationNode class]])
        {
            SZOperationNode *currentOperationNode = (SZOperationNode *)currentNode;
            [rootNode makeRoot:NO];
            rootNode.parentNode = currentOperationNode;
            currentOperationNode.firstArgument = rootNode;
            rootNode = currentNode;
            [rootNode makeRoot:YES];
        }
        else if ([currentNode isKindOfClass:[SZNumberNode class]])
        {
            currentNode.parentNode = rootNode;
            ((SZOperationNode *)rootNode).secondArgument = currentNode;
        }
    }
    
    return rootNode;
}

#pragma mark - Privates

- (SZNode *)createNodeFromString:(NSString *)string
{
    SZNode *node = nil;
    
    if ([string isEqualToString:@"+"])
    {
        node = [[SZOperationNode alloc] initWithType:SZOperationNodeTypeAdd];
    }
    else if ([string isEqualToString:@"-"])
    {
        node = [[SZOperationNode alloc] initWithType:SZOperationNodeTypeSubtract];
    }
    else if ([string isEqualToString:@"*"])
    {
        node = [[SZOperationNode alloc] initWithType:SZOperationNodeTypeMultiply];
    }
    else if ([string isEqualToString:@"/"])
    {
        node = [[SZOperationNode alloc] initWithType:SZOperationNodeTypeDivide];
    }
    else
    {
        node = [[SZNumberNode alloc] initWithValue:[NSNumber numberWithFloat:[string floatValue]]];
    }

    return node;
}

@end
