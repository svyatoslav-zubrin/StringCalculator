//
//  SZBracketNode.h
//  SZStringCalculator
//
//  Created by zubrin on 1/22/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZNode.h"

@interface SZBracketNode : SZNode

@property (nonatomic, assign, readonly) BOOL isOpening;
@property (nonatomic, assign, readonly) SZBracketType type;

- (id)initWithString:(NSString *)string;

@end
