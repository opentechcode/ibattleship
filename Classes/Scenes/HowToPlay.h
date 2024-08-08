//
//  HowToPlay.h
//  iBattleShips
//
//  Created by Ali Zafar on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HowToPlay : CCScene {

	CCSprite *backgroundImage;
	CCSprite *backgroundUpperImage;
	CCLabel *lblHowToPlay;
	CCLabel *lblHowToPlayOK;
	CCMenuItemImage *okbutton;
	CCMenuItemImage *mainMenuButton;
	BOOL isLocked;
	
}


@property (nonatomic ,retain) CCSprite *backgroundImage;
@property (nonatomic ,retain) CCSprite *backgroundUpperImage;
@property (nonatomic, retain)CCLabel *lblHowToPlay;
@property (nonatomic, retain)CCLabel *lblHowToPlayOK;
@property (nonatomic, retain)CCMenuItemImage *okbutton;
@property (nonatomic, retain)CCMenuItemImage *mainMenuButton;
-(void)mainMenuButtonPressed:(id)sender;
-(void)okButtonPressed:(id)sender;

@end
