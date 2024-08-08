//
//  HighScoreLocalLayer.h
//  iBattleShips
//
//  Created by Ali Zafar on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScoreLocalLayer : CCLayer {

	CCSprite *highscores;
}

-(void)populateLayer;

@property (nonatomic, retain)CCSprite *highscores;

@end
