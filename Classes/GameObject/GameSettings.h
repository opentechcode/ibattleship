//
//  GameSettings.h
//  iBattleShips
//
//  Created by Sajjad Raza on 9/28/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameSettings : NSObject <NSCoding>
{
	BOOL soundEffectsStatus;
	BOOL ambientSoundStatus;
	
}
+(GameSettings*) sharedGameSettings;
@property (readwrite)BOOL soundEffectsStatus;
@property (readwrite)BOOL ambientSoundStatus;

@end
