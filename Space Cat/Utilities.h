//
//  Utilities.h
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-12.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int projectileSpeed = 400;

static const int waitTime = 0.75;

static const int spaceDogMinSpeed = -100;
static const int spaceDogMaxSpeed = -50;

typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CollisionCategoryEnemy      = 1 << 0,    // 0000
    CollisionCategoryProjectile = 1 << 1,    // 0010
    CollisionCategoryDebris     = 1 << 2,    // 0100
    CollisionCategoryGround     = 1 << 3     // 1000
};



@interface Utilities : NSObject

+(NSInteger)randomWithMin: (NSInteger)min max: (NSInteger) max;

@end
