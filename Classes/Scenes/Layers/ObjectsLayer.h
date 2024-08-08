//
//  ObjectsLayer.h
//  iBattleShips
//
//  Created by Sajjad Raza on 10/6/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ObjectsLayer : CCLayer
{
	CCSprite *map;
	CCSprite *largerMap;

	CCSprite *pointer;
	CCSprite *playerBlast;
	CCSprite *playerWaterSplash;
    CCSprite *compBlast;
	CCSprite *compWaterSplash;
	
	int selectedShip;
	BOOL isSelectedShipDragged;
	
	CCAnimation *pointerAnimation;
	
	CCAnimation *playerBalstAnimation;
	CCAnimation *playerWaterSplashAnimation;
	
	CCAnimation *compBalstAnimation;
	CCAnimation *compWaterSplashAnimation;
	
	BOOL isPointerAdded;
	BOOL isBlastAdded;
	BOOL isWaterSplashAdded;
	CGPoint selectedLocation;


}
@property (nonatomic,retain) CCSprite *map;
@property (nonatomic,retain) CCSprite *largerMap;

@property (nonatomic,retain) CCSprite *pointer;

@property (nonatomic,retain) CCSprite *playerWaterSplash;
@property (nonatomic,retain) CCSprite *playerBlast;
@property (nonatomic,retain) CCSprite *compWaterSplash;
@property (nonatomic,retain) CCSprite *compBlast;

@property (readwrite) CGPoint selectedLocation;
@property (readwrite) int selectedShip;
@property (readwrite) BOOL isSelectedShipDragged;
@property (nonatomic,retain) CCAnimation *pointerAnimation;

@property (nonatomic,retain) CCAnimation *playerBlastAnimation;
@property (nonatomic,retain) CCAnimation *playerWaterSplashAnimation;
@property (nonatomic,retain) CCAnimation *compBlastAnimation;
@property (nonatomic,retain) CCAnimation *compWaterSplashAnimation;

@property (readwrite) BOOL isPointerAdded;
@property (readwrite) BOOL isBlastAdded;
@property (readwrite) BOOL isWaterSplashAdded;

-(void) deployPlayerShips;
-(CGPoint) getShipPosition:(int) shipOrder;
-(void) setSelectedShipIndex:(CGPoint)point;
-(void ) removeCorrespondingShipFromLayer :(int) selectedShipIndex;
-(void) putBackShipToMapIfRequired;
-(void) runPointerAnimationAtLocation :(CGPoint) location;
-(void) runPlayerBlastAnimationAtLocation :(CGPoint) location;
-(void) runPlayerWaterSplashAnimationAtLocation :(CGPoint) location;
-(void) runCompBlastAnimationAtLocation :(CGPoint) location;
-(void) runCompWaterSplashAnimationAtLocation :(CGPoint) location;
-(void)computerAttack:(id)sender;
-(void)firButtonPressed:(id)sender;
-(void)turnPlayerOn:(id)sender;
-(void)playerAttack:(id)sender;
-(void)computerAttackStart:(id)sender;
-(void)resetDeployment;
-(void)remoteAttackStart:(id)sender;
-(void)remoteAttack:(id)sender;
-(void)endGame:(id)sender;

@end
