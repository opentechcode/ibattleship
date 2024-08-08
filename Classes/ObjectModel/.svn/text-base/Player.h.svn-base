//
//  Player.h
//  iBattleShips
//
//  Created by Ali Zafar on 11/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationProtocol.h"

@interface Player : NSObject {

	int shots;
	int health;
	
	int lastHitCellNumber;
	
	Map *playerMap;

	
	NSMutableArray *playerShips;
	
	
	int currentPlayerShipsDestroyed;
	
	int selectedShipIndex;
	
	BOOL isPlayerShipsDeployed;
	id <AnimationProtocol>delegate;
	
}


@property(readwrite)int shots;
@property (readwrite)int health;
@property (readwrite)int lastHitCellNumber;
@property (readwrite)int currentPlayerShipsDestroyed;
@property(nonatomic, retain)Map *playerMap;
@property (nonatomic, retain)NSMutableArray *playerShips;
@property(readwrite)int selectedShipIndex;
@property(readwrite)BOOL isPlayerShipsDeployed;
@property (nonatomic, retain)id<AnimationProtocol>delegate;
-(Ship *)getdeadButUnshownShip;

-(void)initializePlayerShips;

- (id) initWithIdentifier:(int)identifier;

-(BOOL)deployRemoteComputerPlayerShips:(NSMutableArray *)ships_deploy;

-(BOOL)deployPlayerShip:(Ship *)ship atLocation:(CGPoint)dropPosition;


-(BOOL)hasMorePlayerShipDestroyed;


-(void)autoDeployShips;
-(void)autoDeployPlayerShips;

-(BOOL)isAPartialPlayerShipDestroyed;

-(void)initializeComputerShips;

-(NSMutableArray *)getPartiallyDemagePlayerShips;

-(void)hitAtCellNumber:(int)cellNumber;
-(void)autoHitAtCellInMap;
-(void)postHitProcessingAfterHitAtCellNumber:(int)cellNumberHit;
-(void)postHitSimpleProcessingAfterHitAtCellNumber:(int)cellNumberHit;
-(void)postHitSimpleRemoteProcessingAfterHitAtCellNumber:(int)cellNumberHit;// Remote Computer Attack

-(void)updatePlayerHealth;
-(void)adjustPositionOfShips;

-(void)remoteHitAtCellNumber:(int)cellNumber;
-(void)autoDeployPlayerShips;

//-(NSMutableArray *)getPartiallyDemageEnemyShips;


@end
