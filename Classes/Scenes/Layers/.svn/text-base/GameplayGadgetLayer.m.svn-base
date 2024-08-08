//
//  GameplayGadgetLayer.m
//  iBattleShips
//
//  Created by Ali Zafar on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameplayGadgetLayer.h"
#import "GameProcessor.h"
#import "Player.h"
@implementation GameplayGadgetLayer
@synthesize autoDeployBtn,clockTimer,menu,enemy_strike_counter,player_strike_counter,secondMenu;
@synthesize player_anchor_image, enemy_anchor_image, upperBar,player_health_bar,enemy_health_bar,startButton;
@synthesize timeLabel,player_count_label1,player_count_label2,player_count_label3,enemy_count_label1,enemy_count_label2,enemy_count_label3;
@synthesize seconds_counter,btnPause,isGameStarted;

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		
		self.autoDeployBtn=[CCMenuItemImage itemFromNormalImage:@"btn_fire_red.png" selectedImage:@"btn_fire_green.png" target:self selector:@selector(firButtonPressed:) ];
		self.startButton=[CCMenuItemImage itemFromNormalImage:@"button_start_unpress.png" selectedImage:@"button_start_press.png" target:self selector:@selector(startButtonPressed:) ];
		self.isGameStarted = NO;
		

		self.secondMenu = [CCMenu menuWithItems:startButton,autoDeployBtn,nil];
		[secondMenu setPosition:CGPointMake(0, 0)];
		[self addChild:secondMenu z:2];

		self.btnPause = [CCMenuItemToggle itemWithTarget:self selector:@selector(pauseTheGame:) items:[CCMenuItemImage itemFromNormalImage:@"btn_pause.png" selectedImage:@"btn_pause.png"],[CCMenuItemImage itemFromNormalImage:@"btn_resume.png" selectedImage:@"btn_resume.png"],nil];
		self.btnPause.selectedIndex=0;		
		self.menu=[CCMenu menuWithItems:btnPause,nil];
		[menu setPosition:CGPointMake(0, 0)];
		
		
		self.clockTimer=[CCSprite spriteWithFile:@"img_watch.png"];
		[self addChild:clockTimer z:2];
		
		self.enemy_strike_counter=[CCSprite spriteWithFile:@"counter.png"];
		self.player_strike_counter=[CCSprite spriteWithFile:@"counter.png"];
		[self addChild:enemy_strike_counter z:2];
		[self addChild:player_strike_counter z:2];
		
				
		self.player_anchor_image=[CCSprite spriteWithFile:@"img_anchor.png"];
		self.enemy_anchor_image=[CCSprite spriteWithFile:@"img_anchor.png"];
		[self addChild:enemy_anchor_image z:0];
		[self addChild:player_anchor_image z:0];
			
		
	/*	self.bottomBar=[CCSprite spriteWithFile:@"bottom_bar.png"];
		[self addChild:bottomBar z:1];
	 */
		self.upperBar=[CCSprite spriteWithFile:@"header_bar.png"];
		[self addChild:upperBar z:1];
		
		[self initializeLabels];
		
		
		
		NSMutableArray *tempArray= [[NSMutableArray alloc] init];
		self.player_health_bar=tempArray;
		[tempArray release];
		
		tempArray =[[NSMutableArray alloc] init];
		self.enemy_health_bar=tempArray;
		[tempArray release];
		//Test
		[self canWeStartGame];
		
		CCTexture2D *tex= [[CCTexture2D alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"strength_bar_black_bite.png" ofType:nil] ]];
		for (int i=0; i<10; i++) {
		
			CCSprite *bar=[CCSprite spriteWithTexture:tex];
			[player_health_bar addObject:bar];
			
		}
		
		
		
		
		for (int i=0; i<10; i++) 
		{
			
			
			CCSprite *bar=[CCSprite spriteWithTexture:tex];
			[player_health_bar addObject:bar];
			
			CCSprite *enemyBar=[CCSprite spriteWithTexture:tex];
			[enemy_health_bar addObject:enemyBar];
			
			
		}
		
		[tex release];
		
		[self setComponentPositions];
		
		seconds_counter=0;
		[[CCScheduler sharedScheduler] scheduleSelector:@selector(updateTime:) forTarget:self interval:1.0f paused:NO];
		//[self updatePlayerCount:12];
		//[self updateEnemyCount:100];
		//[self updatePlayerHealthBar:0];
		//[self updateEnemyHealthBar:0];
	}
	return self;
}
-(void) pauseTheGame:(id)sender
{
	CCMenuItemToggle *toggle= (CCMenuItemToggle*) sender;
	if (toggle.selectedIndex == 0) 
	{
		if (	[GameManager sharedGameManager].gameProcessor.didAppEntertoBackground ) 
		{
			[[CCDirector sharedDirector] startAnimation];
			[GameManager sharedGameManager].gameProcessor.didAppEntertoBackground = NO;
			
		}
		
		[[CCDirector sharedDirector] resume];
		[GameManager sharedGameManager].gameProcessor.isGamePaused = NO;

	}
	else
	{
		[[CCDirector sharedDirector] pause];
        [GameManager sharedGameManager].gameProcessor.isGamePaused =YES; 

	}

}


