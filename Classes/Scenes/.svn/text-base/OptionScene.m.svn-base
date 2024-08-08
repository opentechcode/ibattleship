//
//  OptionScene.m
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "OptionScene.h"


@implementation OptionScene
@synthesize backgroundImage,ambientSound,soundEffects;
- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		CGSize size = [[CCDirector sharedDirector] winSize];
		///background image
		self.backgroundImage = [CCSprite spriteWithFile:@"MainBackground.png"];
		[self.backgroundImage setPosition:CGPointMake(size.width/2,size.height/2)];
		[self addChild:self.backgroundImage];
		///
		
		CCSprite *optionsText=[CCSprite spriteWithFile:@"txt_options.png"];
		[optionsText setPosition:CGPointMake(512, 595)];
		[self addChild:optionsText];
		
		self.ambientSound = [CCMenuItemToggle itemWithTarget:self selector:@selector(ambeintSoundoundSelection:) items:[CCMenuItemImage itemFromNormalImage:@"btn_ambientSoundOn.png" selectedImage:@"btn_ambientSoundOn.png"],[CCMenuItemImage itemFromNormalImage:@"btn_ambientSoundOff.png" selectedImage:@"btn_ambientSoundOff.png"],nil];
		if ([GameSettings sharedGameSettings].ambientSoundStatus)
		{
			self.ambientSound.selectedIndex=0;		

		}
		else 
		{
			self.ambientSound.selectedIndex=1;		

		}

		[self.ambientSound setPosition:CGPointMake(1024/2 - 100,768/2 )];
		
		self.soundEffects = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundEffectsSelection:) items:[CCMenuItemImage itemFromNormalImage:@"btn_soundEffectsOn.png" selectedImage:@"btn_soundEffectsOn.png"],[CCMenuItemImage itemFromNormalImage:@"btn_soundeffectsOff.png" selectedImage:@"btn_soundeffectsOff.png"],nil];
		if ([GameSettings sharedGameSettings].soundEffectsStatus)
		{
			self.soundEffects.selectedIndex=0;		
		}
		else 
		{
			self.soundEffects.selectedIndex=1;		

		}

		[self.soundEffects setPosition:CGPointMake(1024/2 +100,768/2 )];
		
		CCMenuItemImage *mainmenu=[CCMenuItemImage itemFromNormalImage:@"btn_mainMenu_unpress.png" selectedImage:@"btn_mainMenu_press.png" target:self selector:@selector(mainMenu:)];
		[mainmenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X, CONST_MAINMENU_POSITION_Y)];
		
		CCMenu *menu =[CCMenu menuWithItems:self.ambientSound,self.soundEffects,mainmenu,nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
	}
	return self;
}




-(void) mainMenu:(id) sender
{    
	[[GameManager sharedGameManager]  mainMenu];
}
-(void) ambeintSoundoundSelection:(id) sender
{    
    CCMenuItemToggle *toggle=(CCMenuItemToggle *)sender;
	//NSLog(@"The Selected Index %d = ",toggle.selectedIndex);
	//[GameSettings sharedGameSettings].ambientSoundStatus=toggle.selectedIndex;
	if(toggle.selectedIndex==1)
	{
		[iBattleShipsSound stopBackGroundSound];

		[GameSettings sharedGameSettings].ambientSoundStatus = NO;
	}
	else 
	{
		
		[GameSettings sharedGameSettings].ambientSoundStatus = YES;
		[iBattleShipsSound playMainMenuBackGroundSound];
	}
	[[GameManager sharedGameManager] saveGameSettings];
	
	
}
-(void) soundEffectsSelection:(id) sender
{    
	CCMenuItemToggle *toggle=(CCMenuItemToggle *)sender;
	//NSLog(@"The Selected Index %d = ",toggle.selectedIndex);
	//[GameSettings sharedGameSettings].soundEffectsStatus=toggle.selectedIndex;
	if(toggle.selectedIndex==1)
	{
		
		[GameSettings sharedGameSettings].soundEffectsStatus = NO;
	}
	else 
	{
		
		[GameSettings sharedGameSettings].soundEffectsStatus = YES;
	}
	[[GameManager sharedGameManager] saveGameSettings];

	
}


- (void) dealloc
{
	NSLog(@"The Optons Scene is Deallocing");

	[backgroundImage release];
	[ambientSound release];
	[soundEffects release];
	[super dealloc];
}

@end
