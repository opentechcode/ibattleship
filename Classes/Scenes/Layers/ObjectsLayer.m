//
//  ObjectsLayer.m
//  iBattleShips
//
//  Created by Sajjad Raza on 10/6/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "ObjectsLayer.h"
#import "iBattleShipsSound.h"

@implementation ObjectsLayer
@synthesize map,selectedShip,isSelectedShipDragged,pointerAnimation,compWaterSplash,pointer,compBlast,playerBlast,playerWaterSplash;
@synthesize playerBlastAnimation,playerWaterSplashAnimation,isPointerAdded,isBlastAdded,isWaterSplashAdded,selectedLocation, compBlastAnimation,compWaterSplashAnimation;
@synthesize largerMap;
-(id) init
{
	self = [super init];
	if (self != nil) 
	{
		self.map  = [CCSprite spriteWithFile:@"map.png"];
		self.largerMap  = [CCSprite spriteWithFile:@"map_larger.png"];
		
		//Please do not change this location as thios will disturb all the points stoed in the plist
		[self.map setPosition:CGPointMake([[CCDirector sharedDirector] winSize].width/2 , [[CCDirector sharedDirector] winSize].height/2  +ADDEDY) ];
		[self.largerMap setPosition:CGPointMake([[CCDirector sharedDirector] winSize].width/2 , [[CCDirector sharedDirector] winSize].height/2  +ADDEDY + 45) ];

		[self addChild:self.map];
		self.isTouchEnabled = YES;
		[self deployPlayerShips];
		self.selectedShip = 0;
		self.isSelectedShipDragged = NO;
		
		

		
		self.pointer  = [CCSprite spriteWithFile:@"pointer1.png"];
		self.compBlast  = [CCSprite spriteWithFile:@"blast1.png"];
        self.compWaterSplash = [CCSprite spriteWithFile:@"Splash1.png"];
		
		self.playerBlast  = [CCSprite spriteWithFile:@"blast1.png"];
        self.playerWaterSplash = [CCSprite spriteWithFile:@"Splash1.png"];

		
		self.pointerAnimation =[CCAnimation animationWithName:@"pointerAnimation" delay:0.25];
		for ( int i=1; i<3; i++) 
		{
			[self.pointerAnimation addFrameWithFilename:[NSString stringWithFormat:@"pointer%d.png",i]];
			//[self.blastAnimation addFrameWithFilename:[NSString stringWithFormat:@"blast%d.png",i]];

		}
		
		
		self.playerBlastAnimation =[CCAnimation animationWithName:@"blastAnimation" delay:0.01];
		self.compBlastAnimation =[CCAnimation animationWithName:@"blastAnimation" delay:0.01];
		for ( int i=1; i<69; i++) 
		{
			[self.playerBlastAnimation addFrameWithFilename:[NSString stringWithFormat:@"blast%d.png",i]];
			[self.compBlastAnimation addFrameWithFilename:[NSString stringWithFormat:@"blast%d.png",i]];

		}
		
		
		self.playerWaterSplashAnimation =[CCAnimation animationWithName:@"waterSplashAnimation" delay:0.01];
		self.compWaterSplashAnimation =[CCAnimation animationWithName:@"waterSplashAnimation" delay:0.01];

		for ( int i=1; i<69; i++) 
		{
			[self.playerWaterSplashAnimation addFrameWithFilename:[NSString stringWithFormat:@"Splash%d.png",i]];
			[self.compWaterSplashAnimation addFrameWithFilename:[NSString stringWithFormat:@"Splash%d.png",i]];

		}
		
		self.isPointerAdded = NO;	
		///float x = point.x;float y= point.y;
		
			/*for (int j = 0; j < 100 ; j++) 
			{
				CCSprite *dotSprite  = [CCSprite spriteWithFile:@"dot.png"];
				Cell  *cell = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerMap.cells objectAtIndex:j];
				[dotSprite setPosition:CGPointMake(cell.posX,cell.posY)];
				//[self addChild:dotSprite z:5];
			}*/
			
	}
	return self;
}