-(void)initializeLabels
{
	CCLabel *tempLabel=[CCLabel labelWithString:@"00:00:00" fontName:@"ArialRoundedMTBold" fontSize:15.0f];		
	self.timeLabel=tempLabel;
	[tempLabel release];
	[self addChild:timeLabel z:2];
	
	float font_size=25.0f;
	
	
	tempLabel=[CCLabel labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:font_size];	
	[tempLabel setColor:ccBLACK];
	self.player_count_label1=tempLabel;
	[tempLabel release];
	[self addChild:player_count_label1 z:3];
	

	tempLabel=[CCLabel labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:font_size];	
	[tempLabel setColor:ccBLACK];
	self.player_count_label2=tempLabel;
	[tempLabel release];
	[self addChild:player_count_label2 z:3];
	
	tempLabel=[CCLabel labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:font_size];	
	[tempLabel setColor:ccBLACK];
	self.player_count_label3=tempLabel;
	[tempLabel release];
	[self addChild:player_count_label3 z:3];
	
	
	
	tempLabel=[CCLabel labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:font_size];		
	[tempLabel setColor:ccBLACK];
	self.enemy_count_label1=tempLabel;
	[tempLabel release];
	[self addChild:enemy_count_label1 z:3];
	
	tempLabel=[CCLabel labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:font_size];	
	[tempLabel setColor:ccBLACK];
	self.enemy_count_label2=tempLabel;
	[tempLabel release];
	[self addChild:enemy_count_label2 z:3];
	
	tempLabel=[CCLabel labelWithString:@"0" fontName:@"ArialRoundedMTBold" fontSize:font_size];	
	[tempLabel setColor:ccBLACK];
	self.enemy_count_label3=tempLabel;
	[tempLabel release];
	[self addChild:enemy_count_label3 z:3];
	
	

}

-(void)setComponentPositions
{
	[autoDeployBtn setPosition:CGPointMake(900,170)]; 
	[startButton setPosition:CGPointMake(935, 40)]; 
	[btnPause setPosition:CGPointMake(935, 40)];

	[clockTimer setPosition:CGPointMake(1024/2, 740)];
	
	[timeLabel setPosition:CGPointMake(1024/2,710)];
	
	[enemy_strike_counter setPosition:CGPointMake(315, 688)];
	[player_strike_counter setPosition:CGPointMake(700,688)];
	
	
	[enemy_anchor_image setPosition:CGPointMake(60, 682)];
	
	[player_anchor_image setPosition:CGPointMake(970, 682)];
	
	//[bottomBar setPosition:CGPointMake(1024/2, 32)];
	[upperBar setPosition:CGPointMake(1024/2, 730)];
	
	int count_label_y=688;
	
	[player_count_label1 setPosition:CGPointMake(677, count_label_y)];
	[player_count_label2 setPosition:CGPointMake(677+23, count_label_y)];
	[player_count_label3 setPosition:CGPointMake(677+47, count_label_y)];
	
	[enemy_count_label1 setPosition:CGPointMake(292, count_label_y)];
	[enemy_count_label2 setPosition:CGPointMake(292+23, count_label_y)];
	[enemy_count_label3 setPosition:CGPointMake(292+47, count_label_y)];
	
	
	
}


-(void)updatePlayerHealthBar:(int)health
{
	if (health<0 || health >10) {
		return;
	}
	
	for (int i=0; i<10; i++) {
		
		CCSprite *bar=	[player_health_bar objectAtIndex:i];
		[self removeChild:bar cleanup:NO];
		
	}
	
	float x=854.0f;
	float y=739.0f;
	
	float width=15.0f;
	
	int grey_bars=10-health;
	for (int i=0; i<grey_bars; i++) {
		
		CCSprite *bar=	[player_health_bar objectAtIndex:i];
		[bar setPosition:CGPointMake(x, y)];
		[self addChild:bar z:3];
		x=x+width;
	}
	
}

