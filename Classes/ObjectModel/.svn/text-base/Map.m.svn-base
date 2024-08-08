//
//  Map.m
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Map.h"
#import "Cell.h"

@implementation Map

@synthesize cells,lastHitCell,lastBlastCell,mapState,guessGenerator,mapType,blastArray,blastDirections,masterBlastArray,masterBlastDirections;
@synthesize startingX,startingY,mapLocations,mapIdentifier;

//- (id) init
- (id) initWithCoordinates:(float)x StartingY:(float)y Identifier:(int)identifier

{
	self = [super init];
	if (self != nil) 
	{
		
		self.startingX = x;
		self.startingY = y;
		self.mapIdentifier = identifier;
		
		NSMutableArray *tempArray= [[NSMutableArray alloc] initWithCapacity:100];
		self.cells=tempArray;
		[tempArray release];
		
		tempArray= [[NSMutableArray alloc] init];
		self.blastArray=tempArray;
		[tempArray release];
		
		tempArray= [[NSMutableArray alloc] init];
		self.blastDirections=tempArray;
		[tempArray release];
		
		tempArray= [[NSMutableArray alloc] init];
		self.masterBlastArray=tempArray;
		[tempArray release];
		
		tempArray= [[NSMutableArray alloc] init];
		self.masterBlastDirections=tempArray;
		[tempArray release];
		
		AIGuessGenerator *tempGuessGenerator= [[AIGuessGenerator alloc] init];
		self.guessGenerator=tempGuessGenerator;
		[tempGuessGenerator release];
		
		[self populateMapLocations];
		for (int i=0; i<100; i++) 
		{
			
			
			[cells insertObject: [[Cell alloc] initWithcellNumber:i+1] atIndex:i];
			
			lastHitCell=-1;
			
			lastBlastCell=-1;
			
			mapState=CONST_MAP_STATE_SIMPLE;
			
			
		}
		
		
		
		
	}
	return self;
}


-(void)populateMapLocations
{
	float x=self.startingX;
	float y=self.startingY;
	
	NSMutableDictionary *tempDict=[[NSMutableDictionary alloc] init];
	self.mapLocations= tempDict;
	[tempDict release];
	
	
	
	NSMutableArray *playerLocations = [[NSMutableArray alloc] init];
	
	
	for (int i=0; i< 10 ; i++) 
	{
		for (int j = 0; j < 10 ; j++) 
		{
			NSMutableDictionary *dict= [[NSMutableDictionary alloc] init];
			[dict setValue:[NSNumber numberWithFloat:x] forKey:@"X"];
			[dict setValue:[NSNumber numberWithFloat:y] forKey:@"Y"];
			
			[playerLocations addObject:dict];
			[dict release];
			
			x+=50;
			
		}
		
		//y = startY;
		y -=  50;
		x= startingX;
	}
	[mapLocations setValue:playerLocations forKey:@"MapLocations"];	

	
	
	
	
	
	
	
}



-(void) updatePositionsofCells
{
	
	
	
	[mapLocations removeObjectForKey:@"MapLocations"];
	
	
	float startY;
	float startX;
	
	if (self.mapIdentifier == PLAYER_IDENTIFIER) 
	{
		startX=CONST_STARTINGX_PLAYER_GP;
		startY=CONST_STARTINGY_PLAYER_GP;

	}
	else if(self.mapIdentifier == ENEMY_IDENTIFIER)
	{
		startX=CONST_STARTINGX_ENEMY;
		startY=CONST_STARTINGY_ENEMY;

	}
	
	float x=startX;
	float y=startY;
	
	NSMutableArray *player=[[NSMutableArray alloc] init];
	
	
	for (int i=0; i< 10 ; i++) 
	{
		for (int j = 0; j < 10 ; j++) 
		{
			NSMutableDictionary *dict= [[NSMutableDictionary alloc] init];
			[dict setValue:[NSNumber numberWithFloat:x] forKey:@"X"];
			[dict setValue:[NSNumber numberWithFloat:y] forKey:@"Y"];
			
			[player addObject:dict];
			
			
			x+=48;
			
		}
		
		y -=  48;
		x= startX;
	}
	
	
	[mapLocations setValue:player forKey:@"MapLocations"];
	[self fillCellLocationsInArrayWithMapType:self.mapIdentifier];
	
}



