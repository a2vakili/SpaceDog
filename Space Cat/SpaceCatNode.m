//
//  SpaceCatNode.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-12.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "SpaceCatNode.h"

@interface SpaceCatNode ()

@property (nonatomic) SKAction *tapAction;


@end

@implementation SpaceCatNode

+(instancetype)spaceCatAtPosition:(CGPoint)position;{
    SpaceCatNode *spaceCat = [SpaceCatNode spriteNodeWithImageNamed:@"spacecat_1"];
    spaceCat.position= position;
    spaceCat.anchorPoint= CGPointMake(0.5, 0);
    
    spaceCat.name= @"SpaceCat";
    
    return spaceCat;
}

-(void)performTab{
    [self runAction:self.tapAction];
}

-(SKAction *)tapAction{
    if (_tapAction != nil) {
        return _tapAction;
    }
    
    NSArray *textures= @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                         [SKTexture textureWithImageNamed:@"spacecat_1"]];
    
    self.tapAction= [SKAction animateWithTextures:textures timePerFrame:0.20];
    
    return self.tapAction;
}

@end
