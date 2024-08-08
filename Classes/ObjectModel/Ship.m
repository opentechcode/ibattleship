//
//  Ship.m
//  iBattleShips
//
//  Created by Ali Zafar on 9/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Ship.h"


@implementation Ship
@synthesize shipSprite,cellsCoverArray,deployedPosition,originalPosition,cellsDictionary,shipCurrentOrientation,xAdjustment,yAdjustment,isDeployed;
@synthesize shipType,shouldbeRemoved,initialXAdjustment,initialYAdjustment,points,shipLifeState;
@synthesize shipText,deployedCellNumber,isdrowningAnimationShown,largerShipSprite;
@synthesize xVerticallAdjustment,yVerticalAdjustment,xHorizontalAdjustment,yHorizontalAdjustment,destructionAnimation;

- (id) init
{
	self = [super init];
	if (self != nil) {
		
		
		NSMutableArray *tempArray= [[NSMutableArray alloc] init];
		
		self.cellsCoverArray=tempArray;
		
		[tempArray release];
		
		shipLifeState=CONST_SHIP_LIFE_ALIVE;
		
	}
	
	
	return self;
}


-(Ship *)initWithShipType:(NSString *)shiptype andOrientation:(NSString *)currentShipOrientation
{
	self=[super init];
	
	if (self != nil) 
	{
		NSString *spriteFullName=@"";
		NSMutableArray *tempArray= [[NSMutableArray alloc] init];
		points=2;
		self.cellsCoverArray=tempArray;
		[tempArray release];
		
		
		
		NSString *path=	[[NSBundle mainBundle] pathForResource:@"Ships" ofType:@"plist"];
		NSDictionary *dict=	[NSDictionary dictionaryWithContentsOfFile:path];
		NSDictionary *tempDict=[[NSDictionary alloc] initWithDictionary:dict];// [dict objectForKey:shipType];
		self.cellsDictionary=tempDict;
		[tempDict release];
		
		if ([currentShipOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_UP] || [currentShipOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_Down]) 
		{
			spriteFullName = [shiptype stringByAppendingString:@"_Vertical"];
			[self setShipCurrentOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP] ;
			
		}
		else if ([currentShipOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_Right] || [currentShipOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_LEFT]) 

		{
			spriteFullName = [shiptype stringByAppendingString:@"_Horizontal"];
			[self setShipCurrentOrientation:CONST_SHIP_ORIENTATION_HORIZONTAL_Right] ;


		}
		
		self.shipText=[NSString stringWithFormat:@"%@_text",shiptype];
		
		self.shipSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_Larger.png",spriteFullName]];
		self.largerShipSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@_Larger.png",spriteFullName]];

		//NSLog(@"The retainCount of Ship Sprite is=%d",[self.shipSprite retainCount]);
		self.shipCurrentOrientation=[NSString stringWithFormat:@"%@",currentShipOrientation];
		self.shipType = [NSString stringWithFormat:@"%@",shiptype];
		
		
		shipLifeState=CONST_SHIP_LIFE_ALIVE;
		
		self.isDeployed = NO;
		self.shouldbeRemoved = YES;
		self.deployedCellNumber=-1;
		self.isdrowningAnimationShown=NO;

	    // to fill the destructionanimation
		[self fillAnimationDictionary];
	}
	
	return self;
}

-(void) fillAnimationDictionary
{
	NSString *spriteFullName = nil;
	
	if (self.destructionAnimation != nil) 
	{
		[self.destructionAnimation release];
		destructionAnimation =nil;
	}
	if ([self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_UP] || [self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_Down]) 
	{
		spriteFullName = [self.shipType stringByAppendingString:@"_Vertical_Destroy"];
			
	}
	else if ([self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_Right] || [self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_LEFT]) 
	
	{
		//spriteFullName = [shiptype stringByAppendingString:@"_Horizontal.png"];
		spriteFullName = [self.shipType stringByAppendingString:@"_Horizontal_Destroy"];
	
	
	}
	self.destructionAnimation = [CCAnimation animationWithName:@"destructionAnimation" delay:0.15];
	for (int i=1;i< 2 ;i++ )
	{
		//NSLog(@"%@",[NSString stringWithFormat:@"%@_%d",spriteFullName,i]);
		[self.destructionAnimation addFrameWithFilename:[NSString stringWithFormat:@"%@_%d.png",spriteFullName,i]];
		
	}
	
	
	
}


-(void)shipSpriteSet
{
	NSString *spriteFullName = nil;
	
	if ([self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_UP] || [shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_Down]) 
	{
		spriteFullName = [self.shipType stringByAppendingString:@"_Vertical.png"];
		[self setShipCurrentOrientation:CONST_SHIP_ORIENTATION_VERTICAL_UP] ;
		xAdjustment=xVerticallAdjustment;
		yAdjustment=yVerticalAdjustment;
		
		if (self.deployedCellNumber%10==0 && [self.shipType isEqualToString:CONST_SHIP_TYPE_AIRCRAFT_CARRIER]) {
			deployedCellNumber=[Utility leftCell:deployedCellNumber];
		}
	}
	else if ([self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_Right] || [shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_LEFT]) 
		
	{
		spriteFullName = [self.shipType stringByAppendingString:@"_Horizontal.png"];
		[self setShipCurrentOrientation:CONST_SHIP_ORIENTATION_HORIZONTAL_Right] ;
		xAdjustment=xHorizontalAdjustment;
		yAdjustment=yHorizontalAdjustment;
		
		if (deployedCellNumber>90 && [self.shipType isEqualToString:CONST_SHIP_TYPE_AIRCRAFT_CARRIER]) {
			deployedCellNumber=[Utility upperCell:deployedCellNumber];
		}
		
	}
	
	[shipSprite release];
	shipSprite = nil;
	
	self.shipSprite = [CCSprite spriteWithFile:spriteFullName];
	[self fillAnimationDictionary];
	
}


