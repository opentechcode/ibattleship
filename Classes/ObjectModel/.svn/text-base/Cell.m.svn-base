//
//  Cell.m
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"


@implementation Cell
@synthesize cellOccupationState, cellHitState,cellNumber,posX,posY;
- (id) init
{
	self = [super init];
	if (self != nil) {
		
		cellOccupationState=CONST_CELL_OCCUPATION_STATE_EMPTY;
		cellHitState=CONST_CELL_HIT_STATUS_EMPTY;
		
	}
	return self;
}


- (id) initWithcellNumber:(int)cellIndex
{
	self = [super init];
	if (self != nil) {
		
		cellOccupationState=CONST_CELL_OCCUPATION_STATE_EMPTY;
		cellHitState=CONST_CELL_HIT_STATUS_EMPTY;
		self.cellNumber=cellIndex;
	}
	return self;
}

 

@end