-(void)fillCellLocationsInArrayWithMapType:(int)mapIdentifier
{
	
	//NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"MapLocations" ofType:@"plist"];
	//NSDictionary *mapLocation = [[NSDictionary alloc] initWithContentsOfFile:thePath];		
	NSArray *locations = [[NSArray alloc] initWithArray:[mapLocations objectForKey:@"MapLocations"]];	
		
	NSDictionary *locationDict;
	for (int i=0; i<100; i++) 
	{
		locationDict = [locations objectAtIndex:i];
		[[self.cells objectAtIndex:i] setPosX:[[locationDict objectForKey:@"X"] floatValue]];
		[[self.cells objectAtIndex:i] setPosY:[[locationDict objectForKey:@"Y"] floatValue]];

	}
	
	//[mapLocation release];
	[locations release];
}



-(BOOL)deployShip:(Ship *)ship atLocation:(CGPoint)dropPosition {
	
	int cellNumber=[self getCellNumberByLocation:dropPosition];
	BOOL returnVal=NO;
	NSMutableArray *tempArray=  [[NSMutableArray alloc] init];
	
	if (ship.isDeployed) { //if ship is already deployed then clear its cells before redeploying it
		
		for (int i=0 ; i<[ship.cellsCoverArray count] ; i++) {
			
			Cell *cell =	[ship.cellsCoverArray objectAtIndex:i];	
			cell.cellOccupationState=CONST_CELL_OCCUPATION_STATE_EMPTY;
			[tempArray addObject:cell];
			
		}
		
		[ship.cellsCoverArray removeAllObjects];
	}
	if ([ship.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_UP] || [ship.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_Down]) {
	
		returnVal=	[self deployVerticalShip:ship atCell:cellNumber];
	}
	else {
	
		returnVal= [self deployHorizontalShip:ship atCell:cellNumber];
	
	}

	if (!returnVal) {
	
		for (int i=0; i<[tempArray count]; i++) {
			Cell *cell =	[tempArray objectAtIndex:i];	
			cell.cellOccupationState=CONST_CELL_OCCUPATION_STATE_SHIP;
			[ship.cellsCoverArray addObject:cell];
		}
		
	}
	if (returnVal) {
		[ship getShipDeploymentDetails];
	}
	
	return returnVal;
	
	
}




