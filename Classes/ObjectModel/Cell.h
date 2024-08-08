//
//  Cell.h
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface Cell : NSObject {

	int cellOccupationState;
	int cellHitState;
	int cellNumber;
	float poxX;
	float posY;
}

@property (readwrite)int cellOccupationState;
@property (readwrite)int cellHitState;
@property (readwrite)int cellNumber;

@property (readwrite) float posX;
@property (readwrite) float posY;


- (id) initWithcellNumber:(int)cellIndex;

@end
