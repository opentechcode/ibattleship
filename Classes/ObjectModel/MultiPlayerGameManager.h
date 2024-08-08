//
//  MultiPlayerGameManager.h
//  BattleshipiPhone
//
//  Created by Ali Zafar on 1/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiPlayerProtocol.h"
#import <GameKit/GameKit.h>
@interface MultiPlayerGameManager : NSObject<GKMatchDelegate,GKSessionDelegate> {

	id <MultiPlayerProtocol> delegate;
	NSString *myPlayerId;
	NSString *remotePlayerId;
	
	NSString *myName;
	NSString *remotePlayerName;
	
	int myDeploymentTimeInterval;
	int remoteDeploymentTimeInterval;
	
	BOOL isLocalShipsDeployed;
	BOOL isRemoteShipDeployed;

	int gameState;
	
	GKMatch *newmatch;
	UIAlertView *alertView;
	
	
	GKSession *gameSession;
	
	int multiplayerGametype;
	
	
	
	
}

@property (nonatomic, retain)id <MultiPlayerProtocol> delegate;
@property (nonatomic, retain)GKMatch *newmatch;
@property (readwrite)int gameState;

@property (nonatomic, retain)NSString *myPlayerId;
@property (nonatomic, retain)NSString *remotePlayerId;

@property (nonatomic, retain)NSString *myName;
@property (nonatomic, retain)NSString *remotePlayerName;

@property (readwrite)int myDeploymentTimeInterval;
@property (readwrite)int remoteDeploymentTimeInterval;

@property (nonatomic, retain)GKSession *gameSession;
@property (readwrite)int multiplayerGametype;


-(void)InitializeGame;
-(void)processDataReceived:(NSData *)data;
-(void)sendShipDeploymentMessage:(NSMutableArray *)ships;
-(void)displayWaitAlertwithMessage:(id)sender;
-(void)dismissAlertMessage:(id)sender;
-(void)dismissAlertAndSendMessage:(id)sender;
-(void)dismissAlertMessageAfterTime:(float)seconds;
-(void)sendCellHitMessage:(int)cellNumber;
-(void)leaveMatch;
-(void)startGame;
-(void)displayAlertMessageIfGameNotFinish:(id)sender;

-(void)setLocalWifiDataHandler;
- (void)invalidateSession;

-(BOOL)sendGameCenterData:(NSData *)data;
-(BOOL)sendLocalWifiData:(NSData *)data;
-(BOOL)sendData:(NSData *)data;

@end
