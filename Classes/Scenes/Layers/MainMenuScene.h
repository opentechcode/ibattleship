//
//  MainMenuScene.h
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "MailComposeViewController.h"

@interface MainMenuScene : CCScene
{
	CCSprite *backgroundImage;
	
	CCMenu *menu;
	CCMenuItemImage *newGame;
	CCMenuItemImage *options;
	CCMenuItemImage *highScores;
	CCMenuItemImage *inviteFriends;
	CCMenuItemImage *moregames;

	CCMenuItemImage *help;
	CCMenuItemImage *credits;
	
	CCMenuItemImage *multiplayer;
	
	CCSprite *mainMenuImage;
	BOOL isLocked;
}



@property (nonatomic, retain)CCSprite *backgroundImage;

@property (nonatomic, retain)CCMenuItemImage *newGame;
@property (nonatomic, retain)CCMenuItemImage *inviteFriends;
@property (nonatomic, retain)CCMenuItemImage *options;
@property (nonatomic, retain)CCMenuItemImage *highScores;
@property (nonatomic, retain)CCMenuItemImage *help;
@property (nonatomic, retain)CCMenuItemImage *credits;
@property (nonatomic, retain)CCMenuItemImage *moregames;
@property (nonatomic, retain)CCMenu *menu;
@property (nonatomic, retain)CCMenuItemImage *multiplayer;

@property (nonatomic, retain)CCSprite *mainMenuImage;

-(void)setComponentsPositions;
-(void)moregamesUrl:(id)sender;
-(void ) multiplayer:(id)sender;

@end
