//
//  HighScoreManager.m
//  iBattleShips
//
//  Created by Ali Zafar on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HighScoreManager.h"
#import "HighScore.h"

@implementation HighScoreManager
@synthesize localArray,globalArray;


- (id) init
{
	self = [super init];
	if (self != nil) {
		
		[self loadLocalScores];
		
		
		NSMutableArray *tempArray=[[NSMutableArray alloc] init];
		self.globalArray=tempArray;
		[tempArray release];
		
		
		
	}
	return self;
}

-(void)saveLocalScores
{
	[localArray sortUsingFunction:myCompareFunction context:nil ];
	for (int i=[localArray count]; i>10;i--) {
		
		[localArray removeObjectAtIndex:i-1];
	}
	
	if ([NSKeyedArchiver archiveRootObject:localArray toFile:[iBattleShipsAppDelegate pathForApplicationFile:@"localscores"]]) {
		
		NSLog(@"Score saved");
	}
	else {
		NSLog(@"Score Could not be saved");
	}

	
}



-(void)loadLocalScores
{
	
	NSMutableArray *tempArray=[NSKeyedUnarchiver unarchiveObjectWithFile:[iBattleShipsAppDelegate pathForApplicationFile:@"localscores"]];
	
	if (tempArray !=nil) {
		
		self.localArray=tempArray;
	
	}
	else {
	
		tempArray=[[NSMutableArray alloc] init];
		self.localArray=tempArray;
		[localArray retain];
		[tempArray release];
		/*
		HighScore *highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:50 Time:150 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:50 Time:150 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:80 Time:140 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:30 Time:160 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:55 Time:130 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:40 Time:135 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:50 Time:150 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:50 Time:150 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:50 Time:150 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
		highscore= [[HighScore alloc] initwithName:@"Ali Zafar" Shots:50 Time:150 GameMode:0 andDeviceId:@"123"];
		[localArray addObject:highscore];
	
		*/
		
	}
	[localArray sortUsingFunction:myCompareFunction context:nil ];

	for (int i=[localArray count]; i>10;i--) {
		
		[localArray removeObjectAtIndex:i-1];
	}
	
}

int myCompareFunction( id obj1, id obj2, void *context )
{
	HighScore *compareObject1=(HighScore *)obj1;
	HighScore *compareObject2 =(HighScore *) obj2;
	
	
	if(compareObject1.shots <  compareObject2.shots)
	{
		return NSOrderedAscending;
	}
	else if(compareObject1.shots>  compareObject2.shots)
	{
		return NSOrderedDescending;
	}
	else if(compareObject1.time <  compareObject2.time)
	{
		return NSOrderedAscending;
	}
	else if(compareObject1.time>  compareObject2.time)
	{
		return NSOrderedDescending;
	}
	return NSOrderedSame;
	
}

- (void) dealloc
{
	[localArray release];
	[globalArray release];
	[super dealloc];
	
}




@end
