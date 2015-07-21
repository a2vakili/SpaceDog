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
#import "SpaceDogNode.h"
#import "GroundNode.h"
#import "Utilities.h"
#import <AVFoundation/AVFoundation.h>

@interface GamePlayScene ()


@property(nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property(nonatomic) NSTimeInterval lastTimeEnemyAdded;
@property(nonatomic) NSTimeInterval totalGameTime;
@property(nonatomic) NSInteger midSpeed;
@property(nonatomic) NSTimeInterval addEnemyTimeInterval;

@property(nonatomic) SKAction *damageSound;
@property(nonatomic) SKAction *explosionSound;
@property(nonatomic) SKAction *laserSound;

@property(nonatomic) AVAudioPlayer *gamePlayMusic;

@end

@implementation GamePlayScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        self.lastUpdateTimeInterval = 0;
        self.lastTimeEnemyAdded = 0;
        self.totalGameTime = 0;
        self.addEnemyTimeInterval = 1.5;
        self.midSpeed = spaceDogMinSpeed;
        
        SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        MachineNode *machine = [MachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
    
        SpaceCatNode *spaceCat= [SpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y - 2)];
        [self addChild:spaceCat];
        
        //[self addSpaceDog:];
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        self.physicsWorld.contactDelegate = self;
        
        GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
        [self setUpSound];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
        
        self.gamePlayMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        
        self.gamePlayMusic.numberOfLoops = INFINITY;
        [self.gamePlayMusic prepareToPlay];
        
    }
    
    return self;
}

-(void)didMoveToView:(SKView *)view{
    [self.gamePlayMusic play];
}

-(void)setUpSound{
    self.damageSound = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:nil];
    self.explosionSound = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:nil];
    self.laserSound = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:nil];
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
    
    ProjectileNode *projectile= [ProjectileNode projectileAtPosition:CGPointMake(machine.position.x,machine.position.y  + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardPosition:position];
    
    [self runAction:self.laserSound];
    
}

-(void)addSpaceDog:(NSTimeInterval)currentTime {
    
    NSInteger randomSpaceDog = [Utilities randomWithMin:0 max:2];
    SpaceDogNode *spaceDog = [SpaceDogNode spaceDogOfType:randomSpaceDog];
    
    spaceDog.health = currentTime / 3000;
    
    float dy = [Utilities randomWithMin:spaceDogMinSpeed max:spaceDogMaxSpeed];
    
    spaceDog.physicsBody.velocity = CGVectorMake(0, dy);
    
    float y = self.frame.size.height + spaceDog.size.height;
    float x = [Utilities randomWithMin:10 + spaceDog.size.width max:self.frame.size.width - spaceDog.size.width - 10];
    spaceDog.position =CGPointMake(x, y);
    
    [self addChild:spaceDog];
    
}

-(void)update:(NSTimeInterval)currentTime{
    if (self.lastUpdateTimeInterval) {
        self.lastTimeEnemyAdded += currentTime- self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime -self.lastUpdateTimeInterval;
        
    }
    
    self.lastUpdateTimeInterval = currentTime;

    if (self.lastTimeEnemyAdded > self.addEnemyTimeInterval) {
        [self addSpaceDog:currentTime];
        self.lastTimeEnemyAdded = 0;
    }
    
    if (self.totalGameTime > 48) {
        // 480 / 60 = 8 minutes
        self.addEnemyTimeInterval = 0.5;
        self.midSpeed = -160;
    }
    
    else if(self.totalGameTime > 24){
        // 240 / 60 = 4 minutes
        self.addEnemyTimeInterval = 0.65;
        self.midSpeed  = -150;
        }
    
    else if(self.totalGameTime > 12){
        // 120 / 60 = 2 minutes
        self.addEnemyTimeInterval = 0.75;
        self.midSpeed = -125;
    }
    
    else if(self.totalGameTime > 3){
        self.addEnemyTimeInterval = 1.0;
        self.midSpeed = -100.0;
    }
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
        }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == CollisionCategoryEnemy && secondBody.categoryBitMask == CollisionCategoryProjectile) {
        NSLog(@"Bam");
        SpaceDogNode *spaceDog = (SpaceDogNode *)firstBody.node;
        ProjectileNode *projectile = (ProjectileNode *)secondBody.node;
        
        //if ([spaceDog isDamaged]) {
        
        spaceDog.health = spaceDog.health - 100;
        
        if (spaceDog.health < 1) {
            [spaceDog removeFromParent];
            [self creatDebrisAtPosition:contact.contactPoint];
        }
        
        [self runAction:self.explosionSound];
        [projectile removeFromParent];
        
    }
    else if (firstBody.categoryBitMask == CollisionCategoryEnemy && secondBody.categoryBitMask == CollisionCategoryGround){
        NSLog(@"this had hit the ground");
        [self runAction:self.damageSound];
        SpaceDogNode *spaceDog = (SpaceDogNode *)firstBody.node;
        [spaceDog removeFromParent];
        [self creatDebrisAtPosition:contact.contactPoint];
    }
    
    
}

-(void)creatDebrisAtPosition:(CGPoint)position{
    NSInteger numberOfPieces = [Utilities randomWithMin:5 max:20];
    
    
    for (int i= 0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [Utilities randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%ld",(long)randomPiece];
        
        SKSpriteNode *debrisNode = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debrisNode.position = position;
        [self addChild:debrisNode];
        
        debrisNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debrisNode.frame.size];
        debrisNode.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debrisNode.physicsBody.contactTestBitMask = 0;
        debrisNode.physicsBody.collisionBitMask = CollisionCategoryGround |CollisionCategoryDebris;
        debrisNode.name = @"Debris";
        CGFloat velocityX = [Utilities randomWithMin:-150 max:150];
        CGFloat velocityY = [Utilities randomWithMin:150 max:350];
        
        debrisNode.physicsBody.velocity = CGVectorMake(velocityX, velocityY);
        SKAction *debrisAction = [SKAction waitForDuration:2.0];
        [debrisNode runAction:debrisAction completion:^{[debrisNode removeFromParent];
                                                                }];
        
        
    }
    
    
}

@end
