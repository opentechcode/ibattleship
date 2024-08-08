//
//  Player.m
//  iBattleShips
//
//  Created by Ali Zafar on 11/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Ship.h"

@implementation Player
@synthesize shots,health,currentPlayerShipsDestroyed,playerMap,playerShips,selectedShipIndex,isPlayerShipsDeployed,delegate;
@synthesize lastHitCellNumber;

- (id) initWithIdentifier:(int)identifier
{
	self = [super init];
	if (self != nil) {
	
		shots=0;
		health=100;
		currentPlayerShipsDestroyed=0;
		self.selectedShipIndex=-1;
		lastHitCellNumber=-1;
		Map *tempMap;
	
		if (identifier==PLAYER_IDENTIFIER) 
		{
			tempMap= [[Map alloc] initWithCoordinates:CONST_STARTINGX_PLAYER StartingY:CONST_STARTINGY_PLAYER Identifier:PLAYER_IDENTIFIER];		
		}
		else if(identifier==ENEMY_IDENTIFIER)
		{
			tempMap= [[Map alloc] initWithCoordinates:CONST_STARTINGX_ENEMY StartingY:CONST_STARTINGY_ENEMY Identifier:ENEMY_IDENTIFIER];		
		}
		
		
		self.playerMap=tempMap;
		[self.playerMap fillCellLocationsInArrayWithMapType:identifier];
		[tempMap release];
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		self.playerShips=tempArray;
		[tempArray release];
		
		if (identifier==PLAYER_IDENTIFIER) {
			[self initializePlayerShips];
		}
		else if(identifier==ENEMY_IDENTIFIER){
			[self initializeComputerShips];
		}

		//[self initializePlayerShips];
		
	}
	return self;
}



