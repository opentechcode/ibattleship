//
//  StoryScene.m
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "StoryScene.h"
#import "iBattleShipsSound.h"

@implementation StoryScene
@synthesize stringLength,currentIndex,storyLabel,isTimerUnscheduled,story,backgroundImage;

- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		
		CGSize size = [[CCDirector sharedDirector] winSize];

		self.backgroundImage = [CCSprite spriteWithFile:@"Background.png"];
		[self.backgroundImage setPosition:CGPointMake(size.width/2,size.height/2)];
		[self addChild:self.backgroundImage];
		 
		//CCLabel *heading = [CCLabel labelWithString:@"Mission Statement" dimensions:CGSizeMake(500, 200) alignment:UITextAlignmentLeft fontName:@"Verdana-BoldItalic" fontSize:30.5];
		//[heading setColor:ccBLACK];
		//[self addChild:heading];
		//[heading setPosition:ccp(620,410)];
		// create and initialize a Label
		self.storyLabel = [CCLabel labelWithString:@" " dimensions:CGSizeMake(650, 600) alignment:UITextAlignmentLeft fontName:@"Verdana-BoldItalic" fontSize:19.5];
		[self.storyLabel setColor:ccBLACK];
		
		CCSprite *heading = [CCSprite spriteWithFile:@"missionStatement.png"];
		[heading setPosition:CGPointMake(512, 595)];
		[self addChild:heading];
		
		id fadeOut = [CCFadeOut actionWithDuration:1.5];
		id fadeIn = [CCFadeIn actionWithDuration:3];
		id seq=[CCSequence actions:fadeOut,fadeIn,nil];
		//id seq = [CCFlipX actionWithFlipX:YES];
		[heading runAction:seq];
		// ask director the the window size
		
		// position the label on the center of the screen
		self.storyLabel.position = ccp(505.0,200.0) ;//ccp( size.width /2 , size.height/2 );
		self.currentIndex = 0;
		// add the label as a child to this Layer
		[self addChild: self.storyLabel];
		
         
		CCMenuItemImage *skip= [CCMenuItemImage itemFromNormalImage:@"btn_skip_unpressed.png" selectedImage:@"btn_skip_pressed.png" target:self selector:@selector(mainMenu:)];
		[skip setPosition:CGPointMake(860, 190)]; 		
		
		CCMenu *menu =[CCMenu menuWithItems:skip,nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
		[iBattleShipsSound playBackGroundSound];
		story = STORY ;
		
		self.stringLength = [STORY length];
		NSLog(@"The length of the story is %d",self.stringLength);
		self.isTimerUnscheduled = NO;
		[[CCScheduler sharedScheduler] scheduleSelector:@selector(moveCurrentIndexForward:) forTarget:self interval:0.1 paused:NO];

			
				
	
		
	}
	return self;
}

-(void)setComponentsPositions
{
	
	
	
	
	
	
	
	
}

-(void) moveCurrentIndexForward :(id) sender
{
	if (self.currentIndex != self.stringLength -1)
	{
		//NSLog(@"the currentIndex in the timer function %d",self.currentIndex);
		NSRange range = {0,currentIndex};
		[storyLabel setString:[story substringWithRange:range]];
		if (currentIndex >0) 
		{
			NSRange r2 = {currentIndex-1 ,1}; 
			if (![[story substringWithRange:r2] isEqualToString:@" "])
			{
				[iBattleShipsSound playTypingSoundEffect];
				//NSLog(@"%@",[story substringWithRange:r2]); 		
			}
			else {
				//NSLog(@"in the Else Part");
			}

			
		}
				
		self.currentIndex ++;
	}
	else
	{
		[[CCScheduler sharedScheduler] unscheduleSelector:@selector(moveCurrentIndexForward:) forTarget:self];
		self.isTimerUnscheduled = YES;

	}

}
-(void) mainMenu:(id) sender
{    
	if (!self.isTimerUnscheduled) 
	{
		[[CCScheduler sharedScheduler] unscheduleSelector:@selector(moveCurrentIndexForward:) forTarget:self];
	}
	[iBattleShipsSound stopBackGroundSound];

	[[GameManager sharedGameManager]  mainMenu];
	
}
- (void) dealloc
{
	NSLog(@"The Story Scene is Deallocing");
	[self removeAllChildrenWithCleanup:YES];
	[backgroundImage release];
	[storyLabel release];
	[super dealloc];
}


@end
