//
//  CreditScene.m
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "CreditScene.h"


@implementation CreditScene

@synthesize backgroundImage;
- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		///background image
		self.backgroundImage = [CCSprite spriteWithFile:@"about_screen.png"];
		[self.backgroundImage setPosition:CGPointMake(size.width/2,size.height/2)];
		[self addChild:self.backgroundImage];
		CCLabel* label = [CCLabel labelWithString:@"Credit Scene" fontName:@"Marker Felt" fontSize:64];
		
		// ask director the the window size
		
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , 700 );
		
		// add the label as a child to this Layer
		//[self addChild: label];
		
		
		
		CCMenuItemImage *mainmenu=[CCMenuItemImage itemFromNormalImage:@"btn_mainMenu_unpress.png" selectedImage:@"btn_mainMenu_press.png" target:self selector:@selector(mainMenu:)];
		[mainmenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X, CONST_MAINMENU_POSITION_Y)];
		
		CCMenu *menu =[CCMenu menuWithItems:mainmenu,nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
	}
	return self;
}

-(void) mainMenu:(id) sender
{    
	[[GameManager sharedGameManager]  mainMenu];
}

- (void) dealloc
{
	NSLog(@"The Credit Dealloc Scene");
    [backgroundImage release];
	[super dealloc];
}

@end
