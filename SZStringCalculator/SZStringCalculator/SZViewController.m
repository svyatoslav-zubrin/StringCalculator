//
//  SZViewController.m
//  SZStringCalculator
//
//  Created by zubrin on 1/17/14.
//  Copyright (c) 2014 zubrin. All rights reserved.
//

#import "SZViewController.h"
#import "SZCalculator.h"


@interface SZViewController ()
@property (nonatomic, strong) SZCalculator *calculator;
@end

@implementation SZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.calculator = [[SZCalculator alloc] init];
    NSError *error = nil;
    CGFloat res = [self.calculator calculateExpression:@"- (11 + 32.32)) * (- 4 + 6 / (8 - 6))"
                                                 error:&error];
    NSLog(@"result = : %f, error: %@", res, [error description]);
}

@end
