//
//  GameWinLayer.h
//  iBattleShips
//
//  Created by Ali Zafar on 11/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameWinLayer : CCLayer <UITextFieldDelegate>{

	CCSprite *gameWinScreen;
	CCMenuItemImage *btnSubmit;
	CCMenuItemImage *btnCancel;
	
	CCMenu    *btnMenu;
	
	id<AnimationProtocol>delegate;
	
}
@property (nonatomic, retain)CCSprite *gameWinScreen;
@property (nonatomic, retain)CCMenuItemImage *btnSubmit;
@property (nonatomic, retain)CCMenuItemImage *btnCancel;
@property (nonatomic, retain)CCMenu *btnMenu;
@property (nonatomic, retain)id<AnimationProtocol>delegate;


@end