-(void)initializePlayerShips
{
   Ship *ship=	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_GUNSHIP_BOAT andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	[ship setXAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_VERTICAL];
	
	[ship setXHorizontalAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_VERTICAL];

	
	[ship setInitialXAdjustment:CONST_GUNSHIP_BOAT_X_INITIAL_ADJUSTMENT_VERTICAL];
	[ship setInitialYAdjustment:CONST_GUNSHIP_BOAT_Y_INITIAL_ADJUSTMENT_VERTICAL];

	
	//NSLog(@"Retain Count of Ship is =%d",[ship retainCount]);
	
	[playerShips addObject:ship];
	//NSLog(@"Retain Count of Ship is =%d",[ship retainCount]);

	[ship release];
	//NSLog(@"Retain Count of Ship is =%d",[ship retainCount]);

	
    ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_AIRCRAFT_CARRIER andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	[ship setXAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_VERTICAL];
	
	[ship setXHorizontalAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_VERTICAL];
	
	
	[ship setInitialXAdjustment:CONST_AIRCRAFT_X_INITIAL_ADJUSTMENT_VERTICAL];
	[ship setInitialYAdjustment:CONST_AIRCRAFT_Y_INITIAL_ADJUSTMENT_VERTICAL];
	//NSLog(@"Retain Count of Ship is =%d",[ship retainCount]);

	[playerShips addObject:ship];
	//NSLog(@"Retain Count of Ship is =%d",[ship retainCount]);

	[ship release];
	//NSLog(@"Retain Count of Ship is =%d",[ship retainCount]);

	
	
	ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_DESTROYER andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	[ship setXAdjustment:CONST_DESTROYER_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_VERTICAL];
	
	[ship setXHorizontalAdjustment:CONST_DESTROYER_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_DESTROYER_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_VERTICAL];
	
	
	[ship setInitialXAdjustment:CONST_DESTROYER_X_INITIAL_ADJUSTMENT_VERTICAL];
	[ship setInitialYAdjustment:CONST_DESTROYER_Y_INITIAL_ADJUSTMENT_VERTICAL];
    [playerShips addObject:ship];
    [ship release];
	
	ship = [[Ship alloc] initWithShipType:CONST_SHIP_TYPE_WARRIOR andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	[ship setXAdjustment:CONST_WARRIOR_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_VERTICAL];
	
	[ship setXHorizontalAdjustment:CONST_WARRIOR_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_WARRIOR_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_VERTICAL];
	
	
	[ship setInitialXAdjustment:CONST_WARRIOR_X_INITIAL_ADJUSTMENT_VERTICAL];
	[ship setInitialYAdjustment:CONST_WARRIOR_Y_INITIAL_ADJUSTMENT_VERTICAL];
	
	
	[playerShips addObject:ship];
	[ship release];
	
	ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_SUBMARINE andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	[ship setXAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_VERTICAL];
    [ship setYAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_VERTICAL];
	
	[ship setXHorizontalAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_VERTICAL];
	
	[ship setInitialXAdjustment:CONST_SUBMARINE_X_INITIAL_ADJUSTMENT_VERTICAL];
	[ship setInitialYAdjustment:CONST_SUBMARINE_Y_INITIAL_ADJUSTMENT_VERTICAL];
	[playerShips addObject:ship];
	[ship release];
//////////////////////////Horizontal Ships	/////////////////////////////////////
	
	ship=	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_GUNSHIP_BOAT andOrientation:CONST_SHIP_ORIENTATION_HORIZONTAL_Right];
	[ship setXAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXHorizontalAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_VERTICAL];
	
	[ship setInitialXAdjustment:CONST_GUNSHIP_BOAT_X_INITIAL_ADJUSTMENT_HORIZONTAL];
	[ship setInitialYAdjustment:CONST_GUNSHIP_BOAT_Y_INITIAL_ADJUSTMENT_HORIZONTAL];
	
	[playerShips addObject:ship];
	[ship release];
	
	
	
	
	
	ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_AIRCRAFT_CARRIER andOrientation:CONST_SHIP_ORIENTATION_HORIZONTAL_Right];
	[ship setXAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXHorizontalAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_VERTICAL];
	
	
	[ship setInitialXAdjustment:CONST_AIRCRAFT_X_INITIAL_ADJUSTMENT_HORIZONTAL];
	[ship setInitialYAdjustment:CONST_AIRCRAFT_Y_INITIAL_ADJUSTMENT_HORIZONTAL];
	[playerShips addObject:ship];
	[ship release];
	
	
	
    ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_DESTROYER andOrientation:CONST_SHIP_ORIENTATION_HORIZONTAL_Right];
	[ship setXAdjustment:CONST_DESTROYER_X_ADJUSTMENT_HORIZONTAL];
	[ship setYAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXHorizontalAdjustment:CONST_DESTROYER_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_DESTROYER_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_VERTICAL];
	
	
	
	[ship setInitialXAdjustment:CONST_DESTROYER_X_INITIAL_ADJUSTMENT_HORIZONTAL];
	[ship setInitialYAdjustment:CONST_DESTROYER_Y_INITIAL_ADJUSTMENT_HORIZONTAL];
	[playerShips addObject:ship];
	[ship release];
	
	
	ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_WARRIOR andOrientation:CONST_SHIP_ORIENTATION_HORIZONTAL_Right];
	[ship setXAdjustment:CONST_WARRIOR_X_ADJUSTMENT_HORIZONTAL];
	[ship setYAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXHorizontalAdjustment:CONST_WARRIOR_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_WARRIOR_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_VERTICAL];
	
	[ship setInitialXAdjustment:CONST_WARRIOR_X_INITIAL_ADJUSTMENT_HORIZONTAL];
	[ship setInitialYAdjustment:CONST_WARRIOR_Y_INITIAL_ADJUSTMENT_HORIZONTAL];
	[playerShips addObject:ship];
	[ship release];
	
	
	
	ship = [[Ship alloc] initWithShipType:CONST_SHIP_TYPE_SUBMARINE andOrientation:CONST_SHIP_ORIENTATION_HORIZONTAL_Right];
	[ship setXAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_HORIZONTAL];
    [ship setYAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXHorizontalAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_VERTICAL];
	
	[ship setInitialXAdjustment:CONST_SUBMARINE_X_INITIAL_ADJUSTMENT_HORIZONTAL];
	[ship setInitialYAdjustment:CONST_SUBMARINE_Y_INITIAL_ADJUSTMENT_HORIZONTAL];
	[playerShips addObject:ship];
	[ship release];
	
	
	
}


