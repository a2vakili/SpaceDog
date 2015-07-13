//
//  MachineNode.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-12.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "MachineNode.h"

@implementation MachineNode

+(instancetype)machineAtPosition:(CGPoint)position{
    MachineNode *machine = [MachineNode spriteNodeWithImageNamed:@"machine_1"];
    machine.position = position;
    machine.anchorPoint = CGPointMake(0.5, 0);
    machine.name = @"Machine";
    
    NSArray *textures= @[[SKTexture textureWithImageNamed:@"machine_1"],
                         [SKTexture textureWithImageNamed:@"machine_2"]];
    
    SKAction *machineAnimation= [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *machineAnimationRepeat= [SKAction repeatActionForever:machineAnimation];
    [machine runAction:machineAnimationRepeat];
    
    return machine;
}
@end
