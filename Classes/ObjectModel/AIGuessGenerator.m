//
//  AIGuessGenerator.m
//  iBattleShips
//
//  Created by Ali Zafar on 10/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AIGuessGenerator.h"


@implementation AIGuessGenerator
@synthesize cellsToHit,directionArray,cellsTrackerDict,lastHitCell;
- (id) init
{
	self = [super init];
	if (self != nil) {
		
		currentIndex=0;
		
		NSMutableArray *tempArray= [[NSMutableArray alloc] init];
		self.cellsToHit=tempArray;
		[tempArray release];
	
		for (int i=0; i<CONST_CELLS_TOTAL_GRIDS; i++) {
			NSMutableDictionary *dict= [[NSMutableDictionary alloc] init];
			[dict setObject:[NSNumber numberWithInt:i+1] forKey:@"number"];
			[dict setObject:[NSNumber numberWithBool:NO] forKey:@"used"];
			[cellsToHit addObject:dict];
			
		}
		
		tempArray= [[NSMutableArray alloc] init];
		self.directionArray=tempArray;
		[tempArray release];
		
		for (int i=1; i<=4; i++) {
			[directionArray addObject:[NSNumber numberWithInt:i]];
			
		}
		
		
		
		[Utility simpleShuffle:directionArray];
		
		[Utility simpleShuffle:cellsToHit];
		[Utility simpleShuffle:cellsToHit];
		[Utility simpleShuffle:cellsToHit];
		
		
		NSMutableDictionary *temp= [[NSMutableDictionary alloc] init];
		self.cellsTrackerDict=temp;
		[temp release];
		
		for (int i=0; i<[cellsToHit count]; i++) {
			
			NSMutableDictionary *dict=[cellsToHit objectAtIndex:i];
			[cellsTrackerDict setObject:dict forKey:[dict objectForKey:@"number"]];
			
		}
		
	}
	return self;
}


#pragma mark Functios to call when no ship under attack

/*
 
 this will return the index number of the cell to be attcked
 
 
 
 */


-(int)cellToAttack
{
	BOOL foundMore=YES;
	int attackCellNumber=-1;
	if (currentIndex==CONST_CELLS_TOTAL_GRIDS) {
		return -1;
	}
	
	while (foundMore) {
	
		NSMutableDictionary *dict=[cellsToHit objectAtIndex:currentIndex];
		
		if (![[dict objectForKey:@"used"] boolValue]) {
			
			[dict setObject:[NSNumber numberWithBool:YES] forKey:@"used"];
			attackCellNumber = [[dict objectForKey:@"number"] intValue];
			
			foundMore=NO;
			currentIndex+=1;
			
			
		}
		else {
			currentIndex+=1;
		}

				
		
	}
	
	return attackCellNumber;
  
	
}




#pragma mark Functions to call when ship is under attack
//we need to follow the sequence, left right up or down while blast 