-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

-(void) deployPlayerShips
{
    int count = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips count];
	float x,y;
	x = 800.0;
	y = 65.0;
	for (int i=0; i< count; i++)
	{
		Ship *playerShip = (Ship*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:i];
		[self getShipPosition:i];
		playerShip.originalPosition = [self getShipPosition:i];
		[playerShip.shipSprite setPosition:playerShip.originalPosition];
	   // NSLog(@"The Retain Count of the Ship SP before adding into Layer =%d",[playerShip.shipSprite retainCount]);  
		[self addChild:playerShip.shipSprite z:2];
		//NSLog(@"The Retain Count of the Ship SP after adding into Layer =%d",[playerShip.shipSprite retainCount]);  
		
		
	}
	
}

-(CGPoint) getShipPosition:(int) shipOrder
{
	CGPoint shipPosition = CGPointMake(0.0,0.0);
	switch (shipOrder) 
	{
		case 0:
			shipPosition = CGPointMake(176.0, 358.0);//GunShip Boat
			break;
		case 1:
			shipPosition = CGPointMake(201.0, 538.0); //AirCraft Vertical  X=201.000000 & Y=538.000000

			break;
		case 2:
			shipPosition = CGPointMake(120.0, 334.0); // Carrier

			break;
		case 3:
			shipPosition = CGPointMake(125.0, 538.0); // Destroyer
			break;
		case 4:
			shipPosition = CGPointMake(228.0, 358.0);  //SubMarine

			break;
		case 5:
			shipPosition = CGPointMake(850.0, 356.0);   
			break;
		case 6:
			shipPosition = CGPointMake(876.0, 588.0);
			break;
		case 7:
			shipPosition = CGPointMake(876.0, 512);
			
			break;
		case 8:
			shipPosition = CGPointMake(876.0, 460);
			break;
		case 9:
			shipPosition = CGPointMake(850.0, 408);
			break;
			
				default:
			break;
	}
	return shipPosition;
	
}
/*
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	self.selectedShip ++;
	NSLog(@"The Touches Began Method NSSet Method The count of Array =%d",[touches count]);
	UITouch *touch =(UITouch*) [touches anyObject];
	CGPoint point = [touch locationInView: [touch view]];
	point =[[CCDirector sharedDirector] convertToGL:point];
	if (self.selectedShip > 1)
	{
		// Here we are getting the second touch in the layer
		if ([GameManager sharedGameManager].selectedShipIndex !=-1) 
		{
			Ship *playerShip = (Ship*)[[GameManager sharedGameManager].gameProcessor.playerShips objectAtIndex:[GameManager sharedGameManager].selectedShipIndex ];
			CGPoint firstPoint = CGPointMake(playerShip.shipSprite.position.x, playerShip.shipSprite.position.y);
			float theta = [Utility calculateAngleBetweenPoints:firstPoint SecondTouch:point];
			NSLog(@"the returned Value is =%f",theta);
			
			id rotate = [CCRotateBy actionWithDuration:0.5 angle:90.0];
			[playerShip.shipSprite runAction:rotate];
			return;
		}
		
	}
    float  minDistance = 10000000000.0;
	int count = [[GameManager sharedGameManager].gameProcessor.playerShips count];
	
	for (int i=0; i< count; i++)
	{
		Ship *playerShip = (Ship*)[[GameManager sharedGameManager].gameProcessor.playerShips objectAtIndex:i];
		// CGPoint shipPosition = CGPointMake(playerShip.shipSprite.position.x, playerShip.shipSprite.position.x);  
		if ([playerShip amITouchedatPoint:point]) 
		{
			
			//NSLog(@"The Ship touched is %@",playerShip.shipType);
			CCSprite *dotSprite  = [CCSprite spriteWithFile:@"dot.png"];
			[dotSprite setPosition:CGPointMake(playerShip.shipSprite.position.x,playerShip.shipSprite.position.y)];
			[self addChild:dotSprite z:5];
			
			//NSLog(@"MY centre point is X=%f,Y=%f and TouchLocation is X=%f,Y=%f",playerShip.shipSprite.position.x,playerShip.shipSprite.position.y,point.x,point.y);
			
			float pointDistance = [Utility  getDistanceCentrePointandTouch:CGPointMake(playerShip.shipSprite.position.x, playerShip.shipSprite.position.y) TouchLocation:point];
			
		//	NSLog(@"The Ship touched is %@ And Dist from Touch is%f",playerShip.shipType,pointDistance);
			
			if (minDistance > pointDistance) 
			{
				minDistance = pointDistance;
				[GameManager sharedGameManager].selectedShipIndex = i;
			}
		}
		if (i==4) 
		{
			break;
		}
		
		
	}
    if ([GameManager sharedGameManager].selectedShipIndex != -1) 
	{
		Ship *selectedShip	=  (Ship*)[[GameManager sharedGameManager].gameProcessor.playerShips objectAtIndex:[GameManager sharedGameManager].selectedShipIndex];
		
		//NSLog(@"The Ship Selected is %@",selectedShip.shipType);
		
	}
	
	
	
}
*/
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (![GameManager sharedGameManager].gameProcessor.isGameStarted && ([GameManager sharedGameManager].gameProcessor.turnInProgress == CONST_TURN_PLAYER)) 
	{
	
		self.selectedShip ++;
		//NSLog(@"The Touches Began Method NSSet Method The count of Array =%d",[touches count]);
		//UITouch *touch =(UITouch*) [touches anyObject];
		CGPoint point = [touch locationInView: [touch view]];
		point =[[CCDirector sharedDirector] convertToGL:point];
		NSLog(@"X=%f,Y=%f",point.x,point.y);

		
		[self setSelectedShipIndex:point];
		self.isSelectedShipDragged = NO;

	
	}
	return YES;
}

