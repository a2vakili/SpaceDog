//
//  TitleScene.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-11.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"

@implementation TitleScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        background.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    GamePlayScene *playScene= [GamePlayScene sceneWithSize:self.frame.size];
    SKTransition *tansition= [SKTransition fadeWithDuration:1.0];
    
    [self.view presentScene:playScene transition:tansition];
}

@end