-(void)updateEnemyHealthBar:(int)health
{
	if (health<0 || health >10) {
		return;
	}
	
	
	for (int i=0; i<10; i++) {
		
		CCSprite *bar=	[enemy_health_bar objectAtIndex:i];
		[self removeChild:bar cleanup:NO];
		
	}
	
	float x=35.0f;
	float y=739.0f;
	
	float width=15.0f;
	
	int grey_bars=10-health;
	for (int i=0; i<grey_bars; i++) {
		
		CCSprite *bar=	[enemy_health_bar objectAtIndex:i];
		[bar setPosition:CGPointMake(x, y)];
		[self addChild:bar z:3];
		x=x+width;
	}
	
}


-(void)updateTime:(id)sender
{
	if(self.isGameStarted)
	{
		seconds_counter+=1;
	
	//[self updatePlayerCount:seconds_counter];
	//[self updateEnemyCount:seconds_counter];
	//[self updatePlayerHealthBar:10-seconds_counter];
	//[self updateEnemyHealthBar:10-seconds_counter];

	
	int seconds=seconds_counter%60;
	int minutes=seconds_counter/60;
	int hours=minutes/60;
	minutes=minutes%60;
	
	
	NSString *secondsString;
	NSString *minutesString;
	
	NSString *hoursString;
	
	
	if (seconds<10) {
		secondsString=[NSString stringWithFormat:@"0%d",seconds];
	}else {
		
		secondsString=[NSString stringWithFormat:@"%d",seconds];
	}

	
	if (minutes<10) {
		minutesString=[NSString stringWithFormat:@"0%d",minutes];
	}else {
		
		minutesString=[NSString stringWithFormat:@"%d",minutes];
	}

	if (hours<10) {
		hoursString=[NSString stringWithFormat:@"0%d",hours];
	}else {
		
		hoursString=[NSString stringWithFormat:@"%d",hours];
	}
	
	NSString *timeString=[NSString stringWithFormat:@"%@:%@:%@",hoursString,minutesString,secondsString];
	
	[timeLabel setString:timeString];
	}

}

-(void)finishTimer
{
	[[CCScheduler sharedScheduler] unscheduleSelector:@selector(updateTime:) forTarget:self];
}

-(void)updatePlayerCount:(int)counter
{
	
	
	int singleDigit=counter%10;
	int doubleDigit=(counter/10)%10;
	int threeDigits=counter/100;
	
	[player_count_label3 setString:[NSString stringWithFormat:@"%d",singleDigit]];
	[player_count_label2 setString:[NSString stringWithFormat:@"%d",doubleDigit]];
	[player_count_label1 setString:[NSString stringWithFormat:@"%d",threeDigits]];
	
	
	
		
	
}


-(void)updateEnemyCount:(int)counter
{
		
	int singleDigit=counter%10;
	int doubleDigit=(counter/10)%10;
	int threeDigits=counter/100;
	
	
	[enemy_count_label3 setString:[NSString stringWithFormat:@"%d",singleDigit]];
	[enemy_count_label2 setString:[NSString stringWithFormat:@"%d",doubleDigit]];
	[enemy_count_label1 setString:[NSString stringWithFormat:@"%d",threeDigits]];
	
	
}

