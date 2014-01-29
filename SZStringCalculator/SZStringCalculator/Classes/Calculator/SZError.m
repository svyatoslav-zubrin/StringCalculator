//
//  SZError.m
//  SZStringCalculator
//
//  Created by zubrin on 1/29/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZError.h"

@implementation SZError

/*
 *  Designated initializer
 */
- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict
{
    return [self initWithDomain:SZ_ERROR_DOMAIN code:code userInfo:dict];
}

- (id)init
{
    return [self initWithCode:SZErrorCodeUndefined userInfo:nil];
}

- (NSString *)description
{
    switch (self.code) {
        case SZErrorCodeInconsistentMathExpression : return @"Inconsistent mathematical expression";
        case SZErrorCodeUndefined                  :
        default                                    :  return @"Undefined calculator error";
    }
}


@end
