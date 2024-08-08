//
//  MultiPlayerGameManager.m
//  BattleshipiPhone
//
//  Created by Ali Zafar on 1/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiPlayerGameManager.h"


@implementation MultiPlayerGameManager
@synthesize delegate,gameState,newmatch,myPlayerId,remotePlayerId,myName,remotePlayerName,myDeploymentTimeInterval,remoteDeploymentTimeInterval;
@synthesize gameSession,multiplayerGametype;
- (id) init
{
	self = [super init];
	if (self != nil) {
		gameState=CONST_GAME_STATE_NOT_STARTED;
		multiplayerGametype=CONST_MULTIPLAYER_GAME_TYPE_LOCALWIFI;
		myDeploymentTimeInterval=0;
		remoteDeploymentTimeInterval=0;
		remotePlayerId=nil;
		myPlayerId=nil;
		
		myName=nil;
		remotePlayerName=nil;
		
		isLocalShipsDeployed=NO;
		isRemoteShipDeployed=NO;
		gameSession=nil;
	}
	return self;
}

-(void)InitializeGame
{
	
	gameState=CONST_GAME_STATE_INITIALIZE;
	
}

-(void)startGame
{
	gameState=CONST_GAME_STATE_INITIALIZE;
	[self performSelector:@selector(displayWaitAlertwithMessage:) withObject:CONST_MULIPLAYER_MESSAGE_WATING_FOR_OTHER_TO_READY afterDelay:0.5];
	
	if(newmatch && newmatch.expectedPlayerCount==0)
	{
		[self performSelector:@selector(dismissAlertAndSendMessage:) withObject:nil afterDelay:2.0];
	}
	
	//[self performSelector:@selector(dismissAlertAndSendMessage:) withObject:nil afterDelay:8.0];
	
}

#pragma mark match delegate functions

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID;
{
	[self processDataReceived:data];
	NSLog(@"Data Received");
	
	
	
}

- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state
{
	
	switch (state) {
		case GKPlayerStateConnected:
			NSLog(@"Player Connected");
			[self performSelector:@selector(dismissAlertAndSendMessage:) withObject:nil afterDelay:2.0];
			/*
			GKLocalPlayer *localplayer=[GKLocalPlayer localPlayer];
			
			NSDictionary *messageDict=[[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects: CONST_MESSAGE_TYPE,localplayer.alias,localplayer.playerID,nil] forKeys:[NSArray arrayWithObjects:[NSNumber numberWithInt:CONST_MESSAGE_TYPE_HAND_SHAKE] ,@"name",@"playerid",nil]];
			NSData *data=[NSKeyedArchiver archivedDataWithRootObject:messageDict];
			
			NSError *error;
			
			self.remotePlayerId=playerID;
			self.myName=localplayer.alias;
			self.myPlayerId=localplayer.playerID;
			
			if([match sendDataToAllPlayers:data withDataMode:GKMatchSendDataReliable error:&error])
			{
				
				NSLog(@"Data sent");
				
				
			}else {
				
				NSLog(@"Data Not Sent");
				
			}
			 */
			//[self performSelector:@selector(dismissAlertMessage:) withObject:nil afterDelay:0.5];
			break;
			
		case GKPlayerStateDisconnected:
			[self leaveMatch];
			if (![[GameManager sharedGameManager].gameProcessor isGameOver]) {
				[delegate otherPlayerLeft];

			}
			NSLog(@"Player Disconnected");
			break;
			
		default:
			break;
	}
	
}

// The match was unable to connect with the player due to an error.
- (void)match:(GKMatch *)match connectionWithPlayerFailed:(NSString *)playerID withError:(NSError *)error
{
	
}

// The match was unable to be established with any players due to an error.
- (void)match:(GKMatch *)match didFailWithError:(NSError *)error
{
	
}

#pragma mark  functions related to gameplay