-(BOOL)deployVerticalShip:(Ship *)ship atCell:(int)cellNumber
{
	//get the cell number that need to be occupied
	NSDictionary *cellOccupationDict=[ship getOccupiedCellsDirections];
	//int cellNumber=[self getCellNumberByLocation:dropPosition];
	
	if(cellNumber==-1)
	{
		return NO;
	}
	
	
	
    NSArray *upArray=[cellOccupationDict objectForKey:CONST_CELLS_DIRECTION_UPWARD];
	int neighborcellnumber=cellNumber;
	
	for (int i=0;i<[upArray count];i++) {
		
		neighborcellnumber=[Utility upperCell:neighborcellnumber];
		
		
		
		if(neighborcellnumber==-1 || ![self isCellAvailable:neighborcellnumber])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
		{
			return NO;
		}
		
		
		
		int right_column_neighbor_cell=neighborcellnumber;
		for (int j=1; j<[[upArray objectAtIndex:i] intValue]; j++) 
		{
			if (cellNumber%10==0) {
				right_column_neighbor_cell=[Utility leftCell:right_column_neighbor_cell];
			}
			else {
				right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			}

			
			if(right_column_neighbor_cell==-1 || ![self isCellAvailable:right_column_neighbor_cell])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
			{
				return NO;
			}
			
			
		}
				
		
		
	}
	
	
	NSArray *downArray	=[cellOccupationDict objectForKey:CONST_CELLS_DIRECTION_DOWNWARDS];
	
	neighborcellnumber=cellNumber;
	
	for (int i=0;i<[downArray count];i++) {
		
		neighborcellnumber=[Utility downwardCell:neighborcellnumber];
		if(neighborcellnumber==-1 || ![self isCellAvailable:neighborcellnumber]) 
		{
			return NO;
		}	
		int right_column_neighbor_cell=neighborcellnumber;
		for (int j=1; j<[[downArray objectAtIndex:i] intValue]; j++) {
			if (cellNumber%10==0) {
				right_column_neighbor_cell=[Utility leftCell:right_column_neighbor_cell];
			}
			else {
				right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			}
			//right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			if(right_column_neighbor_cell==-1 || ![self isCellAvailable:right_column_neighbor_cell])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
			{
				return NO;
			}
			
			
		}
		
	}
	
	
	
	NSArray *parralelArray = [cellOccupationDict objectForKey:CONST_CELLS_DIRECTION_PARALLEL];
	neighborcellnumber=cellNumber;
	for (int i=0;i<[parralelArray count];i++) {
		
		
		if(![self isCellAvailable:neighborcellnumber])
		{
			return NO;
		}	
		int right_column_neighbor_cell=neighborcellnumber;
		for (int j=1; j<[[parralelArray objectAtIndex:i] intValue]; j++) {
			
			if (cellNumber%10==0) {
				right_column_neighbor_cell=[Utility leftCell:right_column_neighbor_cell];
			}
			else {
				right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			}
			
			//right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			if(right_column_neighbor_cell==-1 || ![self isCellAvailable:right_column_neighbor_cell])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
			{
				return NO;
			}
			
			
		}
				
	}
	
	
	
	//code come here if all cells where ship need to be deployed are available
	// clear the cells of ship
	
	for (int i=0 ; i<[ship.cellsCoverArray count] ; i++) {
		
		Cell *cell =	[ship.cellsCoverArray objectAtIndex:i];	
		cell.cellOccupationState=CONST_CELL_OCCUPATION_STATE_EMPTY;
		
		
	}
	
	[ship.cellsCoverArray removeAllObjects];
	neighborcellnumber=cellNumber;

	for (int i=0;i<[upArray count];i++) {
		
		neighborcellnumber=[Utility upperCell:neighborcellnumber];		
		
		[self addCellToShip:ship atCell:neighborcellnumber];
		
		
		int right_column_neighbor_cell=neighborcellnumber;
		
		for (int j=1; j<[[upArray objectAtIndex:i] intValue]; j++) 
		{
			
			//right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			if (cellNumber%10==0) {
				right_column_neighbor_cell=[Utility leftCell:right_column_neighbor_cell];
			}
			else {
				right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			}
			
			[self addCellToShip:ship atCell:right_column_neighbor_cell];			
			
			
		}
		
		
		
		
		
	}	
	
	neighborcellnumber=cellNumber;
	
	for (int i=0;i<[downArray count];i++) {
		
		neighborcellnumber=[Utility downwardCell:neighborcellnumber];
		
		[self addCellToShip:ship atCell:neighborcellnumber];
		
		int right_column_neighbor_cell=neighborcellnumber;
		
		for (int j=1; j<[[downArray objectAtIndex:i] intValue]; j++) 
		{
			//right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];		
			if (cellNumber%10==0) {
				right_column_neighbor_cell=[Utility leftCell:right_column_neighbor_cell];
			}
			else {
				right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			}
			
			[self addCellToShip:ship atCell:right_column_neighbor_cell];			
			
		}
		
		
	}	
	
	neighborcellnumber=cellNumber;
	
	for (int i=0;i<[parralelArray count];i++) {
		
		neighborcellnumber=neighborcellnumber;
		
		[self addCellToShip:ship atCell:neighborcellnumber];		
		
		int right_column_neighbor_cell=neighborcellnumber;
		
		for (int j=1; j<[[parralelArray objectAtIndex:i] intValue]; j++) 
		{
			//right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];		
			if (cellNumber%10==0) {
				right_column_neighbor_cell=[Utility leftCell:right_column_neighbor_cell];
			}
			else {
				right_column_neighbor_cell=[Utility rightCell:right_column_neighbor_cell];
			}
			
			[self addCellToShip:ship atCell:right_column_neighbor_cell];
			
			
			
		}
		
	}
	
	[ship getShipDeploymentDetails];
	
	if ([ship.shipType isEqualToString:CONST_SHIP_TYPE_AIRCRAFT_CARRIER] && (cellNumber%10==0)) {
		cellNumber=[Utility leftCell:cellNumber];
		
	}
	
	ship.deployedCellNumber=cellNumber;
	return YES;

	
}


