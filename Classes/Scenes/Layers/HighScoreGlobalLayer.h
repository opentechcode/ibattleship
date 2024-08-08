//
//  HighScoreGlobalLayer.h
//  iBattleShips
//
//  Created by Ali Zafar on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScoreGlobalLayer : CCLayer {

	UIAlertView *alertView;
	CCSprite *highscores;
}

-(void)getGlobalScore;
-(void)populateLayer:(id)sender;

@property (nonatomic, retain)CCSprite *highscores;

@end
