//
//  GamePlayScene.m
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "GamePlayScene.h"
#import "OnlineCompetitionManager.h"

@implementation GamePlayScene
@synthesize backgroundImage,horizon,objLayer,gamePlayGadgetLayer,txtname,txtSprite,txtEnemySprite;

@synthesize gameLostScreen,gameWinScreen,mainMenuButton,game_type,lblPlayerName,lblEnemyName;

- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		CCLabel* label = [CCLabel labelWithString:@"GamePlayScene" fontName:@"Marker Felt" fontSize:64];
		
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , 700 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		self.backgroundImage  = [CCSprite spriteWithFile:@"background_lower.png"];
		[self.backgroundImage setPosition:CGPointMake(1024/2, 305) ];
		[self addChild:self.backgroundImage ];
		
		self.horizon  = [CCSprite spriteWithFile:@"background_horizon.png"];
		[self.horizon setPosition:CGPointMake(1024/2, 689) ];
		[self addChild:self.horizon ];
		
		id act = [CCLiquid actionWithWaves:1 amplitude:1.55 grid:ccg(4,10) duration:3]; 
		id repaetAction = [CCRepeatForever actionWithAction:act];
		[backgroundImage runAction:repaetAction];
		
		GameLostLayer *tempLayer= [[GameLostLayer alloc] init];
		self.gameLostScreen=tempLayer;
		gameLostScreen.delegate=self;
		[tempLayer release];
		
		GameWinLayer *tempWinLayer= [[GameWinLayer alloc] init];		
		self.gameWinScreen=tempWinLayer;
		gameWinScreen.delegate=self;
		[tempWinLayer release];
		
		
		
		//[actionWithWaves:5 amplitude:40 grid:ccg(15,10) duration:t];
		
		
		ObjectsLayer *temp = [[ObjectsLayer alloc] init];
		self.objLayer =temp;
		[temp release];
		[self addChild:self.objLayer];
		
		
		GameplayGadgetLayer *tempGadgetLayer= [[GameplayGadgetLayer alloc] init];
		self.gamePlayGadgetLayer=tempGadgetLayer;
		[tempGadgetLayer release];
		[self addChild:gamePlayGadgetLayer z:0];
		
	    [GameManager sharedGameManager].gameProcessor.userPlayer.delegate=self;
		[GameManager sharedGameManager].gameProcessor.computerPlayer.delegate=self;
		
		UITextField *txtField= [[UITextField alloc] initWithFrame:CGRectMake(70, 45 ,150,20)];
		self.txtname=txtField;
		[txtField release];
	
		self.mainMenuButton=[CCMenuItemImage itemFromNormalImage:@"btn_gameplay_mainMenu_unpressed.png" selectedImage:@"btn_gameplay_mainMenu_pressed.png" target:self selector:@selector(quitGame:)];
		
		[mainMenuButton setPosition:CGPointMake(900, 115)];
		
		CCMenu *menu =[CCMenu menuWithItems:mainMenuButton,nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
		game_type=CONST_GAME_TYPE_SINGLE_PLAYER;
		
		//	self.lblEnemyName=[CCLabel labelWithString:@"ENEMY" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE+2];
		
		NSString *enemyName=[NSString stringWithFormat:@"ENEMY"];
		if ([enemyName length]>15) {
			enemyName=[enemyName substringToIndex:15];
		}
		
		self.lblEnemyName=[CCLabel labelWithString:enemyName dimensions:CGSizeMake(300, 30) alignment:UITextAlignmentCenter fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE+2];;//[CCLabel labelWithString:@"PLAYER" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE+2];
		
		[lblEnemyName setPosition:CGPointMake(330, 750)];
		
		NSString *playerName=[NSString stringWithFormat:@"PLAYER"];
		if ([playerName length]>15) {
			playerName=[playerName substringToIndex:15];
		}
		self.lblPlayerName=[CCLabel labelWithString:playerName dimensions:CGSizeMake(300, 30) alignment:UITextAlignmentCenter fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE+2];;//[CCLabel labelWithString:@"PLAYER" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE+2];
		
		[lblPlayerName setPosition:CGPointMake(700, 750)];
		
		[lblEnemyName setColor:ccBLACK];
		[lblPlayerName setColor:ccBLACK];
		
		[self addChild:lblEnemyName z:2];
		[self addChild:lblPlayerName z:2];
		
	}
	return self;
}

