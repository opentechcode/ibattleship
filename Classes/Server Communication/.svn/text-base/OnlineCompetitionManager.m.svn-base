//
//  OnlineCompetitionManager.m
//  iPuzzle
//
//  Created by Ali Zafar on 6/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OnlineCompetitionManager.h"
#import "ServerCommunication.h"

static OnlineCompetitionManager *manager=nil;


@implementation OnlineCompetitionManager

+(OnlineCompetitionManager *) sharedOnlineCompetitionmanager
{
	@synchronized(self)
	{
		if(manager==nil)
		{
			manager= [[self alloc] init];
		}
		
		
		
	}
	
	return manager;
	
}


-(BOOL)isNetworkAvailableSimpleCheck  // no message display
{
	if([[NetworkWrapper sharedNetworkInstance] isNetworkAvailable])
	{
		
		return YES;
	}
	
	
	
	return NO;
	
}



-(BOOL)isNetworkAvailable
{
	if([[NetworkWrapper sharedNetworkInstance] isNetworkAvailable])
	{
		
		return YES;
	}
	
	
	[Utility showAlertViewWithTitle:CONST_ALERT_NETWORK_UNAVAILABLE_TITLE andMessage:CONST_ALERT_NETWORK_UNAVAILABLE_MESSAGE];
	
	return NO;
	
}



-(BOOL)submitScore:(HighScore *)score
{
	

	//	UIAlertView *alertView=	[Utility alertViewWithActivityIndicatorWithTitle:@"Connecting...." andMessage:@""];
		
		if ([ServerCommunication submitScoreWithName:score.name Shots:score.shots Time:score.time GameMode:score.gameMode andDeviceId:score.deviceId])
		{
			return YES;
		} 
		
	//	[alertView dismissWithClickedButtonIndex:0 animated:YES];
	
	
	return NO;

}




-(NSArray *)getHighScores
{
	
		
	NSDictionary *dict=[ServerCommunication highScoreswithDeviceId:[[UIDevice currentDevice] uniqueIdentifier]];
	
			
		if(dict==nil)
		{
			[Utility showAlertViewWithTitle:CONST_ALERT_SERVER_NOT_FOUND_TITLE andMessage:CONST_ALERT_SERVER_NOT_FOUND_MESSAGE];
			return nil;
		}

	NSArray *scores=nil;
	if ([[dict objectForKey:@"count"] intValue]==0) {
		return nil;
	}
		scores=[dict objectForKey:@"scores"];
		NSMutableArray *returnArray=[[NSMutableArray alloc] init];
		for (NSDictionary *scoredict in scores) {
		
		HighScore *score=[[HighScore alloc] initwithDictionary:scoredict];
		
		[returnArray addObject:score];
		[score release];
		
	}
	
	
	return [returnArray autorelease];
	
	//NSLog(@"%@",scores);
}





- (void) dealloc
{
	
	[super dealloc];
	
}



@end
