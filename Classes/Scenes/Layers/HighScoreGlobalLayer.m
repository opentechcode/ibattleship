//
//  HighScoreGlobalLayer.m
//  iBattleShips
//
//  Created by Ali Zafar on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HighScoreGlobalLayer.h"
#import "HighScoreManager.h"
#import "OnlineCompetitionManager.h"

@implementation HighScoreGlobalLayer
@synthesize highscores;

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.highscores=[CCSprite spriteWithFile:@"globalHighScore_text.png"];
		[highscores setPosition:CGPointMake(512, 565)];
	}
	return self;
}


-(void)getGlobalScore
{
	
	if (![[OnlineCompetitionManager sharedOnlineCompetitionmanager] isNetworkAvailable]) {
		return ;
	}
	
	
	[self removeAllChildrenWithCleanup:YES];
	alertView=[Utility alertViewWithActivityIndicatorWithTitle:CONST_ALERT_CONNECTING_TITLE andMessage:CONST_ALERT_CONNECTING_MESSAGE];
	
	[self performSelector:@selector(populateLayer:) withObject:nil afterDelay:1.0];
		
	
	
}




-(void)populateLayer:(id)sender
{
	[self removeAllChildrenWithCleanup:YES];
	[self addChild:highscores];
	
	NSArray *scores=[[OnlineCompetitionManager  sharedOnlineCompetitionmanager] getHighScores];
	[alertView dismissWithClickedButtonIndex:0 animated:YES];
	
	
	
	
	int x=200;
	int y=485;
	int xShift=190;
	int count=0;
	
	
	
	for (HighScore *score  in  scores) 
	{	
		x=200;
		count+=1;
		
		//NSLog(@"%@",score.name);	
		
		CCLabel *rank=[CCLabel labelWithString:[NSString stringWithFormat:@"%d",count] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		[rank setColor:ccBLACK];
		[rank setPosition:CGPointMake(x, y)];
		[self addChild:rank];
		
		x+=xShift;
		
		//CCLabel *name=[CCLabel labelWithString:score.name fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		CCLabel *name=[CCLabel labelWithString:score.name dimensions:CGSizeMake(150, 30) alignment:UITextAlignmentLeft fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		
		[name setColor:ccBLACK];
		[name setPosition:CGPointMake(x, y)];
		[self addChild:name];
		x+=xShift;
		
		
		CCLabel *shots=[CCLabel labelWithString:[NSString stringWithFormat:@"%d",score.shots] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		[shots setColor:ccBLACK];
		[shots setPosition:CGPointMake(x, y)];
		[self addChild:shots];
		x+=xShift;
		//[Utility secondsToTimeConversion:score.time];
		NSString *timeString=[[Utility secondsToTimeConversion:score.time] retain];
		CCLabel *time=[CCLabel labelWithString:timeString fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		[time setColor:ccBLACK];
		[time setPosition:CGPointMake(x, y)];
		[self addChild:time];
		x+=xShift;
		
		/*
		 CCLabel *gamMode=[CCLabel labelWithString:[NSString stringWithFormat:@"%d",score.gameMode] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		 [gamMode setColor:ccBLACK];
		 [gamMode setPosition:CGPointMake(x, y)];
		 [self addChild:gamMode];
		 */
		y-=25;
		
	}	
	
	
}

- (void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[self.highscores release];
	[super dealloc];
}


@end
