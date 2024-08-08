//
//  HowToPlay.m
//  iBattleShips
//
//  Created by Ali Zafar on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HowToPlay.h"


@implementation HowToPlay

@synthesize backgroundImage,lblHowToPlay,okbutton,backgroundUpperImage,mainMenuButton,lblHowToPlayOK;


- (id) init
{
	self = [super init];
	if (self != nil) {
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		///background image
		self.backgroundImage = [CCSprite spriteWithFile:@"howtoplay.png"];
		[self.backgroundImage setPosition:CGPointMake(size.width/2,size.height/2)];
		[self addChild:self.backgroundImage];
		
		///Label 1
		self.backgroundUpperImage = [CCSprite spriteWithFile:@"bg_transparent.png"];
		[self.backgroundUpperImage setPosition:CGPointMake(size.width/2,size.height/2)];
		[self addChild:self.backgroundUpperImage];
		self.lblHowToPlay=[CCLabel labelWithString:CONST_HOW_TO_PLAY_MESSAGE dimensions:CGSizeMake(480, 350) alignment:UITextAlignmentLeft fontName:@"Verdana-BoldItalic" fontSize:CONST_FONT_TITLE_SIZE-3];		
		[self.lblHowToPlay setPosition:CGPointMake(size.width/2,size.height/2-90)];
		[lblHowToPlay setColor:ccBLACK];
		[self addChild:lblHowToPlay];
		
		//////Label 2////////////////
		
		self.lblHowToPlayOK=[CCLabel labelWithString:CONST_HOW_TO_PLAY_MESSAGE_OK dimensions:CGSizeMake(490, 380) alignment:UITextAlignmentLeft fontName:@"Verdana-BoldItalic" fontSize:CONST_FONT_TITLE_SIZE-3];		
		[self.lblHowToPlayOK setPosition:CGPointMake(size.width/2,size.height/2-170)];
		[lblHowToPlayOK setColor:ccBLACK];
		[self addChild:lblHowToPlayOK];
		
		
		////////////////////////////
		
		
		
		self.okbutton=[CCMenuItemImage itemFromNormalImage:@"btn_ok_green.png" selectedImage:@"btn_ok_orange.png" target:self selector:@selector(okButtonPressed:)];		  
		[okbutton setPosition:CGPointMake(720, 330 )];
		
		self.mainMenuButton=[CCMenuItemImage itemFromNormalImage:@"btn_mainMenu_unpress.png" selectedImage:@"btn_mainMenu_press.png" target:self selector:@selector(mainMenuButtonPressed:)];
		
		[mainMenuButton setPosition:CGPointMake(CONST_MAINMENU_POSITION_X, CONST_MAINMENU_POSITION_Y)];
		
		
		
		CCMenu *mnu=[CCMenu menuWithItems:okbutton,nil];
		
		[mnu setPosition:CGPointMake(0, 0)];
		
		[self addChild:mnu];
		isLocked=NO;
		
	}
	return self;
}

-(void)mainMenuButtonPressed:(id)sender
{
	
	[[GameManager sharedGameManager] mainMenu];
}
-(void)okButtonPressed:(id)sender
{	
	@synchronized(self)
	{
		if (isLocked) {
			return;
		}
		isLocked=YES;
	}
	
	[[GameManager sharedGameManager] gamePlayScene];
}

- (void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[backgroundImage release];
	[okbutton release];
	[backgroundUpperImage release];
	[mainMenuButton release];
	[lblHowToPlay release];
	
	[super dealloc];
}
@end