-(void)shipSpriteSetForPlayerAutoDeploy
{
	
	
	if ([self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_UP] || [shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_VERTICAL_Down]) 
	{
		xAdjustment=xVerticallAdjustment;
		yAdjustment=yVerticalAdjustment;
		
		if (self.deployedCellNumber%10==0 && [self.shipType isEqualToString:CONST_SHIP_TYPE_AIRCRAFT_CARRIER]) {
			deployedCellNumber=[Utility leftCell:deployedCellNumber];
		}
	}
	else if ([self.shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_Right] || [shipCurrentOrientation isEqualToString:CONST_SHIP_ORIENTATION_HORIZONTAL_LEFT]) 
		
	{
		
		xAdjustment=xHorizontalAdjustment;
		yAdjustment=yHorizontalAdjustment;
		
		if (deployedCellNumber>90 && [self.shipType isEqualToString:CONST_SHIP_TYPE_AIRCRAFT_CARRIER]) {
			deployedCellNumber=[Utility upperCell:deployedCellNumber];
		}
		
	}
	
	
	
	
	//[self fillAnimationDictionary];
	
}

-(void)undeployShip;
{
	for (int i=0 ; i<[cellsCoverArray count] ; i++) {
		
		Cell *cell =	[cellsCoverArray objectAtIndex:i];	
		cell.cellOccupationState=CONST_CELL_OCCUPATION_STATE_EMPTY;
		//[shipSprite runAction:<#(CCAction *)action#>]
		
	}
	
	[cellsCoverArray removeAllObjects];
	
	
	
}

-(void)getShipDeploymentDetails
{
	NSLog(@"Start Ship deployment details---------");
	NSLog(@"Ship Name:%@",self.shipType);
	if (!self.isDeployed) {
		return;
	}
	NSString *str=[NSString stringWithFormat:@""];
	for (int i=0; i<[cellsCoverArray count]; i++) {
		
		str=[str stringByAppendingFormat:@"%d,",[(Cell*)[cellsCoverArray objectAtIndex:i] cellNumber]];
		
	}
	NSLog(@"Cell:%@",str);
	NSLog(@"End Ship deployment details---------");

}




-(NSDictionary *)getOccupiedCellsDirections
{
    return  (NSDictionary *)[[cellsDictionary objectForKey:self.shipType] objectForKey:self.shipCurrentOrientation];
	
}

-(BOOL)isShipDestroyed
{
	if (shipLifeState==CONST_SHIP_LIFE_DEAD ) {
		return YES;
	}
	if ([cellsCoverArray count]==0) {
		return NO;
	}
	
	for (int i=0; i<[cellsCoverArray count]; i++) {
		
		Cell *cell=[cellsCoverArray objectAtIndex:i];
		
		if(cell.cellHitState!=CONST_CELL_HIT_STATUS_BLAST)
		{
			return NO;
		}
		
	}
	
	shipLifeState=CONST_SHIP_LIFE_DEAD;
	
	[GameManager sharedGameManager].gameProcessor.destroyingshiptext=self.shipText;
	
	[iBattleShipsSound playShipDrowningSoundEffect];
	return YES;
	
}

-(BOOL)isPartiallyDemaged
{
	if (shipLifeState==CONST_SHIP_LIFE_DEAD ) {
		return NO;
	}
	if ([cellsCoverArray count]==0) {
		return NO;
	}
	int cellBlast=0;
	for (int i=0; i<[cellsCoverArray count]; i++) {
		
		Cell *cell=[cellsCoverArray objectAtIndex:i];
		
		if(cell.cellHitState!=CONST_CELL_HIT_STATUS_BLAST)
		{
			cellBlast++;
		}
		
	}
	
	if (cellBlast>0 && cellBlast<[cellsCoverArray count]) {
		return YES;
	}
	return NO;
}
-(BOOL)amITouchedatPoint:(CGPoint)point
{
	//	float artScale=CONST_IMAGES_ART_SCALE;
	CGRect rect=CGRectMake( self.shipSprite.position.x-(self.shipSprite.textureRect.size.width/2), self.shipSprite.position.y-(self.shipSprite.textureRect.size.height/2), self.shipSprite.textureRect.size.width, self.shipSprite.textureRect.size.height);
	
	if (CGRectContainsPoint(rect, point)) 
	{
		
		return YES;
		
		
	}
	
	return NO;
	
	
	
	
}


-(void)runMyDrowningAnimation
{
	id seq = [CCAnimate actionWithAnimation:self.destructionAnimation restoreOriginalFrame:NO];
	[self.largerShipSprite runAction:seq];
	
}

- (void) dealloc
{
	
	//NSLog(@"Ship is Deallocing and Retain count = %d",[shipSprite retainCount]);
	[[CCTextureCache sharedTextureCache] removeAllTextures];
	//NSLog(@"Ship is Deallocing and Retain count = %d",[shipSprite retainCount]);
    [destructionAnimation release];
	[largerShipSprite release];
    [cellsCoverArray release];
	[cellsDictionary release];
	[shipSprite release];
	[super dealloc];
}


@end
