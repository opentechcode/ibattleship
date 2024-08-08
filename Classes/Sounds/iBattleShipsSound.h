//
//  iBattleShipsSound.h
//  iBattleShips
//
//  Created by Sajjad Raza on 9/28/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface iBattleShipsSound : NSObject 
{

}

+(void)preLoadSounds;
+(void)playBackGroundSound;
+(void) playTypingSoundEffect;
+(void)stopBackGroundSound;
+(void)playMainMenuBackGroundSound;
+(void)playGamePlayBackGroundSound;
+(void) playBlastSoundEffect;
+(void) playShipDrowningSoundEffect;
+(void) playWaterSplashSoundEffect;
+(void)playButtonSound;
+(void) playMissilLaunch1;
+(void) playMissilLaunch2;



@end