-(void)processDataReceived:(NSData *)data
{
	
	NSDictionary *messageDict= (NSDictionary *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
	
	if ([[messageDict objectForKey:CONST_MESSAGE_TYPE] intValue]==CONST_MESSAGE_TYPE_HAND_SHAKE) {
		
		NSString *playerName=[messageDict objectForKey:@"name"];
		self.remotePlayerName=playerName;
		[delegate setenemyPlayerName:playerName];
		
		if ([[GKLocalPlayer localPlayer] isAuthenticated])
		{
			[delegate setPlayerName:[GKLocalPlayer localPlayer].alias];
		}
		
		//[self performSelector:@selector(dismissAlertMessage:) withObject:nil afterDelay:0.5];
		
	}
	else if([[messageDict objectForKey:CONST_MESSAGE_TYPE] intValue]==CONST_MESSAGE_TYPE_DEPLOYED){
		
		NSLog(@"Deploy computer ships");
		NSMutableArray *ships_deployed=[messageDict objectForKey:@"ships_deployed"];
		remoteDeploymentTimeInterval=[[messageDict objectForKey:CONST_KEY_DEPLOYMENT_TIME] intValue];
		[[GameManager sharedGameManager].gameProcessor.computerPlayer deployRemoteComputerPlayerShips:ships_deployed];
		
		if (gameState==CONST_GAME_STATE_INITIALIZE) {
			gameState=CONST_GAME_STATE_REMOTE_DEPLOYED;
		}
		else if (gameState==CONST_GAME_STATE_PLAYER_DEPLOYED) {
			gameState=CONST_GAME_STATE_BOTH_DEPLOYED;
			if (myDeploymentTimeInterval<remoteDeploymentTimeInterval) {
				
				[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn = YES;
				[self performSelector:@selector(dismissAlertMessage:) withObject:nil afterDelay:0.5];
				
				
			}
		//	[alertView dismissWithClickedButtonIndex:0 animated:YES];

			
		}
		else if (gameState==CONST_GAME_STATE_REMOTE_DEPLOYED) {
			gameState=CONST_GAME_STATE_BOTH_DEPLOYED;
			//[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn = YES;

			//playerTurnOn
		}
				
		
	}
	
	else if([[messageDict objectForKey:CONST_MESSAGE_TYPE] intValue]==CONST_MESSAGE_TYPE_ATTACK){
	
		NSLog(@"player Attacked");
		gameState=CONST_GAME_STATE_PLAYER_TURN;
		[self performSelector:@selector(dismissAlertMessage:) withObject:nil afterDelay:0.5];
		
		int cellNumber=[[messageDict objectForKey:CONST_KEY_CELL_NUMBER] intValue];
		
		
		[delegate enemyHitAtCellNumber:cellNumber];
		
		
		
		
	}
		
			
		
	
	
	
	
}

// send message when player hit on a cell
-(void)sendCellHitMessage:(int)cellNumber
{
	NSArray *valueArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:CONST_MESSAGE_TYPE_ATTACK],[NSNumber numberWithInt:cellNumber],nil];
	NSArray *keyValues=[NSArray arrayWithObjects:CONST_MESSAGE_TYPE,CONST_KEY_CELL_NUMBER,nil];
	
	NSDictionary *messageDict=[[NSDictionary alloc] initWithObjects:valueArray forKeys:keyValues];
	
	
	
	//NSDictionary *dict= [[NSDictionary alloc] initWithObjects: forKeys:];
	
	NSData *data=[NSKeyedArchiver archivedDataWithRootObject:messageDict];
	
//	NSError *error;
	gameState=CONST_GAME_STATE_REMOTE_COMPUTER_TURN;
	//[self performSelector:@selector(displayAlertMessageIfGameNotFinish:) withObject:nil afterDelay:2.0];

	//if([newmatch sendDataToAllPlayers:data withDataMode:GKSendDataReliable error:&error])
	if([self sendData:data])
	{
		
		NSLog(@"Deployment Data Sent");
	}
	
		
}

