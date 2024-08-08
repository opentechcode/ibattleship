//
//  StoryScene.h
//  iBattleships
//
//  Created by Sajjad Raza on 9/30/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StoryScene :CCScene 
{

	CCTimer *timer;
	int stringLength;
	int currentIndex;
	NSString *story;
	CCLabel *storyLabel;
	BOOL isTimerUnscheduled;
	CCSprite *backgroundImage;
	
	
	
}
@property (readwrite) int stringLength;
@property (readwrite) int currentIndex;
@property (nonatomic ,retain) NSString* story;
@property (nonatomic ,retain) CCLabel *storyLabel;
@property (readwrite) BOOL isTimerUnscheduled;
@property (nonatomic,retain) CCSprite *backgroundImage;

-(void)setComponentsPositions;

 @end
