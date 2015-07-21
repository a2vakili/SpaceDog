//
//  SpaceDogNode.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-17.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "SpaceDogNode.h"
#import "Utilities.h"

@implementation SpaceDogNode

+(instancetype) spaceDogOfType: (spaceDogType) type{
    
    SpaceDogNode *spaceDog;
    spaceDog.damaged = NO;
    
    NSArray *textures;
    
    if (type == spaceDogTypeA) {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"]];
        spaceDog.type = spaceDogTypeA;
        
                     
                     
        
    }
    else  {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"]];
        spaceDog.type = spaceDogTypeB;
                     
    }
    
    spaceDog.health = 100;

    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    [spaceDog runAction: [SKAction repeatActionForever:animation]];
    
    float scale = [Utilities randomWithMin:85 max:100] / 100.0f;
    spaceDog.xScale = scale;
    spaceDog.yScale = scale;
    
    [spaceDog setUpPhysicsBody];
    
    return spaceDog;
}

-(BOOL)isDamaged{
    
    NSArray *textures;
    if (! self.damaged) {
        [self removeActionForKey:@"Animation"];
        if (self.type == spaceDogTypeA) {
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_3"]];
        }
        else{
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_4"]];
        }
        
        SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
        
        [self runAction:[SKAction repeatActionForever:animation] withKey:@"Animation"];
        
        self.damaged = YES;
        
        return NO;
    }
    else{
        return self.damaged;
    }
}

-(void)setUpPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryProjectile | CollisionCategoryGround;
   
}

@end