-(void)addCellToShip:(Ship *)ship atCell:(int)cellNumber;
{
	
	Cell *cell=	[self.cells objectAtIndex:cellNumber-1];
	
	cell.cellOccupationState=CONST_CELL_OCCUPATION_STATE_SHIP;
	[ship.cellsCoverArray addObject:cell];
	
}




-(BOOL)deployHorizontalShip:(Ship *)ship atCell:(int)cellNumber
{
	//get the cell number that need to be occupied
	NSDictionary *cellOccupationDict=[ship getOccupiedCellsDirections];
	//int cellNumber=[self getCellNumberByLocation:dropPosition];
	
	if(cellNumber==-1)
	{
		return NO;
	}
	
	
	
    NSArray *rightArray=[cellOccupationDict objectForKey:CONST_CELLS_DIRECTION_RIGHTWARDS];
	
	int neighborcellnumber=cellNumber;
	
	for (int i=0;i<[rightArray count];i++) {
		
		neighborcellnumber=[Utility rightCell:neighborcellnumber];
		
		
		if(neighborcellnumber==-1 || ![self isCellAvailable:neighborcellnumber])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
		{
				return NO;
		}
		
		
		
		int down_column_neighbor_cell=neighborcellnumber;
		for (int j=1; j<[[rightArray objectAtIndex:i] intValue]; j++) 
		{
			if (cellNumber>90) {
				down_column_neighbor_cell=[Utility upperCell:down_column_neighbor_cell];
			}
			else {
				down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			}

			
			if(down_column_neighbor_cell==-1 || ![self isCellAvailable:down_column_neighbor_cell])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
			{
				return NO;
			}
			
			
		}
				
		
	}
	
	
	
	NSArray *leftArray	=[cellOccupationDict objectForKey:CONST_CELLS_DIRECTION_LEFTWARDS];
	
	neighborcellnumber=cellNumber;
	
	for (int i=0;i<[leftArray count];i++) {
		
		neighborcellnumber=[Utility leftCell:neighborcellnumber];
		
		
		if(neighborcellnumber==-1 || ![self isCellAvailable:neighborcellnumber]) 
		{
				return NO;
		}
		
		
		int down_column_neighbor_cell=neighborcellnumber;
		
		for (int j=1; j<[[leftArray objectAtIndex:i] intValue]; j++) 
		{
			//down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			if (cellNumber>90) {
				down_column_neighbor_cell=[Utility upperCell:down_column_neighbor_cell];
			}
			else {
				down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			}
			
			if(down_column_neighbor_cell==-1 || ![self isCellAvailable:down_column_neighbor_cell])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
			{
				return NO;
			}
			
			
		}
		
		
	}
	
	
	
	NSArray *parralelArray = [cellOccupationDict objectForKey:CONST_CELLS_DIRECTION_PARALLEL];
	neighborcellnumber=cellNumber;
	for (int i=0;i<[parralelArray count];i++) {
		
		
		if(![self isCellAvailable:neighborcellnumber])
		{
				return NO;
		}	
		
		
		int down_column_neighbor_cell=neighborcellnumber;
		for (int j=1; j<[[parralelArray objectAtIndex:i] intValue]; j++) 
		{
			//down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			
			if (cellNumber>90) {
				down_column_neighbor_cell=[Utility upperCell:down_column_neighbor_cell];
			}
			else {
				down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			}
			
			
			if(down_column_neighbor_cell==-1 || ![self isCellAvailable:down_column_neighbor_cell])    //-1 means cell is out of grid space and function returns true if cell is empty and not occupied by any ship
			{
				return NO;
			}
			
			
		}
		
		
	}
	
	
	
	//code come here if all cells where ship need to be deployed are available
	// clear the cells of ship
	
	
	for (int i=0 ; i<[ship.cellsCoverArray count] ; i++) {
		
		Cell *cell =	[ship.cellsCoverArray objectAtIndex:i];	
		cell.cellOccupationState=CONST_CELL_OCCUPATION_STATE_EMPTY;
		
		
	}
	
	[ship.cellsCoverArray removeAllObjects];
	
	
	
	neighborcellnumber=cellNumber;
	
	for (int i=0;i<[rightArray count];i++) {
		
		neighborcellnumber=[Utility rightCell:neighborcellnumber];
		[self addCellToShip:ship atCell:neighborcellnumber];
				
		int down_column_neighbor_cell=neighborcellnumber;
		for (int j=1; j<[[rightArray objectAtIndex:i] intValue]; j++) 
		{
			if (cellNumber>90) {
				down_column_neighbor_cell=[Utility upperCell:down_column_neighbor_cell];
			}
			else {
				down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			}
			
			//down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			[self addCellToShip:ship atCell:down_column_neighbor_cell];
			
			
		}
		
	}	
	
	neighborcellnumber=cellNumber;
	for (int i=0;i<[leftArray count];i++) {
		
		neighborcellnumber=[Utility leftCell:neighborcellnumber];
		
		[self addCellToShip:ship atCell:neighborcellnumber];
		
		int down_column_neighbor_cell=neighborcellnumber;
		for (int j=1; j<[[leftArray objectAtIndex:i] intValue]; j++) 
		{
			if (cellNumber>90) {
				down_column_neighbor_cell=[Utility upperCell:down_column_neighbor_cell];
			}
			else {
				down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			}
			
			//down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			[self addCellToShip:ship atCell:down_column_neighbor_cell];
			
		}
		
		
		
	}	
	
	neighborcellnumber=cellNumber;

	for (int i=0;i<[parralelArray count];i++) {
		
		neighborcellnumber=neighborcellnumber;
		[self addCellToShip:ship atCell:neighborcellnumber];
		int down_column_neighbor_cell=neighborcellnumber;
		
		for (int j=1; j<[[parralelArray objectAtIndex:i] intValue]; j++) 
		{
			//down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			if (cellNumber>90) {
				down_column_neighbor_cell=[Utility upperCell:down_column_neighbor_cell];
			}
			else {
				down_column_neighbor_cell=[Utility downwardCell:down_column_neighbor_cell];
			}
			
			[self addCellToShip:ship atCell:down_column_neighbor_cell];
			
		}
		
		
	}
	
	
	
	
	
	[ship getShipDeploymentDetails];
	
	if ([ship.shipType isEqualToString:CONST_SHIP_TYPE_AIRCRAFT_CARRIER] && (cellNumber>90)) {
		cellNumber=[Utility upperCell:cellNumber];
		
	}
	ship.deployedCellNumber=cellNumber;
	return YES;
}

