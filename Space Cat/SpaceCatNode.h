//
//  SpaceCatNode.h
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-12.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SpaceCatNode : SKSpriteNode

+(instancetype)spaceCatAtPosition:(CGPoint)position;

-(void)performTab;

@end