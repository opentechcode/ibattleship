//
//  OptionScene.h
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OptionScene : CCScene 
{
	CCSprite *backgroundImage;
	CCMenuItemToggle *ambientSound;
	CCMenuItemToggle *soundEffects;
		

}

@property (nonatomic ,retain) CCSprite *backgroundImage;
@property (nonatomic, retain) CCMenuItemToggle *ambientSound;
@property (nonatomic, retain) CCMenuItemToggle *soundEffects;

@end