#pragma mark CellAvailability

/*
 
 cell is available if it is empty
 
 */


-(BOOL)isCellAvailable:(int)cellNumber
{
	if (cellNumber<=0 || cellNumber>100) {
		return NO;
	}
	//NSLog(@"cellNumber available?%d",cellNumber);
    Cell *cell=	[cells objectAtIndex:cellNumber-1];
	
	if(cell.cellOccupationState==CONST_CELL_OCCUPATION_STATE_EMPTY)
	{
		return YES;
	}
	
	return NO	;

}

/*
 this function will take the drop point and will return the cell number at that location or if it corresponds to no cell 
 then return -1
 */

 	
-(int)getCellNumberByLocation:(CGPoint)location
{
	
	float minDistance = MIN_VALUE;
	
	int selectedCellIndex= -1;
	
	for (int i=0; i< self.cells.count ; i++)
	{
		Cell *cell = [self.cells objectAtIndex:i];
		float pointDistance = [Utility getDistanceCentrePointandTouch:CGPointMake(cell.posX, cell.posY) TouchLocation:location]; 
		if (minDistance > pointDistance) 
		{
			minDistance = pointDistance;
			 selectedCellIndex = i+1;
		}
		
	}
	
	if (selectedCellIndex !=-1 && minDistance <= MINDISTANCE) 
	{
		//CCSprite *coloredSqaure = [CCSprite spriteWithFile:@"square_orange.png"];
		//NSLog(@"The Mindistance is = %f and the selectedIndex is =%d",minDistance,selectedCellIndex);
		return selectedCellIndex;
	}
	else {
		return -1;
	}

	//return location.x;
			
}


