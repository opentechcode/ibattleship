//
//  GameManager.m
//  iBattleShips
//
//  Created by Sajjad Raza on 9/28/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "GameManager.h"
#import "StoryScene.h"
#import "MainMenuScene.h"
#import "iBattleShipsSound.h"
#import "GamePlayScene.h"
#import "OptionScene.h"
#import "CreditScene.h"
#import "HighScoresScene.h"
#import "HelpScene.h"
#import "HowToPlay.h"
#import "MultiplayerScene.h"


static GameManager *gameManager=nil;

@implementation GameManager

@synthesize gameProcessor,mail,mfmail, gamecenter,localWifi;

+(GameManager*) sharedGameManager 
{
	@synchronized(self)
	{
		if (gameManager==nil) 
		{
			gameManager=[[self alloc] init];
			
		}
		
		
	}
	
	return gameManager;
}


- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		MailComposeViewController *tempMail = [[MailComposeViewController alloc] init];
		self.mail=tempMail;
		[tempMail release];
		
		self.mfmail=[[MFMailComposeViewController alloc] init];
		//self.mfmail=tempMFMail;
		
		//[tempMFMail release];
		
		//mfmail setup
		
		[mfmail setSubject:EMAIL_SUBJECT];
		[mfmail setMessageBody:EMAIL_MESSAGE isHTML:YES];
		mfmail.mailComposeDelegate=self;
		[mfmail.view setFrame:CGRectMake(0, 0, 768, 1024)];
		
		UIImage *image=	[UIImage imageNamed:@"Default-Landscape.png"];
		NSData*imageData= UIImagePNGRepresentation(image);
		[mfmail addAttachmentData:imageData mimeType:@"png" fileName:@"BattleShip"];
		
		//[[(iBattleShipsAppDelegate *)[UIApplication sharedApplication].delegate viewController].view addSubview:mail.view];

		////////
		
	//	[[CCDirector sharedDirector].openGLView addSubview:adViewController.view];
		
		GameProcessor *tempProcessor = [[GameProcessor alloc] init];
		self.gameProcessor = tempProcessor;
		[tempProcessor release];
				
	//	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
		
		//[[CCScheduler sharedScheduler] scheduleSelector:@selector(startup:) forTarget:self interval:10.1 paused:NO];
		
		LocalWifiConnection *tempWifiConnection=[[LocalWifiConnection alloc] init];
		self.localWifi=tempWifiConnection;
		[tempWifiConnection release];
		
		
		[iBattleShipsSound preLoadSounds];
		[self loadGameSettings];
		
		
		GameCenter *tempGameCenter= [[GameCenter alloc] init];		
		self.gamecenter=tempGameCenter;
		[tempGameCenter release];
		
		
		
	}
	
	
	return self;
	
	
}


-(void)refreshGameProcessor
{
	
	[gameProcessor release];
	gameProcessor =nil;
	GameProcessor *tempProcessor = [[GameProcessor alloc] init];
	self.gameProcessor = tempProcessor;
	[tempProcessor release];
	
}


#pragma mark orientation Change functions

-(void)orientationChanged:(id)sender
{
	UIDeviceOrientation devOrient = [[UIDevice currentDevice] orientation];
	if (devOrient==currentOrientation) {
		return;
	}
	
	if ((devOrient == UIDeviceOrientationLandscapeLeft) || (devOrient == UIDeviceOrientationLandscapeRight) ) 
	{
		currentOrientation=devOrient;
		
		
		currentOrientation=devOrient;
		[[CCDirector sharedDirector] setDeviceOrientation:devOrient];
		[self changePositionofAdd:currentOrientation];
		[self rotateMailComposer:currentOrientation];
		[gameProcessor setTextFieldOrientation:devOrient];
		
	}
	
	[gameProcessor setTextFieldOrientation:currentOrientation];

	
}



#pragma mark Scene Launching Functions