-(void)displayAlertMessageIfGameNotFinish:(id)sender
{
	
	if (![[GameManager sharedGameManager].gameProcessor isGameOver]) {
		
		
		[self performSelector:@selector(displayWaitAlertwithMessage:) withObject:CONST_MULIPLAYER_MESSAGE_WATING_FOR_TURN_TEXT afterDelay:0.1];

	}else {
		[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
	}


	
}



// send message when ship is deployed
-(void)sendShipDeploymentMessage:(NSMutableArray *)ships
{
	NSMutableArray *ships_deployed=[[NSMutableArray alloc] init];
	
	
	
	for (Ship *ship in ships) {
		
		NSNumber *cellNumber=[NSNumber numberWithInt:ship.deployedCellNumber];
		NSString  *shipType = ship.shipType;
		NSString  *shipOrientation= ship.shipCurrentOrientation;
		
		
		NSDictionary *dict= [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:cellNumber,shipType,shipOrientation,nil] forKeys:[NSArray arrayWithObjects:CONST_KEY_CELL_NUMBER,CONST_KEY_SHIP_TYPE,CONST_KEY_SHIP_ORIENTATION,nil]];
		
		
		[ships_deployed addObject:dict];
		
		
	}
	
	NSTimeInterval date=[NSDate timeIntervalSinceReferenceDate];
	long val=date;
	int seconds=val%50000;
	//NSLog(@"%@",date);
	NSNumber *timeInterval=[NSNumber numberWithInt:seconds];
	
    isLocalShipsDeployed=YES;
	myDeploymentTimeInterval=seconds;
	
	NSArray *valueArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:CONST_MESSAGE_TYPE_DEPLOYED],ships_deployed,timeInterval,nil];
	NSArray *keyValues=[NSArray arrayWithObjects:CONST_MESSAGE_TYPE,@"ships_deployed",CONST_KEY_DEPLOYMENT_TIME,nil];
	
	NSDictionary *messageDict=[[NSDictionary alloc] initWithObjects:valueArray forKeys:keyValues];
	
	
	
	//NSDictionary *dict= [[NSDictionary alloc] initWithObjects: forKeys:];
	
	NSData *data=[NSKeyedArchiver archivedDataWithRootObject:messageDict];
	
	//NSError *error;

	//if([newmatch sendDataToAllPlayers:data withDataMode:GKSendDataReliable error:&error])
	if([self sendData:data])
	{
		
		NSLog(@"Deployment Data Sent");
		
		if (gameState==CONST_GAME_STATE_INITIALIZE) {
			gameState=CONST_GAME_STATE_PLAYER_DEPLOYED;
			[self performSelector:@selector(displayWaitAlertwithMessage:) withObject:CONST_MULIPLAYER_MESSAGE_WATING_FOR_DEPLOYMENT_TEXT afterDelay:0.5];
		}
		
		else if (gameState==CONST_GAME_STATE_REMOTE_DEPLOYED) {
		
			gameState=CONST_GAME_STATE_BOTH_DEPLOYED;
			if (myDeploymentTimeInterval<remoteDeploymentTimeInterval) {
				
				[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn = YES;
				[self performSelector:@selector(dismissAlertMessage:) withObject:nil afterDelay:0.5];
				
				
			}else {
				//[self performSelector:@selector(displayWaitAlertwithMessage:) withObject:@"Please wait while other player take the turn" afterDelay:0.5];

			}

			//playerTurnOn
			
			
		}
		
	}
	else {
		
		NSLog(@"Deployment Data Sending fail");
		
	}
	
	
	
	
}
-(void)leaveMatch
{
	[newmatch disconnect];
	newmatch.delegate =nil ;
	[self invalidateSession];
	[self performSelector:@selector(dismissAlertMessage:) withObject:nil afterDelay:0.5];
}

-(void)displayWaitAlertwithMessage:(id)sender
{			NSString *message=(NSString *)sender;
	alertView=[Utility alertViewWithTitle:@"Wait" andMessage:message];
	

}