-(void) mainMenu:(id) sender
{    
	
	[GameManager sharedGameManager].gameProcessor.userPlayer.delegate=nil;
	[GameManager sharedGameManager].gameProcessor.computerPlayer.delegate=nil;
	[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager.delegate=nil;

	gameWinScreen.delegate=nil;
	gameLostScreen.delegate=nil;
	if ([GameManager sharedGameManager].gameProcessor.isGamePaused)
	{
		//[[CCDirector sharedDirector] startAnimation];
		[[CCDirector sharedDirector] resume];
	}
	[[GameManager sharedGameManager] refreshGameProcessor];
		[[GameManager sharedGameManager]  mainMenu];
}

-(void)slideMapDown
{
	[self.objLayer removeChild:self.objLayer.map cleanup:YES];
	[self.objLayer addChild:self.objLayer.largerMap z:2];
	[[GameManager sharedGameManager].gameProcessor.userPlayer.playerMap updatePositionsofCells];
	[[GameManager sharedGameManager].gameProcessor.computerPlayer.playerMap updatePositionsofCells];
	[mainMenuButton setPosition:CGPointMake(900, 95)];
	/*for (int j = 0; j < 100 ; j++) 
	{
		CCSprite *dotSprite  = [CCSprite spriteWithFile:@"dot.png"];
		Cell  *cell = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerMap.cells objectAtIndex:j];
		[dotSprite setPosition:CGPointMake(cell.posX,cell.posY)];
		//[self addChild:dotSprite z:5];
	}
	
	for (int j = 0; j < 100 ; j++) 
	{
		CCSprite *dotSprite  = [CCSprite spriteWithFile:@"dot.png"];
		Cell  *cell = [[GameManager sharedGameManager].gameProcessor.computerPlayer.playerMap.cells objectAtIndex:j];
		[dotSprite setPosition:CGPointMake(cell.posX,cell.posY)];
		[self addChild:dotSprite z:5];
	}*/
	
	int count = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips count];
	
	for (int i=0; i< count; i++) 
	{
		Ship *ship = (Ship*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:i];
		Cell *cell = (Cell*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerMap.cells objectAtIndex:ship.deployedCellNumber - 1];
		[self.objLayer removeChild:ship.shipSprite cleanup:YES];
		[ship.largerShipSprite setPosition:CGPointMake(cell.posX +ship.xAdjustment, cell.posY+ship.yAdjustment)];
		[self.objLayer addChild:ship.largerShipSprite z:3];
		
		NSLog(@"I am =%@ Deployed cell no  = %d",ship.shipType,ship.deployedCellNumber);
	}
	
		
}


-(void)showPlayerBlastAnimationAtPositions:(CGPoint)position
{
	//first we have to remove the pointer from Layer
	//[self.objLayer.pointer stopAllActions];
	//[self.objLayer removeChild:self.objLayer.pointer cleanup:YES ];
	[self.objLayer runPlayerBlastAnimationAtLocation:position];
	
}
-(void)showPlayerWaterSplashAnimationAtposition:(CGPoint)position
{
	//[self.objLayer.pointer stopAllActions];
	//[self.objLayer removeChild:self.objLayer.pointer cleanup:YES ];
	[self.objLayer runPlayerWaterSplashAnimationAtLocation:position];

}

-(void)showCompBlastAnimationAtPositions:(CGPoint)position
{
	//first we have to remove the pointer from Layer
	[self.objLayer.pointer stopAllActions];
	[self.objLayer removeChild:self.objLayer.pointer cleanup:YES ];
	[self.objLayer runCompBlastAnimationAtLocation:position];
	self.objLayer.isPointerAdded = NO;
	
}
-(void)showCompWaterSplashAnimationAtposition:(CGPoint)position
{
	[self.objLayer.pointer stopAllActions];
	[self.objLayer removeChild:self.objLayer.pointer cleanup:YES ];
	[self.objLayer runCompWaterSplashAnimationAtLocation:position];
	self.objLayer.isPointerAdded = NO;
	
}

-(void)removeShipAfterAutoDeployAtIndex:(int)index
{
	[objLayer removeCorrespondingShipFromLayer:index];
}

