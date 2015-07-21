//
//  Utilities.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-12.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSInteger)randomWithMin: (NSInteger)min max: (NSInteger) max{
    NSInteger randomValue= arc4random()%(max -min) + min;
    return randomValue;
}

@end
