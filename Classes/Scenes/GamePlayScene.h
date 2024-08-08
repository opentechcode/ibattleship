//
//  GamePlayScene.h
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectsLayer.h"
#import "GameplayGadgetLayer.h"
#import "AnimationProtocol.h"
#import "HighScoreManager.h";
#import "HighScore.h"

#import "GameWinLayer.h"
#import "GameLostLayer.h"

#import "AnimationProtocol.h"
#import "MultiPlayerProtocol.h"

@interface GamePlayScene : CCScene <AnimationProtocol,UIAlertViewDelegate,MultiPlayerProtocol>
{
	CCSprite *backgroundImage;
	CCSprite *horizon;
	
	CCSprite *txtSprite;
	CCSprite *txtEnemySprite;
	ObjectsLayer *objLayer;
	GameLostLayer *gameLostScreen;
	GameWinLayer *gameWinScreen;
	
	GameplayGadgetLayer *gamePlayGadgetLayer;
	
	UITextField *txtname;
	
	CCMenuItemImage *mainMenuButton;
	UIAlertView *alertViewActivity;

	int alertType;
	
	int game_type;
	
	CCLabel *lblPlayerName;
	CCLabel *lblEnemyName;
	
}



@property (nonatomic ,retain) CCSprite *backgroundImage;
@property (nonatomic ,retain) CCSprite *horizon;
@property (nonatomic ,retain) ObjectsLayer *objLayer;
@property (nonatomic, retain)GameplayGadgetLayer *gamePlayGadgetLayer;
@property (nonatomic, retain)CCSprite *txtSprite;
@property (nonatomic, retain)CCSprite *txtEnemySprite;
@property (nonatomic, retain)UITextField *txtname;
@property (nonatomic, retain)CCMenuItemImage *mainMenuButton;

@property (nonatomic, retain)GameLostLayer *gameLostScreen;
@property (nonatomic, retain)GameWinLayer *gameWinScreen;

@property (readwrite)int game_type;

@property (nonatomic, retain)CCLabel *lblPlayerName;
@property (nonatomic, retain)CCLabel *lblEnemyName;


-(void)gameOver;
-(void)playerWin;
-(void)playerLost;
-(void)endOfText:(id)sender;
-(void)endOfEnemyText:(id)sender;
-(void)quitGame:(id)sender;
-(void)submitOnlineScore:(id)sender;
-(void)setGameMultiplayer;

@end