-(void)resetDeployment
{
	[objLayer resetDeployment];
}

-(void)updatePlayerShots
{
	[gamePlayGadgetLayer updateEnemyCount:[GameManager sharedGameManager].gameProcessor.computerPlayer.shots];
	[gamePlayGadgetLayer updatePlayerCount:[GameManager sharedGameManager].gameProcessor.userPlayer.shots];
}
-(void)updatePlayerHealth
{
	[gamePlayGadgetLayer updateEnemyHealthBar:[GameManager sharedGameManager].gameProcessor.computerPlayer.health];
	[gamePlayGadgetLayer updatePlayerHealthBar:[GameManager sharedGameManager].gameProcessor.userPlayer.health];
}
-(void)submitScore
{
	
	
		Player *player=[GameManager sharedGameManager].gameProcessor.userPlayer;
		HighScoreManager *highscoreManager=	[[HighScoreManager alloc] init];
		HighScore *highscore=[[HighScore alloc]	initwithName:[GameManager sharedGameManager].gameProcessor.txtname.text Shots:player.shots Time:gamePlayGadgetLayer.seconds_counter GameMode:0 andDeviceId:[[UIDevice currentDevice] uniqueIdentifier]];
		[highscoreManager.localArray addObject:highscore];
		[highscoreManager saveLocalScores];
	
	[[GameManager sharedGameManager].gameProcessor removeTextField];
	
	if ([GameManager sharedGameManager].gameProcessor.game_type==CONST_GAME_TYPE_SINGLE_PLAYER) {

	UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:CONST_ALERT_GLOABAL_SCORE_TITLE message:CONST_ALERT_GLOABAL_SCORE_TEXT delegate:self cancelButtonTitle:@"NO" otherButtonTitles:nil];
	[alerView addButtonWithTitle:@"YES"];
	
	[alerView show];
	
	[alerView release];	
		
	}else {
		
		[self mainMenu:nil];
	}
		//[self mainMenu:self];
	
}

-(void)cancelScoreLost
{
	[[GameManager sharedGameManager].gameProcessor removeTextField];
	[self mainMenu:self];
	
}
-(void)cancelScore
{
	[[GameManager sharedGameManager].gameProcessor removeTextField];
	if ([GameManager sharedGameManager].gameProcessor.game_type==CONST_GAME_TYPE_SINGLE_PLAYER) {

	UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:CONST_ALERT_GLOABAL_SCORE_TITLE message:CONST_ALERT_GLOABAL_SCORE_TEXT delegate:self cancelButtonTitle:@"NO" otherButtonTitles:nil];
	[alerView addButtonWithTitle:@"YES"];
	
	[alerView show];
	
	}else {
		
		[self mainMenu:nil];
	}
	//[self mainMenu:self];
}

-(void)showtheShip:(Ship *)ship atPosition:(CGPoint)position
{
	CCSprite *sprite=ship.shipSprite;
	[self.objLayer removeChild:sprite cleanup:YES];
	[self.objLayer addChild:sprite z:2];
	
	[sprite setPosition:position];
}

-(void)showtheEnemyShip:(Ship *)ship atPosition:(CGPoint)position
{
	CCSprite *sprite=ship.largerShipSprite;
	[self.objLayer removeChild:sprite cleanup:YES];
	[self.objLayer addChild:sprite z:2];
	[sprite setPosition:position];
}


