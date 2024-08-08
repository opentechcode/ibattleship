//
//  GameplayGadgetLayer.h
//  iBattleShips
//
//  Created by Ali Zafar on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameplayGadgetLayer : CCLayer {

	CCMenuItemImage *autoDeployBtn;
	CCMenuItemImage *startButton;
	CCMenuItemToggle *btnPause;

	
	CCMenu *menu;
	CCMenu *secondMenu;

	
	CCSprite *clockTimer;
	
	CCSprite *enemy_strike_counter;
	
	CCSprite *player_strike_counter;
	
	
	
	CCSprite *player_anchor_image;
	CCSprite *enemy_anchor_image;
	
//	CCSprite *bottomBar;
	CCSprite *upperBar;
	
	NSMutableArray *player_health_bar;
	NSMutableArray *enemy_health_bar;
	
	CCLabel *timeLabel;
	
	CCLabel *player_count_label1;
	CCLabel *player_count_label2;
	CCLabel *player_count_label3;
	
	CCLabel *enemy_count_label1;
	CCLabel *enemy_count_label2;
	CCLabel *enemy_count_label3;
	
	
	int seconds_counter;
	
	int player_turn_counter;
	int enemy_turn_counter;
	
	BOOL isGameStarted;
	
	
	
	
}

@property(nonatomic, retain)CCMenuItemImage *autoDeployBtn;
@property(nonatomic, retain)CCMenuItemImage *startButton;
@property(readwrite) BOOL isGameStarted;

@property (nonatomic, retain)CCMenu *menu;
@property (nonatomic, retain)CCMenu *secondMenu;

@property (nonatomic ,retain)CCSprite *clockTimer;
@property (nonatomic, retain)CCSprite *enemy_strike_counter;
@property (nonatomic, retain)CCSprite *player_strike_counter;



@property (nonatomic , retain)CCSprite *player_anchor_image;
@property (nonatomic, retain)CCSprite *enemy_anchor_image;

//@property (nonatomic, retain)CCSprite *bottomBar;
@property (nonatomic, retain)CCSprite *upperBar;

@property (nonatomic, retain)NSMutableArray *player_health_bar;
@property (nonatomic, retain)NSMutableArray *enemy_health_bar;

@property (nonatomic, retain)CCLabel *timeLabel;
@property (nonatomic, retain)CCMenuItemToggle *btnPause;


@property (nonatomic, retain)CCLabel *player_count_label1;
@property (nonatomic, retain)CCLabel *player_count_label2;
@property (nonatomic, retain)CCLabel *player_count_label3;

@property (nonatomic, retain)CCLabel *enemy_count_label1;
@property (nonatomic, retain)CCLabel *enemy_count_label2;
@property (nonatomic, retain)CCLabel *enemy_count_label3;

@property (readwrite)int seconds_counter;

-(void)firButtonPressed:(id)sender;

-(void)setComponentPositions;
-(void)updatePlayerHealthBar:(int)health;
-(void)updateEnemyHealthBar:(int)health;

-(void)updatePlayerCount:(int)counter;
-(void)updateEnemyCount:(int)counter;

-(void)initializeLabels;

-(void)updateTime:(id)sender;
-(BOOL) canWeStartGame;

-(void)turnPlayerOn:(id)sender;
-(void)computerAttack:(id)sender;
-(void)finishTimer;
@end
