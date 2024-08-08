//
//  MultiplayerScene.m
//  BattleshipiPhone
//
//  Created by Ali Zafar on 1/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiplayerScene.h"


@implementation MultiplayerScene
@synthesize backgroundImage,menu,automatch,mainmenu,wifi,note;

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		self.backgroundImage = [CCSprite spriteWithFile:@"Background.png"];
		
		[self.backgroundImage setPosition:CGPointMake(size.width/2,size.height/2)];
		
		[self addChild:self.backgroundImage];
		
		self.automatch = [CCMenuItemImage itemFromNormalImage:@"btn_unpress_gameCenter.png" selectedImage:@"btn_press_gamecenter.png" target:self selector:@selector(autoMatch:)];
		self.wifi = [CCMenuItemImage itemFromNormalImage:@"btn_unpress_wifi.png" selectedImage:@"btn_press_wifi.png" target:self selector:@selector(wifiPressed:)];
		
				
		self.mainmenu=[CCMenuItemImage itemFromNormalImage:@"btn_mainMenu_unpress.png" selectedImage:@"btn_mainMenu_press.png" target:self selector:@selector(mainMenu:)];
		[mainmenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X, CONST_MAINMENU_POSITION_Y)];
		
		
		self.menu =[CCMenu menuWithItems:automatch,wifi,mainmenu,nil];
		
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
		[self setComponentsPositions];
				
		self.note=[CCLabel labelWithString:@"Note:  By choosing Local Area Network you can play the WARSHIP Game between iPad, iPhone or iPod Touch devices anywhere using Bluetooth or WiFi connection." dimensions:CGSizeMake(380, 250) alignment:UITextAlignmentLeft fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		[note setPosition:CGPointMake(520, 170)];
		[note setColor:ccBLACK];
		[self addChild:note z:3];
		
		

	}
	return self;
}


-(void)setComponentsPositions
{
	float x=370;//CONST_SCREEN_MIDDLE_POSITION_X;
	float y=450;//CONST_MAIN_TEXT_POSITION_Y;
	
	//float yGap=38.0f;
	//y=y-yGap;
	[automatch setPosition:CGPointMake(x, y)];
	
	//y=y-yGap;
	[wifi setPosition:CGPointMake(1024-370, y)];
	
	
	
	
}

-(void)wifiPressed:(id)sender
{
	[[GameManager sharedGameManager].localWifi startPicker];
}

-(void)autoMatch:(id)sender
{
	[[GameManager sharedGameManager].gamecenter launchAutoMatching];
}

-(void) mainMenu:(id) sender
{    
	[[GameManager sharedGameManager]  mainMenu];
}

- (void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[menu release];
	[automatch release];
	[mainmenu release];
	[wifi release];
	
	[backgroundImage release];
	[super dealloc];
}


@end
