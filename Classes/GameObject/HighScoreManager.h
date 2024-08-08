//
//  HighScoreManager.h
//  iBattleShips
//
//  Created by Ali Zafar on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScoreManager : NSObject {

	
	NSMutableArray *localScores;
	NSMutableArray *globalScores;
	
}


@property (nonatomic, retain)NSMutableArray *localArray;
@property (nonatomic,retain)NSMutableArray *globalArray;

-(void)saveLocalScores;
-(void)loadLocalScores;
int myCompareFunction( id obj1, id obj2, void *context );
@end
