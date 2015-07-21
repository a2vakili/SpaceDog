
//  GroundNode.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-17.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "GroundNode.h"
#import "Utilities.h"

@implementation GroundNode

+(instancetype) groundWithSize: (CGSize)size{
    GroundNode *ground = [self spriteNodeWithColor:[UIColor greenColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width/2, size.height/2);
    [ground setUpPhysicsBody];
    
    return ground;
    
}

-(void)setUpPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryGround;
    self.physicsBody.collisionBitMask = CollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}

@end
