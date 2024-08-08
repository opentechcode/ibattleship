//
//  GameProcessor.m
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameProcessor.h"
#import "Ship.h"

@implementation GameProcessor
@synthesize isGameStarted,isPlayerTurnOn,selectedCellNoByPlayer,turnInProgress,destroyingshiptext;
@synthesize txtname,isGamePaused;
@synthesize userPlayer,computerPlayer,didAppEntertoBackground,multiPlayerGameManager,game_type;

- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		Player *tempPlayer= [[Player alloc] initWithIdentifier:PLAYER_IDENTIFIER];
		self.userPlayer=tempPlayer;
		[tempPlayer release];
		
		tempPlayer= [[Player alloc] initWithIdentifier:ENEMY_IDENTIFIER];
		self.computerPlayer=tempPlayer;
		[tempPlayer release];
		
		
		
		turnInProgress=CONST_TURN_PLAYER;
		
		self.isGameStarted = NO;
	
	
		self.selectedCellNoByPlayer = -1;
		self.isPlayerTurnOn = NO;
		
		inDisplay=NO;
		UITextField *txtField= [[UITextField alloc] initWithFrame:CGRectMake(346, 327 ,330,30)];
		self.txtname=txtField;
		//[txtname setBackgroundColor:[UIColor colorWithRed:255.0 green:0 blue:0 alpha:1.0f]];
		[txtname setBackgroundColor:[UIColor clearColor]];
		[txtField release];
		self.isGamePaused = NO;
		self.didAppEntertoBackground = NO;
		
		game_type=CONST_GAME_TYPE_SINGLE_PLAYER;
		
		
		MultiPlayerGameManager *tempMultiPlayer= [[MultiPlayerGameManager alloc] init];
		self.multiPlayerGameManager=tempMultiPlayer;
		[tempMultiPlayer release];
		
		//[self setTextFieldOrientation:[[UIDevice currentDevice] orientation]];
		
	//	[self autoDeployEnemyShips];
		
	
	}
	return self;
}


-(BOOL)isGameOver
{
	
	if (userPlayer.health<=0) {
		return YES;
	}
	else if(computerPlayer.health<=0){
		return YES;
	}
	
	
	return NO;
	
	
}



// will be called by front end layer class to deploy ship at particular location
-(void)addTextField
{
	inDisplay=YES;
	[[(iBattleShipsAppDelegate *)[UIApplication sharedApplication].delegate viewController].view addSubview:txtname];
	//[[CCDirector sharedDirector].openGLView addSubview:txtname];
	[txtname becomeFirstResponder];
}

-(void)removeTextField
{
	inDisplay=NO;
	[txtname removeFromSuperview];
}

-(void)setTextFieldOrientation:(UIDeviceOrientation)orient
{
	if (orient==UIDeviceOrientationLandscapeLeft) {
		
		
		CGAffineTransform makeLandscape = CGAffineTransformMakeRotation(4.71238898038469);
		makeLandscape = CGAffineTransformTranslate(makeLandscape, 0, 0);
		makeLandscape = CGAffineTransformScale(makeLandscape, -1.0f, -1.0f);
		txtname.transform = makeLandscape;
		txtname.center= CGPointMake(768-340.0, 510);
		[txtname resignFirstResponder];
		
		if (inDisplay) {
			[txtname becomeFirstResponder];

		}
		
		
		//		
	//	self.adViewController.adMobView.center =  CGPointMake(768-50.0, 656);
	//	txtname.transform
	//	txtname.frame=CGRectMake(470, 250 ,150,50);
		
	}
	else if(orient==UIDeviceOrientationLandscapeRight) {
		
		CGAffineTransform makeLandscape = CGAffineTransformMakeRotation(M_PI * 0.5f);
		makeLandscape = CGAffineTransformTranslate(makeLandscape, 0, 0);
		makeLandscape = CGAffineTransformScale(makeLandscape, -1.0f, -1.0f);
		txtname.transform = makeLandscape;
		txtname.center =  CGPointMake(340, 512);	
		[txtname resignFirstResponder];
		if (inDisplay) {
			[txtname becomeFirstResponder];
			
		}
		//txtname.frame=CGRectMake(70+300, 45+300 ,150,150);
		
	}

	
}





- (void) dealloc
{
	NSLog(@"Game Processor is Deallocing");

	[userPlayer release];
	[computerPlayer release];
	[txtname release];
	[super dealloc];

}



@end
