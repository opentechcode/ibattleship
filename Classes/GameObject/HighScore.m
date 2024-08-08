//
//  HighScore.m
//  iBattleShips
//
//  Created by Ali Zafar on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HighScore.h"


@implementation HighScore
@synthesize gameMode,time,shots,name,deviceId;

- (id) init
{
	self = [super init];
	
	if (self != nil) {
		
		
		
	}
	return self;
}

-(HighScore *)initwithName:(NSString *)scorername Shots:(int)scorershots Time:(int)scorertime GameMode:(int)scorergameMode andDeviceId:(NSString *)scorer_device_id;
{
	
	self = [super init];
	
	if (self != nil) {
		
		self.name=scorername;
		self.shots=scorershots;
		self.time=scorertime;
		self.gameMode=scorergameMode;
		self.deviceId=scorer_device_id;
		
		
	}
	
	return self;
	
	
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
	
	
	
	[aCoder encodeObject:name forKey:@"name"];
	[aCoder encodeInt:shots forKey:@"shots"];
	[aCoder encodeInt:time forKey:@"time"];
	[aCoder encodeInt:gameMode forKey:@"gameMode"];
	[aCoder encodeObject:@"deviceId"]	;
	
	
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	
	if (self != nil)
    {
		
		self.name   =     [aDecoder decodeObjectForKey:@"name"];
		self.shots  =    [aDecoder decodeIntForKey:@"shots"];
		self.time   =     [aDecoder decodeIntForKey:@"time"];
		self.gameMode =	[aDecoder decodeIntForKey:@"gameMode"];
		self.deviceId = [aDecoder decodeObjectForKey:@"deviceId"];
		
	}	
	
	
	return self;
	
}



-(HighScore *)initwithDictionary:(NSDictionary *)dict
{
	
	self = [super init];
	
	if (self != nil) {
	
		self.name=[dict objectForKey:@"name"];
		self.shots= [[dict objectForKey:@"shots"] intValue];
		self.time=[[dict objectForKey:@"time"] intValue];
		self.gameMode=[[dict objectForKey:@"gameMode"] intValue];
		self.deviceId=[dict objectForKey:@"deviceid"];
		
	}
	
	return self;
	
	
}



@end