-(int)cellToAttackWhileMapUnderDestruction:(NSMutableArray *)blastArray BlastDirections:(NSMutableArray *)blastDirections MasterBlastArray:(NSMutableArray *)masterBlastArray MasterBlastDirection:(NSMutableArray *)masterBlastDirection
{
	if (currentIndex==CONST_CELLS_TOTAL_GRIDS) {
		return -1;
	}
	
	if ([blastArray count] == 1) {
		 
		int cellNumber=  [self getIntelligentNeighborMoveAfterFirstBlast:blastArray andBlastDirection:blastDirections];
		
		while (cellNumber==-1) {
			[blastArray removeAllObjects];
			//NSLog(@"%@",masterBlastArray);
			[masterBlastArray removeObjectAtIndex:0];
			[blastArray addObject:[masterBlastArray objectAtIndex:0]];
			
			cellNumber=  [self getIntelligentNeighborMoveAfterFirstBlast:blastArray andBlastDirection:blastDirections];
		}
		return cellNumber;
		//return [self getIntelligentNeighborMoveAfterFirstBlast:blastArray];
	}
	
	// get the direction for the next blast and guess it from the continuous sequence of previous blasts
	
	int blastDirection=[self blastDirection:blastArray];
	int initialBlastDirection=blastDirection;
	[self addUniqueBlastDirection:blastDirection InArray:blastDirections];

	//[blastDirections addObject:[NSNumber numberWithInt:blastDirection]];
	// add unique blast directions in the array.
	
		
	int cellnumber=-1;
	
	
	int currentcell=[[blastArray objectAtIndex:[blastArray count]-1] intValue];  // get the last cell in array
	
	
	int index = 0 ;
	
	
	while (cellnumber==-1) {
		
		
	// need to ammend that for carrier ship as it takes multiple columns and multiple rows

		cellnumber=[self nextCellAtDirection:blastDirection ForCellNumber:currentcell];
	
		
		index++;
		
		
		if (index==5) {
			index=0;
			NSLog(@"This is after exausting after all neighbors");
			//NSRange range={1,[blastArray count]-1};
			
			int lastIndex=[blastArray count]-1;
			[blastArray removeObjectAtIndex:lastIndex];
			currentcell= [[blastArray objectAtIndex:lastIndex-1] intValue];
			blastDirection=initialBlastDirection;
			cellnumber=[self nextCellAtDirection:blastDirection ForCellNumber:currentcell];
			
			
			NSLog(@"%@",blastArray);
			NSLog(@"---------------------------------------------");
			
			//break;
		}
		NSMutableDictionary *dict =	[cellsTrackerDict objectForKey:[NSNumber numberWithInt:cellnumber]];
		
		
		if([[dict objectForKey:@"used"] boolValue])
		{
			cellnumber=-1;
		}
		
		
		if (cellnumber==-1) { // cell number -1 means cell is already used or out of grid in current direction
			
			if ([blastArray count] > 1) {
				//NSRange range={1,[blastArray count]-1};
				//[blastArray removeObjectsInRange:range];
				
			}
		}
		if (cellnumber==-1 && index==1) {
			
			
			blastDirection=[self reverseBlastDirection:initialBlastDirection];
			
			
		}
		else if(cellnumber== -1 && index==2)
		{
			blastDirection=[self toggleBlastDirection:initialBlastDirection];
			
		}
		else if(cellnumber== -1 && index==3) {
			
			
			blastDirection = [self toggleBlastDirectionReverse:initialBlastDirection];
			
			
		}
		else if(cellnumber== -1 && index==4) {
			
			
			blastDirection = [self reverseBlastDirection:initialBlastDirection];
			
			
		}
		
	
	}
	
	
	
	NSMutableDictionary *dict =	[cellsTrackerDict objectForKey:[NSNumber numberWithInt:cellnumber]];
	
	[dict setObject:[NSNumber numberWithBool:YES] forKey:@"used"];
			
	return cellnumber;
	
	
}

-(void)addUniqueBlastDirection:(int)blastDirection InArray:(NSMutableArray *)blastArray
{
	
	for (int i=0; i<[blastArray count]; i++) {
		
		int alreadyblastDirection=[[blastArray objectAtIndex:i] intValue];
		
		if (alreadyblastDirection==blastDirection) {
			
			return;
		}
				
		
	}
	
	[blastArray addObject:[NSNumber numberWithInt:blastDirection]];
	
}

-(int)toggleBlastDirection:(int)blastDirection
{
	if (blastDirection==CONST_BLAST_DIRECTION_DOWN) {
		
		blastDirection=CONST_BLAST_DIRECTION_RIGHT;
	}
	else if(blastDirection==CONST_BLAST_DIRECTION_UP) {
		
		blastDirection=CONST_BLAST_DIRECTION_LEFT;
	}
	else if(blastDirection==CONST_BLAST_DIRECTION_RIGHT)
	{
		blastDirection=CONST_BLAST_DIRECTION_UP;
	}else if (blastDirection==CONST_BLAST_DIRECTION_LEFT) {
		
		blastDirection=CONST_BLAST_DIRECTION_DOWN;
	}
	
	return blastDirection;
}

-(int)toggleBlastDirectionReverse:(int)blastDirection
{
	if (blastDirection==CONST_BLAST_DIRECTION_DOWN) {
		
		blastDirection=CONST_BLAST_DIRECTION_LEFT;
	}
	else if(blastDirection==CONST_BLAST_DIRECTION_UP) {
		
		blastDirection=CONST_BLAST_DIRECTION_RIGHT;
	}
	else if(blastDirection==CONST_BLAST_DIRECTION_RIGHT)
	{
		blastDirection=CONST_BLAST_DIRECTION_DOWN;
	}else if (blastDirection==CONST_BLAST_DIRECTION_LEFT) {
		
		blastDirection=CONST_BLAST_DIRECTION_UP;
	}
	
	return blastDirection;
}

