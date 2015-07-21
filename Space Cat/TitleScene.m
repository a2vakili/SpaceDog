//
//  TitleScene.m
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-11.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface TitleScene ()

@property(nonatomic) SKAction *pressStartSound;
@property(nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation TitleScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        background.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        self.pressStartSound = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:nil];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
        NSError *error = nil;
        
        self.backgroundMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        self.backgroundMusic.numberOfLoops = INFINITY;
        [self.backgroundMusic prepareToPlay];
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    [self.backgroundMusic play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.backgroundMusic stop];
    
    [self runAction:self.pressStartSound];
    GamePlayScene *playScene= [GamePlayScene sceneWithSize:self.frame.size];
    SKTransition *tansition= [SKTransition fadeWithDuration:1.0];
    
    [self.view presentScene:playScene transition:tansition];
}



@end