-(void)gameOver
{
	if ([GameManager sharedGameManager].gameProcessor.userPlayer.health<=0) {
		[gamePlayGadgetLayer finishTimer];
		[self playerLost];
	}
	else if([GameManager sharedGameManager].gameProcessor.computerPlayer.health<=0) {
		[gamePlayGadgetLayer finishTimer];
		[self playerWin];
		
	}

}
-(void)playerWin
{ 	
	[self addChild:self.gameWinScreen z:2];
	[[GameManager sharedGameManager].gameProcessor addTextField];
	//gameWinScreen
	self.gamePlayGadgetLayer.menu.isTouchEnabled=NO;
	self.objLayer.isTouchEnabled=NO;
	///[self performSelector:@selector(dismissAlertMessage:) withObject:[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager afterDelay:0.5];
	[[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager dismissAlertMessageAfterTime:3.0];
	}
-(void)playerLost
{
	[self addChild:self.gameLostScreen z:2];
	self.gamePlayGadgetLayer.menu.isTouchEnabled=NO;
	self.objLayer.isTouchEnabled=NO;
	
	
	
	
}
 
-(void)quitGame:(id)sender
{
	if ([GameManager sharedGameManager].gameProcessor.isGamePaused) 
	{
		UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Paused" message:@"The game is paused first resume it" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		
		[alerView show];
		[alerView release];
		
	}
	else {
		
	

	alertType=CONST_ALERT_TYPE__QUIT;
	
	UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Quit" message:@"Are you sure that you want to quit" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:nil];
	[alertView addButtonWithTitle:@"YES"];
	alertView.delegate=self;
	[alertView show];
	[alertView release];
	}
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	//[GameManager sharedGameManager].gameProcessor.userPlayer.delegate=nil;
	//[GameManager sharedGameManager].gameProcessor.computerPlayer.delegate=nil;
	
	if (buttonIndex==1 && alertType==CONST_ALERT_TYPE_HIGHSCORE) {
		
	//	Player *player=[GameManager sharedGameManager].gameProcessor.userPlayer;
		
	//	HighScore *highscore=[[HighScore alloc]	initwithName:[GameManager sharedGameManager].gameProcessor.txtname.text Shots:player.shots Time:gamePlayGadgetLayer.seconds_counter GameMode:0 andDeviceId:[[UIDevice currentDevice] uniqueIdentifier]];
	//	OnlineCompetitionManager *compManager= [OnlineCompetitionManager sharedOnlineCompetitionmanager];
	//	[compManager submitScore:highscore];
		
		Player *player=[GameManager sharedGameManager].gameProcessor.userPlayer;
		
		[[GameManager sharedGameManager].gamecenter reportTheScore:player.shots];
		[self mainMenu:nil];
		
		/*
		if ([[OnlineCompetitionManager sharedOnlineCompetitionmanager] isNetworkAvailableSimpleCheck]) {
			
		
		
		alertViewActivity=[Utility alertViewWithActivityIndicatorWithTitle:CONST_ALERT_CONNECTING_TITLE andMessage:CONST_ALERT_CONNECTING_MESSAGE];
		[self performSelector:@selector(submitOnlineScore:) withObject:nil afterDelay:1.0];
		
		}
		else {
			alertType=CONST_ALERT_TYPE_HIGHSCORE;
			UIAlertView *alertView=	[[UIAlertView alloc] initWithTitle:CONST_ALERT_NETWORK_UNAVAILABLE_TITLE message:CONST_ALERT_NETWORK_UNAVAILABLE_MESSAGE_RETRY delegate:self cancelButtonTitle:@"NO" otherButtonTitles:nil];
			[alertView addButtonWithTitle:@"YES"];
			[alertView show];
			[alertView release];
			//[Utility showAlertViewWithTitle:@"Network Unavailabe" andMessage:@""];
		}
		 */
		
	}
	
	else if(buttonIndex==1 || alertType==CONST_ALERT_TYPE_HIGHSCORE) {
		[[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager leaveMatch];
		[self mainMenu:self];
	}

	
	
}

-(void)submitOnlineScore:(id)sender
{
		Player *player=[GameManager sharedGameManager].gameProcessor.userPlayer;
	
		HighScore *highscore=[[HighScore alloc]	initwithName:[GameManager sharedGameManager].gameProcessor.txtname.text Shots:player.shots Time:gamePlayGadgetLayer.seconds_counter GameMode:0 andDeviceId:[[UIDevice currentDevice] uniqueIdentifier]];
		OnlineCompetitionManager *compManager= [OnlineCompetitionManager sharedOnlineCompetitionmanager];
		
		
		
		if ([compManager submitScore:highscore]) {
			[alertViewActivity dismissWithClickedButtonIndex:0 animated:YES];
			[self mainMenu:self];
			
		}
		else {
			[alertViewActivity dismissWithClickedButtonIndex:0 animated:YES];
			alertType=CONST_ALERT_TYPE_HIGHSCORE;
			UIAlertView *aView=[[UIAlertView alloc] initWithTitle:CONST_ALERT_SERVER_NOT_FOUND_TITLE message:CONST_ALERT_SERVER_NOT_FOUND_MESSAGE_RETRY delegate:self cancelButtonTitle:@"NO" otherButtonTitles:nil];
			[aView addButtonWithTitle:@"YES"];
			[aView show];
			[aView release];
		}

		
		
	
}
/*
- (void)didPresentAlertView:(UIAlertView *)alertView
{
	
	CGRect frame = alertView.frame;
	frame.origin.y = 30;
	alertView.frame = frame;
	
}
 */

-(void)textForPlayerShipDestruction
{
	NSString *spriteName=[GameManager sharedGameManager].gameProcessor.destroyingshiptext;
	spriteName=[spriteName stringByAppendingFormat:@"_green.png"];
	
	self.txtSprite=[CCSprite spriteWithFile:spriteName];
	[txtSprite setPosition:CGPointMake(1024/2, 768/2)];
	
	id action=	[CCSequence actions:[CCFadeIn actionWithDuration:2.0f],[CCFadeOut actionWithDuration:1.0f],[CCCallFunc actionWithTarget:self selector:@selector(endOfText:)],nil] ;
	[txtSprite runAction:action];
	
	[self addChild:txtSprite];
}

-(void)textForEnemyShipDestruction
{
	NSString *spriteName=[GameManager sharedGameManager].gameProcessor.destroyingshiptext;
	spriteName=[spriteName stringByAppendingFormat:@"_yellow.png"];
	
	self.txtEnemySprite=[CCSprite spriteWithFile:spriteName];
	[txtEnemySprite setPosition:CGPointMake(1024/2, 768/2-75)];
	
	id action=	[CCSequence actions:[CCFadeIn actionWithDuration:2.0f],[CCFadeOut actionWithDuration:1.0f],[CCCallFunc actionWithTarget:self selector:@selector(endOfEnemyText:)],nil] ;
	[txtEnemySprite runAction:action];
	[self addChild:txtEnemySprite];
	
	
}
-(void)endOfEnemyText:(id)sender
{
	[self removeChild:txtEnemySprite cleanup:YES];
	[txtEnemySprite release];
	txtEnemySprite=nil;
}

-(void)endOfText:(id)sender
{
	
	[self removeChild:txtSprite cleanup:YES];
	[txtSprite release];
	txtSprite=nil;
}

#pragma mark Multiplayer delegate Methods

-(void)setGameMultiplayer
{
	game_type=CONST_GAME_TYPE_MULTI_PLAYER;
	//[GameManager sharedGameManager].gamecenter.delegate=self;
	CCLabel *lblMultiPlayer=[CCLabel labelWithString:@"Multiplayer" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE-2];
	[lblMultiPlayer setPosition:CGPointMake(206, 470)];
	[lblMultiPlayer setColor:ccBLACK];
	//[self addChild:lblMultiPlayer];
	
	
	
}


-(void)otherPlayerLeft
{
	[self mainMenu:nil];
	[Utility showAlertViewWithTitle:CONST_MULIPLAYER_MESSAGE_OTHER_PLAYER_LEFT_TITLE andMessage:CONST_MULIPLAYER_MESSAGE_OTHER_PLAYER_LEFT_TEXT];
	
}

-(void)setenemyPlayerName:(NSString *)name
{
	NSString *nameStr=[NSString stringWithFormat:@"%@",name];
	[lblEnemyName setString:nameStr];
	
}

-(void)setPlayerName:(NSString *)name
{
	
	NSString *nameStr=[NSString stringWithFormat:@"%@",name];
	[lblPlayerName setString:nameStr];
	
}

-(void)enemyDeployedtheShip
{
	
}

-(void)enemyHitAtCellNumber:(int)cellNumber
{
	[objLayer remoteAttackStart:[NSNumber numberWithInt:cellNumber]];
	
}


- (void) dealloc
{
	NSLog(@"The Game Play Scene Dealloc Scene");
	[backgroundImage stopAllActions];
	[backgroundImage release];
	[horizon release];
	[gameWinScreen release];
	[gameLostScreen release];
	
	[self removeChild:objLayer cleanup:YES];
	[objLayer release];
	[gamePlayGadgetLayer release];
	[txtname release];
	[mainMenuButton release];
	[super dealloc];
}

@end
