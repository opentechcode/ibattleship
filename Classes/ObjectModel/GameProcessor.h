//
//  GameProcessor.h
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"
#import "Player.h"
#import "MultiPlayerGameManager.h"
@interface GameProcessor : NSObject 
{

	Player *userPlayer;
	Player *computerPlayer;

	int selectedCellNoByPlayer;
	
	int turnInProgress;
	
	BOOL isGameStarted;
	
    BOOL isPlayerTurnOn;
	
	BOOL inDisplay;
	
	NSString *destroyingshiptext;
	
	UITextField *txtname;
	BOOL isGamePaused;
	BOOL didAppEntertoBackground;
	
	MultiPlayerGameManager *multiPlayerGameManager;
	
	int game_type;
	
}

@property (readwrite) BOOL isGamePaused;
@property (readwrite) BOOL didAppEntertoBackground;
@property (readwrite) int selectedCellNoByPlayer;
@property (readwrite)int turnInProgress;
@property (readwrite) BOOL isGameStarted;
@property (readwrite) BOOL isPlayerTurnOn;
@property (nonatomic, retain)UITextField *txtname;

@property (nonatomic, retain)Player *userPlayer;
@property (nonatomic, retain)Player *computerPlayer;
@property (nonatomic, retain)NSString *destroyingshiptext;

@property (nonatomic, retain)MultiPlayerGameManager *multiPlayerGameManager;

@property (readwrite)int game_type;

-(BOOL)isGameOver;
-(void)setTextFieldOrientation:(UIDeviceOrientation)orient;
-(void)addTextField;
-(void)removeTextField;

@end