-(void) startButtonPressed:(id)sender
{
   if	([self canWeStartGame])
   {
	   self.isGameStarted = YES;
	   //Remove Start Button from Layer 
	   [self removeChild:secondMenu cleanup:YES];

	   //Now remove rest of the Ships from Layer
	   int count = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips count];

	   for (int i= count-1; i >-1 ; i--) 
	   {
		   Ship *ship = (Ship*) [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:i];
		   if (ship.shouldbeRemoved)
		   {
			  // [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips removeObject:ship];

			   [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips removeObject:ship];
			   [GameManager sharedGameManager].gameProcessor.isGameStarted = YES ;
			   
		   }
		   
	   }	
	    if ([GameManager sharedGameManager].gameProcessor.game_type==CONST_GAME_TYPE_SINGLE_PLAYER)
		{
			[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn = YES;
			[[GameManager sharedGameManager].gameProcessor.computerPlayer autoDeployShips];
		}
	   else {
		
		   [[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager sendShipDeploymentMessage:[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips];

	   
	   }

	  //update Positions
	   [[GameManager sharedGameManager].gameProcessor.userPlayer.delegate slideMapDown];
	   [self addChild:menu];
   }
	else 
	{
	// We need to display Some message here to deploy all the ships first
	}

}

-(BOOL) canWeStartGame
{
	int counter=0;
	int count = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips count];
	for (int i=0; i< count; i++) 
	{
		Ship *ship = (Ship*) [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:i];
		if (!ship.shouldbeRemoved)
		{
			counter ++;
		}

	}	
	if (counter == 5) 
	{

		return YES;
	}
	return NO;
}
-(void)firButtonPressed:(id)sender
{
	//[GameManager sharedGameManager].gameProcessor.computerPlayer.health=0;
	[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate resetDeployment];
	[[GameManager sharedGameManager].gameProcessor.userPlayer autoDeployPlayerShips];
	[[GameManager sharedGameManager].gameProcessor.userPlayer adjustPositionOfShips];

  
}

-(void)computerAttack:(id)sender
{
	if ([[GameManager sharedGameManager].gameProcessor isGameOver]) {
		[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
		return;
	}
	
	Player *player =[GameManager sharedGameManager].gameProcessor.userPlayer;
	[GameManager sharedGameManager].gameProcessor.turnInProgress=CONST_TURN_ENEMY;
	[GameManager sharedGameManager].gameProcessor.computerPlayer.shots+=1;
	[player autoHitAtCellInMap];
	[self performSelector:@selector(turnPlayerOn:) withObject:self afterDelay:0.85];
	//[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn=YES;
	
}

-(void)turnPlayerOn:(id)sender
{
	
	[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn=YES;
	autoDeployBtn.visible=YES;
	
	if ([[GameManager sharedGameManager].gameProcessor isGameOver]) {
		[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
		return;
	}
	
	
	
}

/*
-(NSMutableDictionary *)computerAttack
{
	
		Player *player =[GameManager sharedGameManager].gameProcessor.userPlayer;
		int cellNumberHit=[player.playerMap nextHit];
		BOOL isCompleteShipDestroyed=NO;
	
		if ([player hasMorePlayerShipDestroyed]) {
			NSLog(@"A ship completely destroyed hit");
			isCompleteShipDestroyed=YES;
			if ([player isAPartialPlayerShipDestroyed]) {
				
				NSMutableArray *partiallyDemagedShips=[player getPartiallyDemagePlayerShips];
				[player.playerMap partialResetWithShip:partiallyDemagedShips];
				
			}
			else {
				[player.playerMap resetMapState];
				
			}
			
			
			
		}
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	
	[dict setValue:[NSNumber numberWithInt:cellNumberHit] forKey:@"cellNumber"];
	[dict setValue:[NSNumber numberWithBool:isCompleteShipDestroyed] forKey:@"isCompleteShipDestroyed"];
	
	int cellState=[player.playerMap cellStateByCellNumber:cellNumberHit];
	
	[dict setValue:[NSNumber numberWithInt:cellState] forKey:@"cellstate"];
	
	
	return [dict autorelease];
}
*/



- (void) dealloc
{
	NSLog(@"The GadgetLayer Dealloc Scene");

	[[CCScheduler sharedScheduler] unscheduleSelector:@selector(updateTime:) forTarget:self];
	[self removeAllChildrenWithCleanup:YES];
	[menu removeAllChildrenWithCleanup:YES];

	[autoDeployBtn release];
	[startButton release];
	//[menu release];
	
	[secondMenu release];	
	[clockTimer release];
	[upperBar release];
	[enemy_strike_counter release];
	[player_strike_counter release];
	
	[player_anchor_image release];
	[enemy_anchor_image release];
	
//	[bottomBar release];
	
	[player_health_bar removeAllObjects];
	[player_health_bar release];
	
	[enemy_health_bar removeAllObjects];
	[enemy_health_bar release];
	/*
	[timeLabel release];
	
	[player_count_label1 release];
	[player_count_label2 release];
	[player_count_label2 release];
	
	[enemy_count_label1 release];
	[enemy_count_label2 release];
	[enemy_count_label3 release];
	
	*/
	
	[btnPause release];
	[super dealloc];

}



@end
