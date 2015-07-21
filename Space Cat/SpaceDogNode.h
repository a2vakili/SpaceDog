//
//  SpaceDogNode.h
//  Space Cat
//
//  Created by Arsalan Vakili on 2015-07-17.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, spaceDogType) {
    spaceDogTypeA = 0,
    spaceDogTypeB = 1
   
};

@interface SpaceDogNode : SKSpriteNode

@property(nonatomic, getter = isDamaged) BOOL damaged;

@property(nonatomic) int health;

@property(nonatomic) spaceDogType type;

+(instancetype) spaceDogOfType: (spaceDogType) type;


@end
