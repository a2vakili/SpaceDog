//
//  ProjectileNode.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-12.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "ProjectileNode.h"
#import "Utilities.h"

@implementation ProjectileNode

+(instancetype)projectileAtPosition:(CGPoint)position{
    
    ProjectileNode *projectile= [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position= position;
    projectile.name= @"Projectile";
    
    [projectile setUpAnimation];
    
    [projectile setUpPhysicsBody];
    
    return projectile;
    
}


-(void)setUpAnimation{
    NSArray *textures= @[[SKTexture textureWithImageNamed:@"projectile_1"],
                         [SKTexture textureWithImageNamed:@"projectile_2"],
                         [SKTexture textureWithImageNamed:@"projectile_3"]];
    
    SKAction *projectileActions= [SKAction animateWithTextures:textures timePerFrame:0.10];
    SKAction *repeatAction= [SKAction repeatActionForever:projectileActions];
    [self runAction:repeatAction];
}


-(void)setUpPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}

-(void)moveTowardPosition: (CGPoint) position{
    // slope = (Y3 - Y1) / (X3 - X1)
    
    float slope= (position.y - self.position.y) / (position.x - self.position.x);
    
    // slope = (Y2 - Y1) / (X2 - X1)
    
    // (Y2 - Y1) = slope * (X2 - X1)
    
    // Y2 = slope *(X2 - X1) + Y1
    
    float offScreenX;
    
    if (position.x <= self.position.x) {
        offScreenX = -10;
    }
    else{
        offScreenX= self.parent.frame.size.width +10;
    }
    
    float offScreenY= slope * offScreenX - slope * self.position.x + self.position.y;
    
    CGPoint pointOffScreen= CGPointMake(offScreenX, offScreenY);
    
    float distanceY= pointOffScreen.y - self.position.y;
    float distanceX= pointOffScreen.x - self.position.x;
    
    float ditanceC= sqrtf((distanceX * distanceX) + (distanceY * distanceY));
    
    // speed= distance / time
    
    float time = ditanceC / projectileSpeed;
    
    float waitToFade = time * waitTime;
    
    float fadeTime= time - waitToFade;
    
    SKAction *moveProjectile= [SKAction moveTo:pointOffScreen duration:time];
    
    [self runAction:moveProjectile];
    
    SKAction *waitAction= [SKAction waitForDuration: waitToFade];
    SKAction *fadeAwayAction = [SKAction fadeOutWithDuration: fadeTime];
    SKAction *removeAction = [SKAction removeFromParent];
    SKAction * sequenceAction= [SKAction sequence:@[waitAction, fadeAwayAction, removeAction]];
    
    [self runAction:sequenceAction];
    
}



@end