-(void) setSelectedShipIndex:(CGPoint)point 
{
	
		int count = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips count];
		float  minDistance = 10000000000.0;
		
		for (int i=0; i< count; i++)
		{
			Ship *playerShip = (Ship*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:i];
			// CGPoint shipPosition = CGPointMake(playerShip.shipSprite.position.x, playerShip.shipSprite.position.x);  
			if ([playerShip amITouchedatPoint:point]) 
			{
			
				//NSLog(@"The Ship touched is %@",playerShip.shipType);
				CCSprite *dotSprite  = [CCSprite spriteWithFile:@"dot.png"];
				[dotSprite setPosition:CGPointMake(playerShip.shipSprite.position.x,playerShip.shipSprite.position.y)];
				//[self addChild:dotSprite z:5];
			
				//NSLog(@"MY centre point is X=%f,Y=%f and TouchLocation is X=%f,Y=%f",playerShip.shipSprite.position.x,playerShip.shipSprite.position.y,point.x,point.y);
			
				float pointDistance = [Utility  getDistanceCentrePointandTouch:CGPointMake(playerShip.shipSprite.position.x, playerShip.shipSprite.position.y) TouchLocation:point];
			
				//	NSLog(@"The Ship touched is %@ And Dist from Touch is%f",playerShip.shipType,pointDistance);
			
				if (minDistance > pointDistance) 
				{
					minDistance = pointDistance;
					[GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex = i;
				}	
			}
		
		
		
		}
	  //  if (self.isSelectedShipDragged) 
		//{
		//}
		
	
}

-(int ) getShipIndexToBeOperated:(int)selectedShipIndex
{
	int shipIndex ;
	if (selectedShipIndex != -1 ) 
	{
		
		
		if (selectedShipIndex + 5 > 9 )
		{
			shipIndex = selectedShipIndex - 5;
		}
		else 
		{
			shipIndex = selectedShipIndex + 5;
		}
	}
	else {
		shipIndex = -1;
	}
	return shipIndex;
		
}