-(void)dismissAlertAndSendMessage:(id)sender
{
	[alertView dismissWithClickedButtonIndex:0 animated:YES];
	alertView=nil;
	
	GKLocalPlayer *localplayer=[GKLocalPlayer localPlayer];
	
	NSString *localPlayerName=[NSString stringWithFormat:@"Enemy"];
	NSString *playerID= [NSString stringWithFormat:@"xxxx"];
	
	if ([[GKLocalPlayer localPlayer] isAuthenticated]) {
		localPlayerName=localplayer.alias;
		playerID=localplayer.playerID;
	}
	
	
	NSArray *valueArray=[NSArray arrayWithObjects: [NSNumber numberWithInt:CONST_MESSAGE_TYPE_HAND_SHAKE],localPlayerName,playerID,nil];
	NSArray *keyValues=[NSArray arrayWithObjects:CONST_MESSAGE_TYPE ,@"name",@"playerid",nil];
	
	NSDictionary *messageDict=[[NSDictionary alloc] initWithObjects:valueArray forKeys:keyValues];
	
	
	//NSDictionary *messageDict=[[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects: CONST_MESSAGE_TYPE,localplayer.alias,localplayer.playerID,nil] forKeys:[NSArray arrayWithObjects:[NSNumber numberWithInt:CONST_MESSAGE_TYPE_HAND_SHAKE] ,@"name",@"playerid",nil]];
	NSData *data=[NSKeyedArchiver archivedDataWithRootObject:messageDict];
	
//	NSError *error;
	//newmatch.
	//self.remotePlayerId=playerID;
	self.myName=localplayer.alias;
	self.myPlayerId=localplayer.playerID;
	
	//if([newmatch sendDataToAllPlayers:data withDataMode:GKMatchSendDataReliable error:&error])
	if([self sendData:data])
	{
		
		NSLog(@"Data sent");
		
		
	}else {
		
		NSLog(@"Data Not Sent");
		
	}
	
	
}

-(void)dismissAlertMessage:(id)sender
{
	[alertView dismissWithClickedButtonIndex:0 animated:YES];
	alertView=nil;
}


-(void)dismissAlertMessageAfterTime:(float)seconds
{
	[self performSelector:@selector(dismissAlertMessageAfterTime:) withObject:self afterDelay:seconds];
	
}






////////////////////////////////////////

#pragma mark Data Received from local peer


- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context 
{ 
	[self processDataReceived:data];
	
}



-(void)setLocalWifiDataHandler
{
	[gameSession setDataReceiveHandler:self withContext:NULL];
}

#pragma mark GKSessionDelegate method
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state 
{
	
	switch (state) {
		case GKPeerStateDisconnected:
			[self leaveMatch];
			if (![[GameManager sharedGameManager].gameProcessor isGameOver]) {
				[delegate otherPlayerLeft];
				
			}
			NSLog(@"Player Disconnected");
			
			break;
		case GKPeerStateConnected:
			NSLog(@"Player Connected");
			[self performSelector:@selector(dismissAlertAndSendMessage:) withObject:nil afterDelay:2.0];
			break;

		default:
			break;
	}
	
}


- (void)invalidateSession
{
	if(gameSession != nil) {
		[gameSession disconnectFromAllPeers]; 
		gameSession.available = NO; 
		[gameSession setDataReceiveHandler: nil withContext: NULL]; 
		gameSession.delegate = nil; 
		gameSession=nil;
	}
}

#pragma mark Sending Data at appropreate node;

-(BOOL)sendData:(NSData *)data
{
	if (multiplayerGametype==CONST_MULTIPLAYER_GAME_TYPE_GAMECENTER) {
		return [self sendGameCenterData:data];	
		
		
		
	}
	
	return [self sendLocalWifiData:data];
	
}



-(BOOL)sendGameCenterData:(NSData *)data
{
	NSError *error;
	if(![newmatch sendDataToAllPlayers:data withDataMode:GKMatchSendDataReliable error:&error])
	{
		NSLog(@"%@",error);
		[self leaveMatch];
		return NO;
	}
	
	return YES;
}


-(BOOL)sendLocalWifiData:(NSData *)data
{
	NSError *error;
	
	if(![gameSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error])
	{
		NSLog(@"%@",error);
		[self leaveMatch];
		return NO;
		
	}
	
	return YES;
	
}



/////////////////////////////////////////

- (void) dealloc
{
	[newmatch release];
	delegate=nil;
	[super dealloc];
}


@end