-(int)reverseBlastDirection:(int)blastDirection
{
	if (blastDirection==CONST_BLAST_DIRECTION_DOWN) {
		
		blastDirection=CONST_BLAST_DIRECTION_UP;
	}
	else if(blastDirection==CONST_BLAST_DIRECTION_UP) {
		
		blastDirection=CONST_BLAST_DIRECTION_DOWN;
	}
	else if(blastDirection==CONST_BLAST_DIRECTION_RIGHT)
	{
		blastDirection=CONST_BLAST_DIRECTION_LEFT;
	}else if (blastDirection==CONST_BLAST_DIRECTION_LEFT) {
		
		blastDirection=CONST_BLAST_DIRECTION_RIGHT;
	}
	
	return blastDirection;
}


-(int)blastDirection:(NSMutableArray *)blastArray
{
		
	if ([[blastArray objectAtIndex:0] intValue] > [[blastArray objectAtIndex:1] intValue]) {
		// it must be left or upward sequence
		   
		if ([[blastArray objectAtIndex:0] intValue] >= ([[blastArray objectAtIndex:1] intValue]+10)) {
			
			return CONST_BLAST_DIRECTION_UP;
			
		}
		else {
			return CONST_BLAST_DIRECTION_LEFT;
		}

		
	}
	
	else {
		//it is righ or upwards sequence
		
		if (([[blastArray objectAtIndex:0] intValue]+10) <= ([[blastArray objectAtIndex:1] intValue])) {
			
			return CONST_BLAST_DIRECTION_DOWN;
			
		}
		else {
			return CONST_BLAST_DIRECTION_RIGHT;
		}
		
	}

	
	return 1;
}




-(int)getIntelligentNeighborMoveAfterFirstBlast:(NSMutableArray *)blastArray andBlastDirection:(NSMutableArray *)blastDirections
{
	NSLog(@"After First blast this function called--------");
	[Utility simpleShuffle:directionArray];
	int currentcell=[[blastArray objectAtIndex:0] intValue];

	if ([blastDirections count]>0) {
		
	
		int toggleDirection=[self reverseBlastDirection:[[blastDirections objectAtIndex:([blastDirections count]-1)] intValue]];
	
		int nextCell=[self nextCellAtDirection:toggleDirection ForCellNumber:currentcell];
		if (nextCell!=-1) {
		NSMutableDictionary *dict =	[cellsTrackerDict objectForKey:[NSNumber numberWithInt:nextCell]];
		
		
		if(![[dict objectForKey:@"used"] boolValue])
		{
			[dict setObject:[NSNumber numberWithBool:YES] forKey:@"used"];
			int intValue=[[dict objectForKey:@"number"] intValue];
			NSLog(@"First Blast returns %d",intValue);
			return 	intValue;
			
		}
			
		
	}
		
	}//if blast directions exists then intelligently toggle
	
	// Now loop through to see which one is available
	int cellnumber=-1;
	
	for (int i=0; i<[directionArray count]; i++) {
		cellnumber=[self nextCellAtDirection:[[directionArray objectAtIndex:i] intValue] ForCellNumber:currentcell];
								   
		
		if (cellnumber==-1) { // means could not go to next cell as it moves out of grid
			
			continue;
			
		}
		
		NSMutableDictionary *dict =	[cellsTrackerDict objectForKey:[NSNumber numberWithInt:cellnumber]];
		

		if([[dict objectForKey:@"used"] boolValue])
		{
			continue;
		}
		else {
		
			[dict setObject:[NSNumber numberWithBool:YES] forKey:@"used"];
			int intValue=[[dict objectForKey:@"number"] intValue];
			NSLog(@"First Blast returns %d",intValue);
			 return 	intValue;
		
		}
		
		
	}
	
	return -1 ; //means that all neighbors are taken, thoretical thread should not reach there since if ship is completely blasted then this function is not calles
}

-(int)nextCellAtDirection:(int)direction ForCellNumber:(int)currentcell
{
	int cellnumber=-1;
	if(direction == CONST_BLAST_DIRECTION_UP )
	{
		cellnumber=[Utility upperCell:currentcell];
		
	}
	else if(direction == CONST_BLAST_DIRECTION_DOWN )
	{
		cellnumber=[Utility downwardCell:currentcell];
	}
	else if(direction == CONST_BLAST_DIRECTION_LEFT )
	{
		cellnumber=[Utility leftCell:currentcell];
		
	}
	else if(direction == CONST_BLAST_DIRECTION_RIGHT )
	{
		cellnumber=[Utility rightCell:currentcell];
	}
	
		
	return cellnumber;
	
}

- (void) dealloc
{
	[cellsToHit removeAllObjects];
	[directionArray removeAllObjects];
	[cellsToHit release];
	[directionArray release];
	[super dealloc];

}


@end