-(void)initializeComputerShips
{
	
	Ship *ship=	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_AIRCRAFT_CARRIER andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	
	[ship setXAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_VERTICAL];
	[ship setXHorizontalAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_AIRCRAFT_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_AIRCRAFT_Y_ADJUSTMENT_VERTICAL];
	
	[playerShips addObject:ship];
	[ship release];
	
	
	
    ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_DESTROYER andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	
	[ship setXAdjustment:CONST_DESTROYER_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_VERTICAL];
	[ship setXHorizontalAdjustment:CONST_DESTROYER_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_DESTROYER_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_DESTROYER_Y_ADJUSTMENT_VERTICAL];
	[playerShips addObject:ship];
	[ship release];
	
	
	
	
	
	ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_SUBMARINE andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];

	[ship setXAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_VERTICAL];
	[ship setXHorizontalAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_SUBMARINE_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_SUBMARINE_Y_ADJUSTMENT_VERTICAL];
	[playerShips addObject:ship];
	
	[ship release];
	
	
	
	ship = [[Ship alloc] initWithShipType:CONST_SHIP_TYPE_GUNSHIP_BOAT andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	[ship setXAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_VERTICAL];
	[ship setXHorizontalAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_GUNSHIP_BOAT_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_VERTICAL];
	
	
	[playerShips addObject:ship];
	[ship release];
	
	
	
	ship =	[[Ship alloc] initWithShipType:CONST_SHIP_TYPE_WARRIOR andOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	
	[ship setXAdjustment:CONST_WARRIOR_X_ADJUSTMENT_VERTICAL];
	[ship setYAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_VERTICAL];
	
	[ship setXHorizontalAdjustment:CONST_WARRIOR_X_ADJUSTMENT_HORIZONTAL];
	[ship setYHorizontalAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_HORIZONTAL];
	
	[ship setXVerticallAdjustment:CONST_WARRIOR_X_ADJUSTMENT_VERTICAL];
	[ship setYVerticalAdjustment:CONST_WARRIOR_Y_ADJUSTMENT_VERTICAL];
	
	[playerShips addObject:ship];
	[ship release];
	
	
	
}

#pragma mark Deployment methods
-(BOOL)deployRemoteComputerPlayerShips:(NSMutableArray *)ships_deploy
{
	for (Ship *ship in playerShips) {
		
		for (NSDictionary *dict in ships_deploy) {
			
			if ([ship.shipType isEqualToString:[dict objectForKey:CONST_KEY_SHIP_TYPE]]) {
				
				int cellnumber=[[dict objectForKey:CONST_KEY_CELL_NUMBER] intValue];
				Cell *cell=	[playerMap.cells objectAtIndex:cellnumber-1];
				
				ship.shipCurrentOrientation=[dict objectForKey:CONST_KEY_SHIP_ORIENTATION];
				[self deployPlayerShip:ship atLocation:CGPointMake(cell.posX, cell.posY)];
				
				[ship shipSpriteSet];
				
				break;
				
				
			}
			
		}
		
	}
	
	return YES;
	
}



-(BOOL)deployPlayerShip:(Ship *)ship atLocation:(CGPoint)dropPosition
{
	[playerMap deployShip:ship atLocation:dropPosition];
	
	return NO;
	
}



-(BOOL)hasMorePlayerShipDestroyed
{
	int destructionCount=0;
	
	for (int i=0; i<[playerShips count]; i++) {
		
		Ship *ship=	[playerShips objectAtIndex:i];
		if ([ship isShipDestroyed]) {
			destructionCount+=1;
			
		}
		
		
	}
	
	if (destructionCount  >  currentPlayerShipsDestroyed) 
	{
		
		currentPlayerShipsDestroyed = destructionCount;
		
		return YES;
		
	}
	
	
	
	return NO;
	
}



-(BOOL)isAPartialPlayerShipDestroyed
{
	for (Ship *ship in playerShips) {
		
		if ([ship isPartiallyDemaged]) {
			return YES;
		}
	}
	
	return NO;
}

-(NSMutableArray *)getPartiallyDemagePlayerShips
{
	NSMutableArray *partiallyDemagedShips = [[NSMutableArray alloc] init];
	for (Ship *ship in playerShips) {
		
		if ([ship isPartiallyDemaged]) {
			[partiallyDemagedShips addObject:ship];
		}
		
	}
	
	return [partiallyDemagedShips autorelease];
}


-(void)autoDeployShips
{
	
	
	NSMutableArray *tempCountingArray= [[NSMutableArray alloc] init];
	
	for (int i=0; i<100;i++) {	
		
		NSMutableDictionary *dict= [[NSMutableDictionary alloc] init];
		[dict setObject:[NSNumber numberWithBool:NO] forKey:@"used"];
		[dict setObject:[NSNumber numberWithInt:i+1] forKey:@"number"];
		
		[tempCountingArray addObject:dict];
		
		
		
	}
	
	[Utility simpleShuffle:tempCountingArray];
	
	NSMutableArray *directionArray= [[NSMutableArray alloc] init];
	
	[directionArray addObject:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	//[directionArray addObject:CONST_SHIP_ORIENTATION_VERTICAL_Down];
	[directionArray addObject:CONST_SHIP_ORIENTATION_HORIZONTAL_Right];
	//[directionArray addObject:CONST_SHIP_ORIENTATION_HORIZONTAL_LEFT];
	
	
	
	[Utility simpleShuffle:directionArray];
	
	
	//NSLog(@"%d",[playerShips count]);
	for (int j=0; j<5; j++) {
		
		Ship *ship=[playerShips objectAtIndex:j];
		
		[Utility simpleShuffle:directionArray];
		
		BOOL isShipDeployed=NO;
		
		for (int orientCount=0; orientCount<2; orientCount+=1) {
			
			//[Utility simpleShuffle:directionArray];
			//NSLog(@"%@",directionArray);
			
			for (int i=0; i<[tempCountingArray count]; i++) {
				
				
				ship.shipCurrentOrientation= [directionArray objectAtIndex:orientCount] ;
				
				if ([ship.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_UP]|| ([ship.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_Down])) {
					
					
					NSMutableDictionary *dict=[tempCountingArray objectAtIndex:i];
					if([playerMap deployVerticalShip:ship atCell:[[dict objectForKey:@"number"] intValue]])
					{
						isShipDeployed=YES;
						
						ship.deployedCellNumber=[[dict objectForKey:@"number"] intValue];
						ship.shipCurrentOrientation=CONST_SHIP_ORIENTATION_VERTICAL_UP;	
						ship.isDeployed=YES;
						[ship shipSpriteSet];
						break; // break when successfully deployed;
						
						
					}
					
					
				}
				else {
					
					NSMutableDictionary *dict=[tempCountingArray objectAtIndex:i];
					if([playerMap deployHorizontalShip:ship atCell:[[dict objectForKey:@"number"] intValue]])
					{
						
						isShipDeployed=YES;
						ship.deployedCellNumber=[[dict objectForKey:@"number"] intValue];
						ship.shipCurrentOrientation=CONST_SHIP_ORIENTATION_HORIZONTAL_Right;
						ship.isDeployed=YES;
						[ship shipSpriteSet];
						
						break; // break when successfully deployed;
					}
					
					
				}
				
			} //for i
			
			if (isShipDeployed) {
				break;
			}
		} // for orient count
		
		
		
	} //for j
	
	
	
	for (int i=0; i<[playerShips count]; i++) {
		
		Ship *ship=[playerShips objectAtIndex:i];
		
		[ship getShipDeploymentDetails];
		
	}
	
}


-(void)autoDeployPlayerShips
{
	
	
	NSMutableArray *tempCountingArray= [[NSMutableArray alloc] init];
	
	for (int i=0; i<100;i++) {	
		
		NSMutableDictionary *dict= [[NSMutableDictionary alloc] init];
		[dict setObject:[NSNumber numberWithBool:NO] forKey:@"used"];
		[dict setObject:[NSNumber numberWithInt:i+1] forKey:@"number"];
		
		[tempCountingArray addObject:dict];
		
		
		
	}
	
	[Utility simpleShuffle:tempCountingArray];
	
	NSMutableArray *directionArray= [[NSMutableArray alloc] init];
	
	[directionArray addObject:[NSNumber numberWithInt:0]];// for vertical
	[directionArray addObject:[NSNumber numberWithInt:5]];// for horizontal
	
//	[directionArray addObject:CONST_SHIP_ORIENTATION_VERTICAL_UP];
	//[directionArray addObject:CONST_SHIP_ORIENTATION_VERTICAL_Down];
//	[directionArray addObject:CONST_SHIP_ORIENTATION_HORIZONTAL_Right];
	//[directionArray addObject:CONST_SHIP_ORIENTATION_HORIZONTAL_LEFT];
	
	
	
	[Utility simpleShuffle:directionArray];
	
	
	//NSLog(@"%d",[playerShips count]);
	for (int j=0; j<5; j++) {
		
		[Utility simpleShuffle:directionArray];
		
		
		
		
		
		BOOL isShipDeployed=NO;
		
		for (int orientCount=0; orientCount<2; orientCount+=1) {
			
			//[Utility simpleShuffle:directionArray];
			//NSLog(@"%@",directionArray);
			
		    int shift=[[directionArray objectAtIndex:orientCount] intValue];
			Ship *ship=[playerShips objectAtIndex:j+shift];
			
			
			
			for (int i=0; i<[tempCountingArray count]; i++) {
				
				
			//	ship.shipCurrentOrientation= [directionArray objectAtIndex:orientCount] ;
				
				if ([ship.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_UP]|| ([ship.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_Down])) {
					
					
					NSMutableDictionary *dict=[tempCountingArray objectAtIndex:i];
					if([playerMap deployVerticalShip:ship atCell:[[dict objectForKey:@"number"] intValue]])
					{
						isShipDeployed=YES;
						
						ship.deployedCellNumber=[[dict objectForKey:@"number"] intValue];
						ship.shipCurrentOrientation=CONST_SHIP_ORIENTATION_VERTICAL_UP;	
						ship.isDeployed=YES;
						[ship shipSpriteSetForPlayerAutoDeploy];
						ship.shouldbeRemoved=NO;
						[delegate removeShipAfterAutoDeployAtIndex:shift+j];
						break; // break when successfully deployed;
						
						
					}
					
					
				}
				else {
					
					NSMutableDictionary *dict=[tempCountingArray objectAtIndex:i];
					if([playerMap deployHorizontalShip:ship atCell:[[dict objectForKey:@"number"] intValue]])
					{
						
						isShipDeployed=YES;
						ship.deployedCellNumber=[[dict objectForKey:@"number"] intValue];
						ship.shipCurrentOrientation=CONST_SHIP_ORIENTATION_HORIZONTAL_Right;
						ship.isDeployed=YES;
						[ship shipSpriteSetForPlayerAutoDeploy];
						ship.shouldbeRemoved=NO;
						[delegate removeShipAfterAutoDeployAtIndex:shift+j];
						break; // break when successfully deployed;
					}
					
					
				}
				
			} //for i
			
			if (isShipDeployed) {
				break;
			}
		} // for orient count
		
		
		
	} //for j
	
	
	
	for (int i=0; i<[playerShips count]; i++) {
		
		Ship *ship=[playerShips objectAtIndex:i];
		
		[ship getShipDeploymentDetails];
		
	}
	
}

-(void)adjustPositionOfShips
{
	
	for (int j=0; j<[playerShips count]; j++) {
		
		
		Ship *ship=[playerShips objectAtIndex:j];
		if (ship.isDeployed) {
			
		
		Cell *cell=[playerMap.cells objectAtIndex:(ship.deployedCellNumber-1)];
		
		[ship setDeployedPosition:CGPointMake(cell.posX+ship.xAdjustment, cell.posY+ship.yAdjustment)];
		[ship.shipSprite setPosition:ship.deployedPosition];
		[delegate showtheShip:ship atPosition:CGPointMake(cell.posX+ship.xAdjustment , cell.posY+ship.yAdjustment)];
		}
	}
	
	//Cell *cell=[playerMap. objectAtIndex:cellNumberHit-1];
}


#pragma mark Cell Hits Methods

-(void)remoteHitAtCellNumber:(int)cellNumber
{
	
	int cellNumberHit=[self.playerMap nextHitAtCellNumber:cellNumber];
	
	lastHitCellNumber=cellNumberHit;
	
	[self postHitSimpleRemoteProcessingAfterHitAtCellNumber:cellNumberHit];
	
}

-(void)hitAtCellNumber:(int)cellNumber
{
	//Player *player=[GameManager sharedGameManager].gameProcessor.computerPlayer;
	
	//Put the cell No. selected by player to attack to replace 1
	
	
	int cellNumberHit=[self.playerMap nextHitAtCellNumber:cellNumber];
	
	lastHitCellNumber=cellNumberHit;
	
	[self postHitSimpleProcessingAfterHitAtCellNumber:cellNumberHit];
	
	
}

-(void)autoHitAtCellInMap
{
	//Player *player =[GameManager sharedGameManager].gameProcessor.userPlayer;
	int cellNumberHit=[self.playerMap nextHit];
	lastHitCellNumber=cellNumberHit;
	[self postHitProcessingAfterHitAtCellNumber:cellNumberHit];
	
}

#pragma mark After Cell Hit Processing
// for enemy ships
-(void)postHitSimpleProcessingAfterHitAtCellNumber:(int)cellNumberHit
{
	BOOL isCompleteShipDestroyed=NO;
	
	if ([self hasMorePlayerShipDestroyed]) {
		//NSLog(@"A ship completely destroyed hit");
		isCompleteShipDestroyed=YES;
		Ship *ship=[self getdeadButUnshownShip];
		
		if(ship != nil)
		{
			ship.isdrowningAnimationShown=YES;
			Cell *cell=	[playerMap.cells objectAtIndex:ship.deployedCellNumber-1];
		
			[delegate showtheEnemyShip:ship atPosition:CGPointMake(cell.posX+ship.xAdjustment, cell.posY+ship.yAdjustment)];
			[ship runMyDrowningAnimation];
		}
		
		[delegate textForEnemyShipDestruction];
		
		if ([self isAPartialPlayerShipDestroyed]) {
			
			[self.playerMap resetMapState];
			
			
			
		}
		else {
			
			[self.playerMap resetMapState];
			
		}
		
		
		
	}
	
	Cell *cell=[playerMap.cells objectAtIndex:cellNumberHit-1];
	if(cell.cellHitState==CONST_CELL_HIT_STATUS_BLAST)
	{
		[delegate showCompBlastAnimationAtPositions:CGPointMake(cell.posX, cell.posY)];
	}
	else if(cell.cellHitState==CONST_CELL_HIT_STATUS_MISSED)
	{
		[delegate showCompWaterSplashAnimationAtposition:CGPointMake(cell.posX, cell.posY)];
		
	}
	//shots+=1;
	[delegate updatePlayerShots];
	[self updatePlayerHealth];
	[delegate updatePlayerHealth];
	/*
	if (shots>10) {
		health=0;
	}
	 */
	
	//health=0;
	int cellState=[self.playerMap cellHitStateByCellNumber:cellNumberHit];
	
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];	
	[dict setValue:[NSNumber numberWithInt:cellNumberHit] forKey:@"cellNumber"];
	[dict setValue:[NSNumber numberWithBool:isCompleteShipDestroyed] forKey:@"isCompleteShipDestroyed"];	
	[dict setValue:[NSNumber numberWithInt:cellState] forKey:@"cellstate"];
}


-(void)postHitProcessingAfterHitAtCellNumber:(int)cellNumberHit
{
	BOOL isCompleteShipDestroyed=NO;
	
	if ([self hasMorePlayerShipDestroyed]) {
		//NSLog(@"A ship completely destroyed hit");
		isCompleteShipDestroyed=YES;
	
		Ship *ship=[self getdeadButUnshownShip];
		
		if(ship != nil)
		{
			ship.isdrowningAnimationShown=YES;
			
			//[delegate showtheShip:ship atPosition:ship.deployedPosition];	
			[ship runMyDrowningAnimation];
		}
		
		[delegate textForPlayerShipDestruction];
		
		if ([self isAPartialPlayerShipDestroyed]) {
			
			NSMutableArray *partiallyDemagedShips=[self getPartiallyDemagePlayerShips];
			[self.playerMap partialResetWithShip:partiallyDemagedShips];
			
			
			
		}
		else {
			
			[self.playerMap resetMapState];
			
		}
		
		
		
	}
	
	Cell *cell=[playerMap.cells objectAtIndex:cellNumberHit-1];
	if(cell.cellHitState==CONST_CELL_HIT_STATUS_BLAST)
	{
		[delegate showPlayerBlastAnimationAtPositions:CGPointMake(cell.posX, cell.posY)];
	}
	else if(cell.cellHitState==CONST_CELL_HIT_STATUS_MISSED)
	{
		[delegate showPlayerWaterSplashAnimationAtposition:CGPointMake(cell.posX, cell.posY)];
		
	}
	//shots+=1;
	[delegate updatePlayerShots];
	[self updatePlayerHealth];
	[delegate updatePlayerHealth];
	int cellState=[self.playerMap cellHitStateByCellNumber:cellNumberHit];
	
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];	
	[dict setValue:[NSNumber numberWithInt:cellNumberHit] forKey:@"cellNumber"];
	[dict setValue:[NSNumber numberWithBool:isCompleteShipDestroyed] forKey:@"isCompleteShipDestroyed"];	
	[dict setValue:[NSNumber numberWithInt:cellState] forKey:@"cellstate"];
	
	
}


