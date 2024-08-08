//
//  GameSettings.m
//  iBattleShips
//
//  Created by Sajjad Raza on 9/28/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "GameSettings.h"

static GameSettings *sharedGameSettings = nil;
@implementation GameSettings

@synthesize soundEffectsStatus,ambientSoundStatus;

+(GameSettings*) sharedGameSettings
{
   @synchronized(self)
   {
	 if (sharedGameSettings ==nil) 
		{
			sharedGameSettings =[[self alloc] init];
		
		
		}
	
	
   }

return sharedGameSettings;

}
- (id) init
{
	self = [super init];
	if (self != nil) 
	{
		self.soundEffectsStatus = YES;
		self.ambientSoundStatus = YES;
	}
	return self;
}

- (id) initWithCoder:(NSCoder *)coder {
	
	self = [super init];
	if (self != nil)
    {
		self.soundEffectsStatus= [[coder decodeObjectForKey:@"soundEffectsStatus"] boolValue];
		self.ambientSoundStatus= [[coder decodeObjectForKey:@"ambientSoundStatus"] boolValue];

		
    }
    return self;
	
	
}


- (void) encodeWithCoder: (NSCoder *)coder
{
	
	
	[coder encodeObject: [NSNumber numberWithBool:self.soundEffectsStatus] forKey:@"soundEffectsStatus"];
	[coder encodeObject: [NSNumber numberWithBool:self.ambientSoundStatus] forKey:@"ambientSoundStatus"];

	
	
}



- (void) dealloc
{
	
	[super dealloc];
}

@end
