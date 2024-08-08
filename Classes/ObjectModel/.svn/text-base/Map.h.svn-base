//
//  Map.h
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ship.h"
#import "Cell.h"
#import "AIGuessGenerator.h"
@interface Map : NSObject 
{

	
	NSMutableArray *cells;
	
	NSMutableArray *blastArray;
	NSMutableArray *blastDirections;
	
	NSMutableArray *masterBlastArray;
	NSMutableArray *masterBlastDirections;
	
	NSMutableDictionary *mapLocations;
	
	int lastHitCell;
	int lastBlastCell;
	
	float startingX;
	float startingY;
	
	AIGuessGenerator *guessGenerator;
	
	int mapState;
	int mapType;
	int mapIdentifier;
}

@property (nonatomic, retain)NSMutableArray *cells;
@property (readwrite) int mapIdentifier;
@property (readwrite)int lastHitCell;
@property (readwrite)int lastBlastCell;
@property (readwrite)int mapType;
@property (readwrite)float startingX;
@property (readwrite)float startingY;


@property (readwrite)int mapState;
@property (nonatomic, retain)AIGuessGenerator *guessGenerator;
@property (nonatomic,retain) NSMutableDictionary *mapLocations;
@property (nonatomic, retain)NSMutableArray *blastArray;
@property (nonatomic, retain)NSMutableArray *blastDirections;

@property (nonatomic, retain)NSMutableArray *masterBlastArray;
@property (nonatomic, retain)NSMutableArray *masterBlastDirections;



-(BOOL)deployShip:(Ship *)ship atLocation:(CGPoint)dropPosition;


-(NSMutableArray *)getNeighbors:(int)cellNumber;

-(int)getCellNumberByLocation:(CGPoint)location;
-(BOOL)isCellAvailable:(int)cellNumber;

-(BOOL)deployShip:(Ship *)ship atLocation:(CGPoint)dropPosition;
-(BOOL)deployHorizontalShip:(Ship *)ship atCell:(int)cellNumber;
-(BOOL)deployVerticalShip:(Ship *)ship atCell:(int)cellNumber;
-(void)addCellToShip:(Ship *)ship atCell:(int)cellNumber;
-(void) fillCellLocationsInArrayWithMapType:(int)mapIdentifier;
-(int)nextHitAtCellNumber:(int)cellAttacked;
-(int)nextHit;
-(int)cellStateByCellNumber:(int)cellNumber;
-(int)cellHitStateByCellNumber:(int)cellNumber;
-(void)resetMapState;
-(void)partialResetWithShip:(NSMutableArray *)ships;
- (id) initWithCoordinates:(float)x StartingY:(float)y Identifier:(int)identifier;
-(void)populateMapLocations;
-(void) updatePositionsofCells;


@end
