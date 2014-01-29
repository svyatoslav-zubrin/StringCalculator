//
//  SZError.h
//  SZStringCalculator
//
//  Created by zubrin on 1/29/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SZ_ERROR_DOMAIN @"SZErrorDomain"


typedef enum SZErrorCode
{
    SZErrorCodeUndefined = 1000,
    SZErrorCodeInconsistentMathExpression = 1001
} SZErrorCode;


@interface SZError : NSError

- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;

@end
