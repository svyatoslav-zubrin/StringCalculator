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
#import "SZBracketNode.h"
#import "SZOperationNode.h"

#import "NSMutableArray+Stack.h"


@interface SZExpressionParser ()
@property (nonatomic, strong) NSString *operationsSymbolString;
@end


@implementation SZExpressionParser

- (id)init
{
    self = [super init];
    if (self)
    {
        self.operationsSymbolString = @"+-/*=(){}[]";
        
    }
    return self;
}

#pragma mark - Publics

- (SZNode *)parseExpressionString:(NSString *)expressionString
{
    NSArray *splittedExpressionString = [self splitExpressionStringOnTokens:expressionString];
    NSArray *infixNodes = [self convertTokensToNodes:splittedExpressionString];
    NSLog(@"infix notation: %@", infixNodes);
    return [self constructTreeFromNodes:infixNodes];
}

#pragma mark - Privates

- (NSArray *)splitExpressionStringOnTokens:(NSString *)expressionString
{
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
    cleanExpressionString = [cleanExpressionString stringByReplacingOccurrencesOfString:@"  "
                                                                             withString:@" "];
    cleanExpressionString = [cleanExpressionString stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"clean expression:\"%@\"", cleanExpressionString);
    
    NSArray *expressionTokens = [cleanExpressionString componentsSeparatedByString:@" "];

    return expressionTokens;
}

- (NSArray *)convertTokensToNodes:(NSArray *)tokens
{
    NSMutableArray *nodes = [@[] mutableCopy];
    
    SZNode *previousNode = nil;
    for (NSString *token in tokens)
    {
        SZNode *node = [SZMathGrammar createNodeFromString:token unary:NO];
        if ([node isKindOfClass:[SZOperationNode class]])
        {
            if (!previousNode
                    || [previousNode isKindOfClass:[SZOperationNode class]]
                    || ([previousNode isKindOfClass:[SZBracketNode class]]
                            && [(SZBracketNode *)previousNode isOpening]))
            {
                node = [SZMathGrammar createNodeFromString:token unary:YES];
            }
        }

        [nodes addObject:node];
        previousNode = node;
    }
    return nodes;
}

- (SZNode *)constructTreeFromNodes:(NSArray *)infixNodes
{
    /*  Logic


    *** Common algorithm:

    For each token in turn in the input infix expression:
    If the token is an operand, append it to the postfix output.
    If the token is a unary postfix operator, append it to the postfix output.
    If the token is a unary prefix operator, push it on to the stack.
    If the token is a function token, push it on to the stack.
    If the token is a function argument separator
        Pop the top element off the stack and append it to the output, until the top element of the stack is an opening bracket
    If the token is a binary operator A then:
    If A is left-associative, while there is an operator B of higher or equal precidence than A at the top of the stack, pop B off the stack and append it to the output.
    If A is right-associative, while there is an operator B of higher precidence than A at the top of the stack, pop B off the stack and append it to the output.
        Push A onto the stack.
    If the token is an opening bracket, then push it onto the stack.
    If the token is a closing bracket:
        Pop operators off the stack and append them to the output, until the operator at the top of the stack is a opening bracket.
        Pop the opening bracket off the stack.
    If the token at the top of the stack is a function token, pop it and append it to the output.

    When all the tokens have been read:
        While there are still operator tokens in the stack:
            Pop the operator on the top of the stack, and append it to the output.



    *** The algorithm that deals only with brackets and left-associative binary infix operators:

    For each token in turn in the input infix expression:
    If the token is an operand, append it to the postfix output.
    If the token is an operator A then:
        While there is an operator B of higher or equal precidency than A at the top of the stack, pop B off the stack and append it to the output.
        Push A onto the stack.
    If the token is an opening bracket, then push it onto the stack.
    If the token is a closing bracket:
        Pop operators off the stack and append them to the output, until the operator at the top of the stack is a opening bracket.
        Pop the opening bracket off the stack.

    When all the tokens have been read:
        While there are still operator tokens in the stack:
            Pop the operator on the top of the stack, and append it to the output.

     */
    NSMutableArray *operationsStack = [@[] mutableCopy];
    NSMutableArray *numbersStack    = [@[] mutableCopy];
    
    for (SZNode *node in infixNodes)
    {
        if ([node isKindOfClass:[SZNumberNode class]]) // If the token is an operand, append it to the postfix output.
        {
            [numbersStack push:node];
        }
        else if ([node isKindOfClass:[SZOperationNode class]]
                     && ((SZOperationNode *)node).isUnary)
        {
            [operationsStack push:node];
        }
        else if ([node isKindOfClass:[SZOperationNode class]]) // If the token is an operator A then:
        {
            for (;;) // While there is an operator B of higher or equal precidency than A at the top of the stack, pop B off the stack and append it to the output.
            {
                SZOperationNode *stackNode = [operationsStack pop_back];
                if (stackNode
                        && [stackNode isKindOfClass:[SZOperationNode class]]
                        && node.precidency <= stackNode.precidency)
                {
                    [operationsStack pop];
                    if (stackNode.isUnary)
                    {
                        SZNode *arg = [numbersStack pop];
                        [stackNode setFirstArgument:arg];
                    }
                    else
                    {
                        SZNode *secondArgument = [numbersStack pop];
                        SZNode *firstArgument  = [numbersStack pop];
                        [stackNode setFirstArgument:firstArgument];
                        [stackNode setSecondArgument:secondArgument];
                    }
                    [numbersStack push:stackNode];
                }
                else // Push A onto the stack.
                {
                    [operationsStack push:node];
                    break;
                }
            }
        }
        else if ([node isKindOfClass:[SZBracketNode class]])
        {
            if ([(SZBracketNode *)node isOpening]) //  If the token is an opening bracket, then push it onto the stack.
            {
                [operationsStack push:node];
            }
            else
            {
                for (;;) // Pop operators off the stack and append them to the output, until the operator at the top of the stack is a opening bracket.
                {
                    SZOperationNode *stackNode = [operationsStack pop_back];
                    if (stackNode)
                    {
                        if ([stackNode isKindOfClass:[SZBracketNode class]] // Pop the opening bracket off the stack.
                                && [(SZBracketNode *)stackNode isOpening])
                        {
                            [operationsStack pop];
                            break;
                        }
                        else
                        {
                            [operationsStack pop];

                            if (stackNode.isUnary)
                            {
                                SZNode *arg = [numbersStack pop];
                                [stackNode setFirstArgument:arg];
                            }
                            else
                            {
                                SZNode *secondArgument = [numbersStack pop];
                                SZNode *firstArgument  = [numbersStack pop];
                                [stackNode setFirstArgument:firstArgument];
                                [stackNode setSecondArgument:secondArgument];
                            }
                            
                            [numbersStack push:stackNode];
                        }
                    }
                    else
                    {
                        // error: expression inconsistency
                        return nil;
                    }

                }
            }
        }
    }

    // construct tree
    for (;;)
    {
        SZOperationNode *operation = [operationsStack pop];
        if (operation)
        {
            if (operation.isUnary)
            {
                SZNode *arg = [numbersStack pop];
                [operation setFirstArgument:arg];
            }
            else
            {
                SZNode *secondArgument = [numbersStack pop];
                SZNode *firstArgument  = [numbersStack pop];
                [operation setFirstArgument:firstArgument];
                [operation setSecondArgument:secondArgument];
            }
            [numbersStack push:operation];
        }
        else
        {
            break;
        }
    }

    return [numbersStack pop];
}

@end
