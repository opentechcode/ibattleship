//
//  AnimationProtocol.h
//  iBattleShips
//
//  Created by Ali Zafar on 11/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AnimationProtocol

@required

-(void)showPlayerBlastAnimationAtPositions:(CGPoint)position;
-(void)showPlayerWaterSplashAnimationAtposition:(CGPoint)position;
-(void)showCompBlastAnimationAtPositions:(CGPoint)position;
-(void)showCompWaterSplashAnimationAtposition:(CGPoint)position;
-(void)updatePlayerShots;
-(void)updatePlayerHealth;
-(void)gameOver;
-(void)textForPlayerShipDestruction;
-(void)textForEnemyShipDestruction;
-(void)showtheShip:(Ship *)ship atPosition:(CGPoint)position;
-(void)slideMapDown;

-(void)submitScore;
-(void)cancelScore;
-(void)cancelScoreLost;
-(void)showtheEnemyShip:(Ship *)ship atPosition:(CGPoint)position;


-(void)removeShipAfterAutoDeployAtIndex:(int)index;

-(void)resetDeployment;

@end