-(void)startGame
{
	[gamecenter autheticatePlayer];
	
	StoryScene *storyScene= [[StoryScene alloc] init];
	
	[[CCDirector sharedDirector] runWithScene:storyScene];
	//[menuScene changeOrientation:currentOrientation];
	[storyScene release];
	
}
-(void) mainMenu 
{
	[[CCTextureCache sharedTextureCache] removeAllTextures];
	MainMenuScene *menuScene= [[MainMenuScene alloc] init];
	[[CCDirector sharedDirector] replaceScene:menuScene];
	[menuScene release];
	[iBattleShipsSound playMainMenuBackGroundSound];

}


-(void) howtoplayscene
{
	
	HowToPlay * howtoPlay = [[HowToPlay alloc] init];
	[[CCDirector sharedDirector] replaceScene:howtoPlay];
	[howtoPlay release];
}


-(void) optionScene
{
		OptionScene *optionScene= [[OptionScene alloc] init];
		[[CCDirector sharedDirector] replaceScene:optionScene];
		//[menuScene changeOrientation:currentOrientation];
		[optionScene release];
		
	
	
}

-(void) creditScene
{
	CreditScene *creditScene= [[CreditScene alloc] init];
	[[CCDirector sharedDirector] replaceScene:creditScene];
	//[menuScene changeOrientation:currentOrientation];
	[creditScene release];
	
	
	
}
-(void) helpScene
{
	HelpScene *helpScene= [[HelpScene alloc] init];
	[[CCDirector sharedDirector] replaceScene:helpScene];
	//[menuScene changeOrientation:currentOrientation];
	[helpScene release];
	
	
	
}
-(void) highScoreScene
{
	HighScoresScene *highScoreScene= [[HighScoresScene alloc] init];
	[[CCDirector sharedDirector] replaceScene:highScoreScene];
	//[menuScene changeOrientation:currentOrientation];
	[highScoreScene release];
	
	
	
}

-(void)  multiplayerScene
{	
	MultiplayerScene *multiplayerscene= [[MultiplayerScene alloc] init];
	[[CCDirector sharedDirector] replaceScene:multiplayerscene];
	[multiplayerscene release];
}

-(void)multiplayerGamePlayScene
{
	[iBattleShipsSound playGamePlayBackGroundSound];
	//[self removeAddTemporarily];
	gameProcessor.game_type=CONST_GAME_TYPE_MULTI_PLAYER;
	
	GamePlayScene * gameScene = [[GamePlayScene alloc] init];
	gameProcessor.multiPlayerGameManager.delegate=gameScene;
	[gameScene setGameMultiplayer];
	[[CCDirector sharedDirector] replaceScene:gameScene];
	//NSLog(@"The Rretain count of GamePlayScene %d",[gameScene retainCount]);
	[gameScene release];
	
	
}


-(void ) gamePlayScene
{
	[iBattleShipsSound playGamePlayBackGroundSound];

	GamePlayScene * gameScene = [[GamePlayScene alloc] init];
	[[CCDirector sharedDirector] replaceScene:gameScene];
	
	//NSLog(@"The Rretain count of GamePlayScene %d",[gameScene retainCount]);
	[gameScene release];
}

