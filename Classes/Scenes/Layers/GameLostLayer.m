//
//  GameLostLayer.m
//  iBattleShips
//
//  Created by Ali Zafar on 11/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameLostLayer.h"


@implementation GameLostLayer
@synthesize gameLostScreen,btnOk,btnMenu,delegate;

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		self.gameLostScreen=[CCSprite spriteWithFile:@"white_screen_gameover_lost.png"];
		[gameLostScreen setPosition:CGPointMake(1024/2, 768/2)];
		[self addChild:gameLostScreen];
		
		self.btnOk=[CCMenuItemImage itemFromNormalImage:@"btn_OK.png" selectedImage:@"btn_OK_press.png" target:self selector:@selector(okPressed:)];
		self.btnMenu=[CCMenu menuWithItems:btnOk,nil];
		[btnMenu setPosition:CGPointMake(0, 0)];
		[self addChild:btnMenu];
		
		//[self addChild:btnCancel];
		
		[btnOk setPosition:CGPointMake(1024/2, 768/2-80)];
	}
	return self;
}

-(void)okPressed:(id)sender
{
	[delegate cancelScoreLost];
}
- (void) dealloc
{   [self removeAllChildrenWithCleanup:YES];
	[gameLostScreen release];
	[btnOk release];
	[btnMenu release];
	[super dealloc];
}



@end