-(void)postHitSimpleRemoteProcessingAfterHitAtCellNumber:(int)cellNumberHit
{
	BOOL isCompleteShipDestroyed=NO;
	
	if ([self hasMorePlayerShipDestroyed]) {
		//NSLog(@"A ship completely destroyed hit");
		isCompleteShipDestroyed=YES;
		
		Ship *ship=[self getdeadButUnshownShip];
		
		if(ship != nil)
		{
			ship.isdrowningAnimationShown=YES;
			Cell *cell=	[playerMap.cells objectAtIndex:ship.deployedCellNumber-1];
			
			[delegate showtheEnemyShip:ship atPosition:CGPointMake(cell.posX+ship.xAdjustment, cell.posY+ship.yAdjustment)];
			[ship runMyDrowningAnimation];
		}
		
		[delegate textForPlayerShipDestruction];
		
		if ([self isAPartialPlayerShipDestroyed]) {
			[self.playerMap resetMapState];
			//NSMutableArray *partiallyDemagedShips=[self getPartiallyDemagePlayerShips];
			//[self.playerMap partialResetWithShip:partiallyDemagedShips];
			
			
			
		}
		else {
			
			[self.playerMap resetMapState];
			
		}
		
		
		
	}
	
	Cell *cell=[playerMap.cells objectAtIndex:cellNumberHit-1];
	if(cell.cellHitState==CONST_CELL_HIT_STATUS_BLAST)
	{
		[delegate showPlayerBlastAnimationAtPositions:CGPointMake(cell.posX, cell.posY)];
	}
	else if(cell.cellHitState==CONST_CELL_HIT_STATUS_MISSED)
	{
		[delegate showPlayerWaterSplashAnimationAtposition:CGPointMake(cell.posX, cell.posY)];
		
	}
	//shots+=1;
	[delegate updatePlayerShots];
	[self updatePlayerHealth];
	//health=0;
	[delegate updatePlayerHealth];
	int cellState=[self.playerMap cellHitStateByCellNumber:cellNumberHit];
	
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];	
	[dict setValue:[NSNumber numberWithInt:cellNumberHit] forKey:@"cellNumber"];
	[dict setValue:[NSNumber numberWithBool:isCompleteShipDestroyed] forKey:@"isCompleteShipDestroyed"];	
	[dict setValue:[NSNumber numberWithInt:cellState] forKey:@"cellstate"];
}


-(void)updatePlayerHealth
{
	self.health=0;
	for (Ship *ship in playerShips ) {
		if (ship.shipLifeState==CONST_SHIP_LIFE_ALIVE) {
			health+=ship.points;
		}
		
	}
}

-(Ship *)getdeadButUnshownShip
{
	for (Ship *ship in playerShips) {
		
		if (ship.shipLifeState==CONST_SHIP_LIFE_DEAD && ship.isdrowningAnimationShown==NO) {
			//NSLog(@"%@", ship.shipType);
			return ship;
		}
		
		
	}
	
	return nil;
}
- (void) dealloc
{
	//NSLog(@"Player is Deallocing");

	[playerMap release];
	[playerShips removeAllObjects];
	[playerShips release];
	[super dealloc];
}



@end