-(void) inviteYourFriends:(id)sender
{
	//MailComposeViewController *mail = [[MailComposeViewController alloc] init];
	//[self.navigationController pushViewController:mail animated:YES];
	//MFMailComposeViewController *mfmail=[[MFMailComposeViewController alloc] init];
	
	
	
	//[mail presentModalViewController:mail animated:YES];
	if(![MFMailComposeViewController canSendMail])
	{
		UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Mail Not Configured" message:@"Please configure your email to use this functionality" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return ;
	}
	
	[[(iBattleShipsAppDelegate *)[UIApplication sharedApplication].delegate viewController].view addSubview:mail.view];
	[mail sendEmail:EMAIL_SUBJECT message:EMAIL_MESSAGE imageFileName:@"BattleShip.png" andImage:[UIImage imageNamed:@"Default-Landscape.png"]];
	//[mail displayComposerSheetWith:EMAIL_SUBJECT message:EMAIL_MESSAGE imageFileName:@"BattleShip.png" andImage:[UIImage imageNamed:@"Default-Landscape.png"]];
	//[mail.view setFrame:CGRectMake(0, 0, 1024, 768)];
	mail.wantsFullScreenLayout=YES;
	
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
{
	[mfmail.view removeFromSuperview];
	[mfmail release];
	mfmail=nil;
//	mfmail=[[MFMailComposeViewController alloc] init];
	
//	[self rotateMailComposer:currentOrientation];
}

-(void)rotateMailComposer:(UIDeviceOrientation)deviceOrientation
{
	
	[mfmail setSubject:EMAIL_SUBJECT];
	[mfmail setMessageBody:EMAIL_MESSAGE isHTML:YES];
	
	UIImage *image=	[UIImage imageNamed:@"Default-Landscape.png"];
	NSData*imageData= UIImagePNGRepresentation(image);
	[mfmail addAttachmentData:imageData mimeType:@"png" fileName:@"BattleShip.png"];
	
	//[mail resignFirstResponder];
	//[mfmail.view removeFromSuperview];
	//[[CCDirector sharedDirector].openGLView addSubview:mail.view];

	if(deviceOrientation==UIDeviceOrientationLandscapeLeft )
	{
		
		CGAffineTransform makeLandscape = CGAffineTransformMakeRotation(M_PI * -1.5f);
		makeLandscape = CGAffineTransformTranslate(makeLandscape, 82, 78);
		makeLandscape = CGAffineTransformScale(makeLandscape, 1.0f, 1.0f);
		mfmail.view.transform = makeLandscape;
		
	//	isRotatedLeft=YES;
		
	}else if (deviceOrientation == UIDeviceOrientationLandscapeRight ) 
	{
		CGAffineTransform makeLandscape = CGAffineTransformMakeRotation(M_PI * 1.5f);
		makeLandscape = CGAffineTransformTranslate(makeLandscape, -82, -78);
		makeLandscape = CGAffineTransformScale(makeLandscape, 1.0f, 1.0f);
		mfmail.view.transform = makeLandscape;
		
		//isRotatedRight=YES;;
		
	}
	 
	
}

#pragma mark Game Load and Save Functions

-(void)loadGameSettings
{
	NSMutableDictionary *game=[NSKeyedUnarchiver unarchiveObjectWithFile:[iBattleShipsAppDelegate pathForApplicationFile:@"GameSetting.plist"]];
	if ( game !=nil )
	{		
		//Assign the attributes
		GameSettings *tempGameSettings=(GameSettings *)[game objectForKey:@"Settings"];
		if(tempGameSettings!=nil)
		{
			[GameSettings sharedGameSettings].soundEffectsStatus = tempGameSettings.soundEffectsStatus;
			[GameSettings sharedGameSettings].ambientSoundStatus = tempGameSettings.ambientSoundStatus;

			
			
		}
	}
}

-(void)saveGameSettings
{
	NSMutableDictionary * gameDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:[iBattleShipsAppDelegate pathForApplicationFile:@"GameSetting.plist"]];
	
	if(gameDictionary != nil)
	{
		[gameDictionary setObject:[GameSettings sharedGameSettings] forKey:@"Settings"];
		if([NSKeyedArchiver archiveRootObject: gameDictionary toFile:[iBattleShipsAppDelegate pathForApplicationFile:@"GameSetting.plist"]]) {
			NSLog(@"Game Save SUCCESSFUL");
		} else {
			NSLog(@"Game Save FAILED");
		}
		
	}
	else {
		
		NSMutableDictionary *gameDictionary=[[NSMutableDictionary alloc] init];
		
		[gameDictionary setObject:[GameSettings sharedGameSettings] forKey:@"Settings"];
		if([NSKeyedArchiver archiveRootObject: gameDictionary toFile:[iBattleShipsAppDelegate pathForApplicationFile:@"GameSetting.plist"]]) {
			NSLog(@"Game Save SUCCESSFUL");
		} else {
			NSLog(@"Game Save FAILED");
		}
		[gameDictionary release];
		
		
	}
}


- (void) dealloc
{
	[gameProcessor release];
	[gamecenter release];
	[localWifi release];
	[super dealloc];
}

@end