#pragma mark Functions for obtaining neighbor of current cells

/*
 
 This function will return the array of neighbors up down left and right
 
*/



-(NSMutableArray *)getNeighbors:(int)cellNumber
{
	NSMutableArray *returningArray= [[NSMutableArray alloc] init];
	
	int returnCellNumber=[Utility upperCell:cellNumber];
	
	if (returnCellNumber != -1) {
		[returningArray addObject:[NSNumber numberWithInt:returnCellNumber] ];
	}
	
	
	
	returnCellNumber=[Utility downwardCell:cellNumber];
	
	if (returnCellNumber != -1) {
		[returningArray addObject:[NSNumber numberWithInt:returnCellNumber] ];
	}
	
	returnCellNumber=[Utility rightCell:cellNumber];
	if (returnCellNumber != -1) {
		[returningArray addObject:[NSNumber numberWithInt:returnCellNumber] ];
	}
	
	returnCellNumber=[Utility leftCell:cellNumber];
	
	if (returnCellNumber != -1) {
		[returningArray addObject:[NSNumber numberWithInt:returnCellNumber] ];
	}
	
	
	return [returningArray autorelease];
	
		
}
-(int)cellHitStateByCellNumber:(int)cellNumber
{
	Cell *cell=[cells objectAtIndex:cellNumber-1];
	return cell.cellHitState;
}

-(int)cellStateByCellNumber:(int)cellNumber
{
	Cell *cell=[cells objectAtIndex:cellNumber-1];
	return cell.cellOccupationState;
}

#pragma mark AIGuessGenerator methods

-(int)nextHitAtCellNumber:(int)cellAttacked
{
	Cell *cell=[cells objectAtIndex:cellAttacked-1];
	
	if(cell.cellOccupationState==CONST_CELL_OCCUPATION_STATE_SHIP)
	{
		
		cell.cellHitState=CONST_CELL_HIT_STATUS_BLAST;
		
	
		
		self.mapState=CONST_MAP_STATE_SHIP_UNDER_DESTRUCTION;
		
	//	NSLog(@"Ship Got hit");
	}
	else {
		
		cell.cellHitState=CONST_CELL_HIT_STATUS_MISSED;

		
		
	}
	
	
	return cellAttacked;
	
}

