//
//  GameCenter.h
//  BattleshipiPhone
//
//  Created by Ali Zafar on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GameKit/GameKit.h>

@interface GameCenter : NSObject<GKLeaderboardViewControllerDelegate, GKMatchmakerViewControllerDelegate> {

	BOOL isPlayerAuthenticated;
	NSMutableArray *scores;
	
	UIAlertView *alertview;
	
}

@property (readwrite) BOOL isPlayerAuthenticated;
@property (nonatomic, retain)NSMutableArray *scores;

-(void)registerInviteHandler;

- (void)autheticatePlayer;
-(void )  registerForAuthenticationNotification;
-(void)authentiacationChanged:(id)sender;

-(void)reportTheScore:(int)shots ;
-(void)reportOutStandingScore;

-(void)authenticatePlayerToSubmitScore:(int)myscore;

-(void)loadScores;
-(void)saveScores;

-(void)showViewControllerLeaderBoard;
-(void)authenticatePlayerToShowLearderBoard;
-(void)launchAutoMatching;
@end
