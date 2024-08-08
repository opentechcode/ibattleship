//
//  MainMenuScene.m
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "MainMenuScene.h"
@implementation MainMenuScene
@synthesize backgroundImage,newGame,options,highScores,help,credits,menu,mainMenuImage,inviteFriends,moregames,multiplayer;
- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		//[[GameManager sharedGameManager].gameProcessor addTextField];
		CGSize size = [[CCDirector sharedDirector] winSize];
		///background image
		self.backgroundImage = [CCSprite spriteWithFile:@"MainBackground.png"];
		[self.backgroundImage setPosition:CGPointMake(size.width/2,size.height/2)];
		[self addChild:self.backgroundImage];
		///
	    NSLog(@"The retain Count of the backGround =%d",[self.backgroundImage retainCount]); 
		
		self.mainMenuImage=[CCSprite spriteWithFile:@"txt_mainMeun.png"];
		[self addChild:mainMenuImage];
		
		self.newGame=[CCMenuItemImage itemFromNormalImage:@"btn_newGame_unpress.png" selectedImage:@"btn_newGame_press.png" target:self selector:@selector(gamePlayScene:)];
		
		
		self.options=[CCMenuItemImage itemFromNormalImage:@"btn_option_unpress.png" selectedImage:@"btn_option_press.png" target:self selector:@selector(optionScene:)];
		
		self.highScores=[CCMenuItemImage itemFromNormalImage:@"btn_highScore_unpress.png" selectedImage:@"btn_highScore_press.png" target:self selector:@selector(highScoresScene:)];
	//	self.help=[CCMenuItemImage itemFromNormalImage:@"btn_help_unpress.png" selectedImage:@"btn_help_press.png" target:self selector:@selector(helpScene:)];
		
		self.credits=[CCMenuItemImage itemFromNormalImage:@"btn_credits_unpress.png" selectedImage:@"btn_credits_press.png" target:self selector:@selector(creditScene:)];
	
		self.inviteFriends= [CCMenuItemImage itemFromNormalImage:@"btn_inviteFriends_unpress.png" selectedImage:@"btn_inviteFriends_press.png" target:self selector:@selector(inviteYourFriends:)];

		self.moregames= [CCMenuItemImage itemFromNormalImage:@"btn_unpress_moregames.png" selectedImage:@"btn_unpress_moregames.png" target:self selector:@selector(moregamesUrl:)];

		self.multiplayer= [CCMenuItemImage itemFromNormalImage:@"btn_Multiplayer_unpress.png" selectedImage:@"btn_Multiplayer_press.png" target:self selector:@selector(multiplayer:)];

		self.menu =[CCMenu menuWithItems:newGame,options,highScores,credits,inviteFriends,moregames,multiplayer,nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		[self setComponentsPositions];
		isLocked=NO;
		
	}
	return self;
}

-(void)setComponentsPositions
{
	
	float x=512.0f;
	float y=505.0f;
	
	float yGap=55.0f;
	
	
	[newGame setPosition:CGPointMake(x, y)];;
	
	y=y-yGap;
	
	[multiplayer setPosition:CGPointMake(x, y)];
	
	
	y=y-yGap;
	[options setPosition:CGPointMake(x, y)];
	
	y=y-yGap;
	[highScores setPosition:CGPointMake(x, y)];	

//	y=y-yGap;
	//[help setPosition:CGPointMake(x, y)];
	
	y=y-yGap;
	[credits setPosition:CGPointMake(x, y)];

	y=y-yGap;
	[inviteFriends setPosition:CGPointMake(x, y)];
	y=y-yGap;
	
	[moregames setPosition:CGPointMake(x, y)];
	
	
	[mainMenuImage setPosition:CGPointMake(512, 595)];
	
	
	

}

-(void) inviteYourFriends:(id)sender
{
	NSLog(@"emailPressed Button Pressed"); 
	[[GameManager sharedGameManager] inviteYourFriends:nil];
	/*	
	MailComposeViewController *mail = [[MailComposeViewController alloc] init];
	//[self.navigationController pushViewController:mail animated:YES];
	
	//[mail presentModalViewController:mail animated:YES];
	[[CCDirector sharedDirector].openGLView addSubview:mail.view];

	[mail sendEmail: EMAIL_SUBJECT message: EMAIL_MESSAGE imageFileName:@"Main Image" andImage:[UIImage imageNamed:@"Default-Landscape.png"]];
	//[mail release];
	*/
}

-(void)moregamesUrl:(id)sender
{
	
	NSURL *url = [ [ NSURL alloc ] initWithString: @"http://www.envisionstudios.biz" ];
	
	[[UIApplication sharedApplication] openURL:url];
}

-(void ) gamePlayScene:(id)sender
{
	@synchronized(self)
	{
		if (isLocked) {
			return;
		}
		isLocked=YES;
	}
	[[GameManager sharedGameManager] howtoplayscene];
}

-(void ) optionScene:(id)sender
{
	[[GameManager sharedGameManager] optionScene];
}
-(void ) helpScene:(id)sender
{
	[[GameManager sharedGameManager] helpScene];
	
}
-(void ) creditScene:(id)sender
{
	[[GameManager sharedGameManager] creditScene];
}
-(void ) highScoresScene:(id)sender
{
	[[GameManager sharedGameManager] highScoreScene];
}

-(void ) multiplayer:(id)sender
{
	//[[GameManager sharedGameManager].gamecenter launchAutoMatching];
	[[GameManager sharedGameManager] multiplayerScene];
}


- (void) dealloc
{
	NSLog(@"The MainMenu Scene is Deallocing");
    [menu release]; 
	//NSLog(@" Inthe Dealloc The retain Count of the backGround =%d",[self.backgroundImage retainCount]); 

	[backgroundImage release];	
	[mainMenuImage release];
	[newGame release];
	[credits release];
	[options release];
//	[help release];
	[inviteFriends release];
	[highScores release];
	[moregames release];
	 [multiplayer release];
	[super dealloc];
}

@end