-(int)nextHit
{
	int cellAttacked=-1;
	if (mapState==CONST_MAP_STATE_SIMPLE) {
		
		cellAttacked=   [guessGenerator cellToAttack];
	//	NSLog(@"%d",cellAttacked);
	}
	else
	{
		
		cellAttacked=   [guessGenerator cellToAttackWhileMapUnderDestruction:blastArray BlastDirections:blastDirections MasterBlastArray:masterBlastArray MasterBlastDirection:masterBlastArray];
	//	NSLog(@"%d",cellAttacked);
		
	}
	if(cellAttacked==-1)
	{
		return cellAttacked;
	}
	
	Cell *cell=[cells objectAtIndex:cellAttacked-1];
	
	if(cell.cellOccupationState==CONST_CELL_OCCUPATION_STATE_SHIP)
	{
		guessGenerator.lastHitCell=cellAttacked;
		cell.cellHitState=CONST_CELL_HIT_STATUS_BLAST;
		[blastArray addObject:[NSNumber numberWithInt:cellAttacked]];
		[masterBlastArray addObject:[NSNumber numberWithInt:cellAttacked]];

		//if (mapState==CONST_MAP_STATE_SIMPLE) {  // means first blast for ship
		//	[masterBlastArray addObject:[blastArray objectAtIndex:0]];
			//guessGenerator.masterIndex= cellAttacked ;
			
		//}
		
		self.mapState=CONST_MAP_STATE_SHIP_UNDER_DESTRUCTION;
		
		NSLog(@"Ship Got hit");
		NSLog(@"%@",blastArray);
	}
	else {
	
		cell.cellHitState=CONST_CELL_HIT_STATUS_MISSED;
		
		if ([blastArray count]>1) {
			//NSNumber *number= [blastArray objectAtIndex:0];
			
			//NSNumber *swapNumber=  [blastArray objectAtIndex:([blastArray count]-1)];
			[blastArray exchangeObjectAtIndex:0 withObjectAtIndex:([blastArray count]-1)];
			//NSRange range={1,[blastArray count]-1};
			//[blastArray removeObjectsInRange:range];
		}
		
		NSLog(@"%@",blastArray);
	
	}
	
	
	return cellAttacked;
	
	//[guessGenerator cellToAttackWhileMapUnderDestruction:<#(NSMutableArray *)blastArray#>]
	
}

-(void)resetMapState
{
	[blastArray removeAllObjects];
	[masterBlastArray removeAllObjects];
	[blastDirections removeAllObjects];
	[masterBlastDirections removeAllObjects];
	mapState=CONST_MAP_STATE_SIMPLE;
}

-(void)partialResetWithShip:(NSMutableArray *)ships
{
	NSLog(@"Partial reset starts");
	/*for (int i=([blastArray count]-1); i>=0; i--) {
		BOOL shouldRemove=YES;
		int number=	[[blastArray objectAtIndex:i] intValue];
		for (Ship *ship in ships) {
			
			
			for (Cell *cell in ship.cellsCoverArray) {
				if (cell.cellNumber==number) {
					shouldRemove=NO;
					break;
				}
			}
			if (!shouldRemove)
			{
				break;
			}
			
		}
		if (shouldRemove) {
			[blastArray removeObjectAtIndex:i];
		}
		
	}
	*/
	[blastArray removeAllObjects];
	
	for (int i=([masterBlastArray count]-1); i>=0; i--) {
		BOOL shouldRemove=YES;
		int number=	[[masterBlastArray objectAtIndex:i] intValue];
		for (Ship *ship in ships) {
			
		
			for (Cell *cell in ship.cellsCoverArray) {
				if (cell.cellNumber==number) {
					shouldRemove=NO;
					break;
				}
			}
			if (!shouldRemove)
			{
				break;
			}
			
		}
		if (shouldRemove) {
			[masterBlastArray removeObjectAtIndex:i];
		}
		
	}
	
	for (NSNumber *nmb in masterBlastArray) {
		[blastArray addObject:nmb];
	}
	//[blastArray addObject:[masterBlastArray objectAtIndex:0]];
	
	//[masterBlastArray removeAllObjects];
	[blastDirections removeAllObjects];
	[masterBlastDirections removeAllObjects];
	mapState=CONST_MAP_STATE_SHIP_UNDER_DESTRUCTION;
	
	NSLog(@"Partial reset End");
	
}

- (void) dealloc
{
	[cells release];
	[mapLocations release];
	[blastArray release];
	[blastDirections release];
	[masterBlastArray release];
	[masterBlastDirections release];
	[guessGenerator release];
	[super dealloc];
}


@end
