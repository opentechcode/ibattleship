//
//  iBattleShipsSound.m
//  iBattleShips
//
//  Created by Sajjad Raza on 9/28/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "iBattleShipsSound.h"
#import "SimpleAudioEngine.h"


@implementation iBattleShipsSound
+(void)preLoadSounds
{
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
	[engine preloadBackgroundMusic:@"StoryBackground.mp3"];
	[engine preloadBackgroundMusic:@"MainMenuBackground.mp3"];
	[engine preloadBackgroundMusic:@"SeaWavesGamePlay.mp3"];


	[engine preloadEffect:@"Click.mp3"];
	[engine preloadEffect:@"Blast.mp3"];
	[engine preloadEffect:@"shipDrowning.mp3"];
	[engine preloadEffect:@"splash.mp3"];
	[engine preloadEffect:@"typingSoundEffect.mp3"];
	[engine preloadEffect:@"typeSound.mp3"];
	[engine preloadEffect:@"MissileLaunch1.mp3"];
	[engine preloadEffect:@"MissileLaunch2.mp3"];
	[engine preloadEffect:@"MissileLaunch.mp3"];


		
}



+(void)playBackGroundSound
{
 if([GameSettings sharedGameSettings].ambientSoundStatus)
	{
		SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
		//[engine preloadBackgroundMusic:@"bg_jingle-bells.mp3"];
		[engine playBackgroundMusic:@"StoryBackground.mp3"];
		
	}
}

+(void)playMainMenuBackGroundSound
{
	if([GameSettings sharedGameSettings].ambientSoundStatus )
	{
	[iBattleShipsSound stopBackGroundSound];
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
	[engine playBackgroundMusic:@"MainMenuBackground.mp3"];
	
	}
}
+(void)playGamePlayBackGroundSound
{
   if([GameSettings sharedGameSettings].ambientSoundStatus )
	{
	[iBattleShipsSound stopBackGroundSound];
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
	//[engine preloadBackgroundMusic:@"bg_jingle-bells.mp3"];
	[engine playBackgroundMusic:@"SeaWavesGamePlay.mp3"];
	
	}
}


+(void)stopBackGroundSound
{
	
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
	[engine stopBackgroundMusic];
	
}

+(void)playButtonSound
{
		if([GameSettings sharedGameSettings].soundEffectsStatus)
	{
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
	[engine playEffect:@"typeSound.mp3"];
	
	}
}

+(void) playTypingSoundEffect
{
	if([GameSettings sharedGameSettings].soundEffectsStatus)
	{
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
	[engine playEffect:@"typeSound.mp3"];
	}
}


+(void) playMissilLaunch1
{
	if([GameSettings sharedGameSettings].soundEffectsStatus)
	{
		SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
		[engine playEffect:@"MissileLaunch1.mp3"];
	}
}

+(void) playMissilLaunch2
{
	if([GameSettings sharedGameSettings].soundEffectsStatus)
	{
		SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
		[engine playEffect:@"MissileLaunch.mp3"];
	}
}


+(void) playBlastSoundEffect
{
	if([GameSettings sharedGameSettings].soundEffectsStatus)
	{
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
	[engine playEffect:@"Blast.mp3"];
	}
}

+(void) playShipDrowningSoundEffect
{
	if([GameSettings sharedGameSettings].soundEffectsStatus)
	{
	    SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
		[engine playEffect:@"shipDrowning.mp3"];
	}
	
}

+(void) playWaterSplashSoundEffect
{
	
	if([GameSettings sharedGameSettings].soundEffectsStatus)
	{
		SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
		[engine playEffect:@"splash.mp3"];
	}
}


@end
