//
//  Ship.h
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface Ship : NSObject 
{

	CCSprite *shipSprite;
	CCSprite *largerShipSprite;

	CGPoint originalPosition;
	CGPoint deployedPosition;
	
	
	NSMutableArray *cellsCoverArray;
	
	NSDictionary *cellsDictionary;
	
	NSString *shipCurrentOrientation;
	NSString *shipType;
	
	NSString *shipText;
	
	int shipLifeState;
	
	float xAdjustment;
	float yAdjustment;
	
	float xVerticallAdjustment;
	float yVerticalAdjustment;
	
	float xHorizontalAdjustment;
	float yHorizontalAdjustment;
	
	float initialXAdjustment;
	float initialYAdjustment;
	
	int points;
	
	BOOL isDeployed;
	BOOL shouldbeRemoved;
	
	int deployedCellNumber;
	BOOL isdrowningAnimationShown;
	
	CCAnimation *destructionAnimation;
	
}

@property (nonatomic,retain)CCSprite *shipSprite;
@property (nonatomic,retain)CCSprite *largerShipSprite;

@property (nonatomic,retain) CCAnimation *destructionAnimation;
@property (nonatomic, retain)NSMutableArray *cellsCoverArray;
@property (nonatomic, retain)NSDictionary *cellsDictionary;
@property (readwrite) float xAdjustment;
@property (readwrite) float yAdjustment;
@property (readwrite) float initialXAdjustment;
@property (readwrite) float initialYAdjustment;
@property (readwrite) BOOL shouldbeRemoved;
@property (readwrite)CGPoint originalPosition;
@property (readwrite)CGPoint deployedPosition;
@property (readwrite) BOOL isDeployed;
@property (nonatomic, retain)NSString *shipCurrentOrientation;
@property (nonatomic, retain)NSString *shipType;
@property (nonatomic, retain)NSString *shipText;
@property(readwrite)int points;
@property(readwrite)int shipLifeState;
@property (readwrite)int deployedCellNumber;
@property (readwrite)BOOL isdrowningAnimationShown;

@property (readwrite)float xVerticallAdjustment;
@property (readwrite)float yVerticalAdjustment;
@property (readwrite)float xHorizontalAdjustment;
@property (readwrite)float yHorizontalAdjustment;


-(Ship *)initWithShipType:(NSString *)shipType andOrientation:(NSString *)currentShipOrientation;

-(NSDictionary *)getOccupiedCellsDirections;
-(void)getShipDeploymentDetails;
-(void)undeployShip;
-(BOOL)isShipDestroyed;
-(BOOL)isPartiallyDemaged;
-(BOOL)amITouchedatPoint:(CGPoint)point;
-(void)shipSpriteSet;
-(void)shipSpriteSetForPlayerAutoDeploy;
-(void)runMyDrowningAnimation;
-(void) fillAnimationDictionary;
@end