-(void ) removeCorrespondingShipFromLayer :(int) selectedShipIndex
{
	int shipIndexToRemove = [self getShipIndexToBeOperated:selectedShipIndex];
	if (shipIndexToRemove != -1)
	{
		
		Ship *playerShip = (Ship*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:shipIndexToRemove];
		
		[self removeChild:playerShip.shipSprite cleanup:YES];
		[playerShip.shipSprite setPosition:CGPointMake(-100.0, -100.0)];
		
	}
}


-(void)resetDeployment
{
	NSMutableArray *ships=[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips;
	for (int i=0; i<[ships count];i++) {
		Ship *ship=[ships objectAtIndex:i];
		
		if (ship.isDeployed) {
			
			
			int shipIndexToAdd = [self getShipIndexToBeOperated:i];
			
			[ship.shipSprite setPosition:CGPointMake(ship.originalPosition.x, ship.originalPosition.y)];
			//[self addChild:playerShip.shipSprite z:2];
			
			[ship setShouldbeRemoved:YES];
			ship.isDeployed=NO;
			
			[ship undeployShip];
			if (shipIndexToAdd != -1 ) 
			{	
				
				
				Ship *playerShip = (Ship*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:shipIndexToAdd];
				[playerShip.shipSprite setPosition:CGPointMake(playerShip.originalPosition.x, playerShip.originalPosition.y)];
				[self addChild:playerShip.shipSprite z:2];
				[playerShip setShouldbeRemoved:YES];
				
				[playerShip undeployShip];
			
			}
		}
	
	}
	
}

-(void) putBackShipToMapIfRequired
{
    int selectedShipIndex = [GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex;
	
	int shipIndexToAdd = [self getShipIndexToBeOperated:selectedShipIndex];
	
	if (shipIndexToAdd != -1 ) 
	{	
		
		
		Ship *playerShip = (Ship*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:shipIndexToAdd];
		[playerShip.shipSprite setPosition:CGPointMake(playerShip.originalPosition.x, playerShip.originalPosition.y)];
		[self addChild:playerShip.shipSprite z:2];
		[playerShip setShouldbeRemoved:YES];
		
		
	}
	
}



//- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (![GameManager sharedGameManager].gameProcessor.isGamePaused)
	{
		
	
	if (![GameManager sharedGameManager].gameProcessor.isGameStarted && ([GameManager sharedGameManager].gameProcessor.turnInProgress == CONST_TURN_PLAYER) && [GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex != -1) 
	{
		//get the selectedShipIndex move the selected Ship from orignal location to 
		//current or deployed location
		
		//NSLog(@"The Touches MOVED Method NSSet Method The count of Array =%d",[touches count]);
		
		//UITouch *touch =(UITouch*) [touches anyObject];
		CGPoint point = [touch locationInView: [touch view]];
		//CGPoint point = [touch locationInView: [touch view]];
		point =[[CCDirector sharedDirector] convertToGL:point];
		if ([GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex != -1) 
		{
			Ship *selectedShips	=  (Ship*)[[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:[GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex];
			[selectedShips.shipSprite setPosition:CGPointMake(point.x+selectedShips.initialXAdjustment,point.y+selectedShips.initialYAdjustment)];
			self.isSelectedShipDragged = YES;
			[self removeCorrespondingShipFromLayer: [GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex];
			//NSLog(@"The Ship touched is %@",selectedShips.shipType);
		
		}
	
	}
	}
}
//- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (![GameManager sharedGameManager].gameProcessor.isGamePaused)
	{
		
	CGPoint point = [touch locationInView: [touch view]];
	point =[[CCDirector sharedDirector] convertToGL:point];
	NSLog(@"The Touches Ended Method X=%f & Y=%f",point.x,point.y);
	//CCSprite *dotSprite  = [CCSprite spriteWithFile:@"dot.png"];
	//[dotSprite setPosition:CGPointMake(point.x,point.y)];
	//[self addChild:dotSprite z:5];
	
	
	
	if ( ([GameManager sharedGameManager].gameProcessor.isGameStarted) && ([GameManager sharedGameManager].gameProcessor.isPlayerTurnOn))
	{
		//Now if the player turn is On and game has been started Now touch should be translated in Enemy Map;
		//So we will get cell No from Enemy Map.
		
		int cellNo = [[GameManager sharedGameManager].gameProcessor.computerPlayer.playerMap getCellNumberByLocation:point];
		if (cellNo > - 1 ) 
		{
			
			
			Cell *cell = (Cell*)[[GameManager sharedGameManager].gameProcessor.computerPlayer.playerMap.cells objectAtIndex:cellNo-1];
			if (cell.cellHitState == CONST_CELL_HIT_STATUS_EMPTY  ) 
			{
			//	NSLog(@"The Cell Nop. is  = %d",cellNo);
				[[GameManager sharedGameManager].gameProcessor setSelectedCellNoByPlayer:cellNo];
				[self runPointerAnimationAtLocation:CGPointMake(cell.posX, cell.posY)];
				//[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn = NO;
				//[self performSelector:@selector(firButtonPressed:) withObject:nil afterDelay:1.0];
				//[NSThread sleepForTimeInterval:1.0];
				[self playerAttack:nil];
				
			}
		}
		
	}
	
	if (![GameManager sharedGameManager].gameProcessor.isGameStarted) 
	{
		self.selectedShip = 0;
		//NSLog(@"The Touches ENDEDMethod NSSet Method The count of Array =%d",[touches count]);
		
		//UITouch *touchfound = [touch anyObject];
		//UITouch *touch =(UITouch*) [touches anyObject];
		
		// Here i am checking that if the click on the screen is on grid then the returned value will be greator than -1 
		//else this will be -1
		Ship *selectedShips= nil;
		if ([GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex !=-1 ) 
		{
			selectedShips = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:[GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex];

		}
		int cellNo = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerMap getCellNumberByLocation:point];
		
		
		
		if (cellNo > -1 && [GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex !=-1) 
		{
			// if cell is selected
			
			 
			if ([selectedShips.shipType isEqualToString:CONST_SHIP_TYPE_AIRCRAFT_CARRIER]) 
			{
				
			
				if (cellNo % 10 == 0) 
				{
					cellNo = [Utility leftCell:cellNo];
				
				}
				if (cellNo > 90) 
				{
					cellNo = [Utility upperCell:cellNo];
				}
			}
			
			Cell *cell = (Cell*) [[GameManager sharedGameManager].gameProcessor.userPlayer.playerMap.cells objectAtIndex:cellNo-1];
						
			// check if ship was selected
			if ([GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex !=-1 && isSelectedShipDragged)
			{
				// Ok if The Ship has been selected and droped at the grid
				Ship *ship = [[GameManager sharedGameManager].gameProcessor.userPlayer.playerShips objectAtIndex:[GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex];
				if ([[GameManager sharedGameManager].gameProcessor.userPlayer.playerMap deployShip:ship atLocation:point]) 
				{
					[ship.shipSprite setPosition:CGPointMake(cell.posX+ship.xAdjustment,cell.posY+ship.yAdjustment)];
					ship.isDeployed =YES;
					//[ship setDeployedPosition:CGPointMake(cell.posX+ship.xAdjustment,cell.posY+ship.yAdjustment)];
					[ship setDeployedPosition:CGPointMake(cell.posX+ship.xAdjustment,cell.posY+ship.yAdjustment)];
					
					[ship setShouldbeRemoved:NO];
					
					
				    ////[ship runMyDrowningAnimation]; 
					//NSLog(@"THe Deploayed Position X=%f  Y=%f",ship.deployedPosition.x,ship.deployedPosition.y);
	 
				}
				else
				{
					if (!ship.isDeployed)
					{
						[ship.shipSprite setPosition:CGPointMake(ship.originalPosition.x,ship.originalPosition.y)];
						[self putBackShipToMapIfRequired];

					}
					else
					{
						//NSLog(@"THe Deploayed Position X=%f  Y=%f",ship.deployedPosition.x,ship.deployedPosition.y);

						float x = ship.deployedPosition.x;
						float y = ship.deployedPosition.y; 
						[ship.shipSprite setPosition:CGPointMake(x,y)];
					}
	 
				}

			}
		}
		else if([GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex !=-1  && self.isSelectedShipDragged)
		{
			if (!selectedShips.isDeployed )
			{
				[selectedShips.shipSprite setPosition:CGPointMake(selectedShips.originalPosition.x,selectedShips.originalPosition.y)];
				[self putBackShipToMapIfRequired];
			}
			else
			{
				//NSLog(@"THe Deploayed Position X=%f  Y=%f",selectedShips.deployedPosition.x,selectedShips.deployedPosition.y);
			    
				//if The selected ship id deployed ship is dragged back to orignal area
				if (  CGRectContainsPoint(CGRectMake(93.0, 228.0, 160.0, 400.0),CGPointMake(selectedShips.shipSprite.position.x,selectedShips.shipSprite.position.y))
					||CGRectContainsPoint(CGRectMake(777.0, 325.0,  232.0, 337.0),CGPointMake(selectedShips.shipSprite.position.x,selectedShips.shipSprite.position.y)) )
				{
					[selectedShips.shipSprite setPosition:CGPointMake(selectedShips.originalPosition.x,selectedShips.originalPosition.y)];
					[selectedShips setIsDeployed:NO];
					[selectedShips setShouldbeRemoved:YES];
					[selectedShips undeployShip];
					[self putBackShipToMapIfRequired];


				}
				
				else 
				{
					float x = selectedShips.deployedPosition.x;
					float y = selectedShips.deployedPosition.y; 
					[selectedShips.shipSprite setPosition:CGPointMake(x,y)];
				}

				
			}
		
		}
	//check if the ship is not placed properly then either put it to the original
	//position or proper at the map;
	
	
	//before leaving the method in the end put -1 in selectedShp Index
	[GameManager sharedGameManager].gameProcessor.userPlayer.selectedShipIndex = -1;
	
	  
    }
 }
	else 
	{
		UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Paused" message:@"The game is paused first resume it" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		
		[alerView show];
		[alerView release];
		
	}

}


-(void) runPointerAnimationAtLocation :(CGPoint) location
{
	if (!self.isPointerAdded) 
	{
		[self.pointer setPosition:CGPointMake(location.x,location.y+15)];
		[self addChild:self.pointer z:5];
		id action = [ CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.pointerAnimation restoreOriginalFrame:NO]];
		[self.pointer runAction:action ];
		self.isPointerAdded =YES;
 	}
	else 
	{
		[self.pointer stopAllActions];
		[self.pointer setPosition:CGPointMake(location.x,location.y+15)];
		id action = [ CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.pointerAnimation restoreOriginalFrame:NO]];
		[self.pointer runAction:action ];

		
	}

	
}

-(void) runPlayerBlastAnimationAtLocation :(CGPoint) location
{
	self.selectedLocation = CGPointMake(location.x, location.y);		
	    [self.playerBlast setPosition:CGPointMake(location.x,location.y)];
		[self addChild:self.playerBlast z:5];
		id seq = [CCSequence actions:
				  [CCAnimate actionWithAnimation:self.playerBlastAnimation restoreOriginalFrame:NO],
			      [CCCallFunc actionWithTarget:self selector:@selector(blastCallBack)],
				nil];
	
		[self.playerBlast runAction:seq];
	[iBattleShipsSound playBlastSoundEffect];
}


//- (void) callback:(id)sender data:(id)dict
- (void) blastCallBack
{
		CCSprite *sq = [CCSprite spriteWithFile:@"sqaure_orange.png"];
	    [sq setPosition:CGPointMake(self.selectedLocation.x+2,self.selectedLocation.y -2)];
		[self addChild:sq];
		[self removeChild:self.playerBlast cleanup:YES];
		
	
	
	
	
}
-(void) runPlayerWaterSplashAnimationAtLocation :(CGPoint) location
{
	self.selectedLocation = CGPointMake(location.x, location.y);		
	[self.playerWaterSplash setPosition:CGPointMake(location.x,location.y)];
	[self addChild:self.playerWaterSplash z:5];
	id seq = [CCSequence actions:
			  [CCAnimate actionWithAnimation:self.playerWaterSplashAnimation restoreOriginalFrame:NO],
			  [CCCallFunc actionWithTarget:self selector:@selector(waterSplashCallBack)],
			  nil];
	
	[self.playerWaterSplash  runAction:seq];
	[iBattleShipsSound playWaterSplashSoundEffect];
}

-(void) waterSplashCallBack
{
	CCSprite *sq = [CCSprite spriteWithFile:@"sqaure_blue.png"];
	[sq setPosition:CGPointMake(self.selectedLocation.x+2,self.selectedLocation.y-2)];
	[self addChild:sq];
	[self removeChild:self.playerWaterSplash cleanup:YES];
}


-(void) runCompBlastAnimationAtLocation :(CGPoint) location
{
	self.selectedLocation = CGPointMake(location.x, location.y);		
	[self.compBlast setPosition:CGPointMake(location.x,location.y)];
	[self addChild:self.compBlast z:5];
	id seq = [CCSequence actions:
			  [CCAnimate actionWithAnimation:self.playerBlastAnimation restoreOriginalFrame:NO],
			  [CCCallFunc actionWithTarget:self selector:@selector(compBlastCallBack)],
			  nil];
	
	[self.compBlast runAction:seq];
	[iBattleShipsSound playBlastSoundEffect];
}


//- (void) callback:(id)sender data:(id)dict
- (void) compBlastCallBack
{
	CCSprite *sq = [CCSprite spriteWithFile:@"sqaure_orange.png"];
	[sq setPosition:CGPointMake(self.selectedLocation.x,self.selectedLocation.y)];
	[self addChild:sq];
	[self removeChild:self.compBlast cleanup:YES];
	
	
	
	
	
}
-(void) runCompWaterSplashAnimationAtLocation :(CGPoint) location
{
	self.selectedLocation = CGPointMake(location.x, location.y);		
	[self.compWaterSplash setPosition:CGPointMake(location.x,location.y)];
	[self addChild:self.compWaterSplash z:5];
	id seq = [CCSequence actions:
			  [CCAnimate actionWithAnimation:self.playerWaterSplashAnimation restoreOriginalFrame:NO],
			  [CCCallFunc actionWithTarget:self selector:@selector(compWaterSplashCallBack)],
			  nil];
	
	[self.compWaterSplash  runAction:seq];
	[iBattleShipsSound playWaterSplashSoundEffect];
}

-(void) compWaterSplashCallBack
{
	CCSprite *sq = [CCSprite spriteWithFile:@"sqaure_blue.png"];
	[sq setPosition:CGPointMake(self.selectedLocation.x,self.selectedLocation.y)];
	[self addChild:sq];
	[self removeChild:self.compWaterSplash cleanup:YES];
}


#pragma mark Gadget Layer Functios
-(void)playerAttack:(id)sender
{
	//[GameManager sharedGameManager].gameProcessor.computerPlayer.health=0;
	
	
	if ([GameManager sharedGameManager].gameProcessor.selectedCellNoByPlayer==-1 || (![GameManager sharedGameManager].gameProcessor.isPlayerTurnOn) ) {
		return;
	}
	
	[iBattleShipsSound playMissilLaunch2];
	[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn=NO;
	[GameManager sharedGameManager].gameProcessor.turnInProgress=CONST_TURN_PLAYER;
	[GameManager sharedGameManager].gameProcessor.userPlayer.shots+=1;
    [self performSelector:@selector(firButtonPressed:) withObject:nil afterDelay:1.0];
	
	if ([GameManager sharedGameManager].gameProcessor.game_type==CONST_GAME_TYPE_MULTI_PLAYER ) {
		
		
		int selected_cell_number=[GameManager sharedGameManager].gameProcessor.selectedCellNoByPlayer;
		[[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager sendCellHitMessage:selected_cell_number];
	}
	
}
-(void)firButtonPressed:(id)sender
{
		
	Player *player=[GameManager sharedGameManager].gameProcessor.computerPlayer;
	[player hitAtCellNumber:[GameManager sharedGameManager].gameProcessor.selectedCellNoByPlayer];
	
	[GameManager sharedGameManager].gameProcessor.selectedCellNoByPlayer=-1;
	
	if ([[GameManager sharedGameManager].gameProcessor isGameOver]) {
		[self performSelector:@selector(endGame:) withObject:self afterDelay:1.0];
		return;
	}
	
	
	if([GameManager sharedGameManager].gameProcessor.game_type==CONST_GAME_TYPE_SINGLE_PLAYER )
	{
		[self performSelector:@selector(computerAttackStart:) withObject:self afterDelay:1.0];
	}
	else {
		//[[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager displayAlertMessageIfGameNotFinish:nil];
	}

	//autoDeployBtn.visible=NO;
	
}

-(void)endGame:(id)sender
{
	[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
}
-(void)computerAttackStart:(id)sender
{
	[iBattleShipsSound playMissilLaunch2];
	[self performSelector:@selector(computerAttack:) withObject:self afterDelay:1.0];
}

-(void)computerAttack:(id)sender
{
	if ([[GameManager sharedGameManager].gameProcessor isGameOver]) {
		[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
		return;
	}
	
	Player *player =[GameManager sharedGameManager].gameProcessor.userPlayer;
	[GameManager sharedGameManager].gameProcessor.turnInProgress=CONST_TURN_ENEMY;
	[GameManager sharedGameManager].gameProcessor.computerPlayer.shots+=1;
	[player autoHitAtCellInMap];
	//[self performSelector:@selector(computerAttack:) withObject:nil afterDelay:2.0];
	[self performSelector:@selector(turnPlayerOn:) withObject:self afterDelay:0.85];
	//[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn=YES;
	
}

-(void)remoteAttackStart:(id)sender
{
	
	if ([[GameManager sharedGameManager].gameProcessor isGameOver]) {
		[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
		return;
	}
	[iBattleShipsSound playMissilLaunch2];
	//show the player map when enemy is going to fire
	
	//[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate showPlayerMap];
	[self performSelector:@selector(remoteAttack:) withObject:sender afterDelay:1.0];
}

-(void)remoteAttack:(id)sender
{
	
	if ([[GameManager sharedGameManager].gameProcessor isGameOver]) {
		[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
		return;
	}
	
	Player *player =[GameManager sharedGameManager].gameProcessor.userPlayer;
	[GameManager sharedGameManager].gameProcessor.turnInProgress=CONST_TURN_ENEMY;
	[GameManager sharedGameManager].gameProcessor.computerPlayer.shots+=1;
	 NSNumber *cellNumber=sender;
	[player remoteHitAtCellNumber:[cellNumber intValue]];
	
	//[player autoHitAtCellInMap];
	//[self performSelector:@selector(computerAttack:) withObject:nil afterDelay:2.0];
	
	
	[self performSelector:@selector(turnPlayerOn:) withObject:self afterDelay:1.5];
	
	
	//[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn=YES;

	
}


-(void)turnPlayerOn:(id)sender
{
	
	[GameManager sharedGameManager].gameProcessor.isPlayerTurnOn=YES;
	//autoDeployBtn.visible=YES;
	
	if ([[GameManager sharedGameManager].gameProcessor isGameOver]) {
		[[GameManager sharedGameManager].gameProcessor.userPlayer.delegate gameOver];
		return;
	}
	
	
	
}






- (void) dealloc
{
	//NSLog(@"The Object Layer Dealloc Scene");
    [self removeAllChildrenWithCleanup:YES]; 
	[pointerAnimation release];
	[playerBlastAnimation release];
	[playerWaterSplashAnimation release];
	[compBlastAnimation release];
	[compWaterSplashAnimation release];
    [largerMap release]; 
	[map release];
	[pointer release];
	[playerBlast release];
	[playerWaterSplash release];
	
	[super dealloc];
}

@end
