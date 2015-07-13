//
//  GamePlayScene.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-12.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "GamePlayScene.h"
#import "MachineNode.h"
#import "SpaceCatNode.h"
#import "ProjectileNode.h"

@implementation GamePlayScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        MachineNode *machine = [MachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
    
        SpaceCatNode *spaceCat= [SpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y - 2)];
        [self addChild:spaceCat];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    for (UITouch *touch in touches) {
        CGPoint position= [touch locationInNode:self];
        [self shootProjectileTowardPosition: position];
    }
  
}

-(void)shootProjectileTowardPosition: (CGPoint)position{
    
        SpaceCatNode *spaceCat= (SpaceCatNode *)[self childNodeWithName:@"SpaceCat"];
        [spaceCat performTab];
    
        MachineNode *machine= (MachineNode *) [self childNodeWithName:@"Machine"];
    
    ProjectileNode *projectile= [ProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y  + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardPosition:position];
    
}

@end
