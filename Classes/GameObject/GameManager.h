//
//  GameManager.h
//  iBattleShips
//
//  Created by Sajjad Raza on 9/28/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameProcessor.h";
#import "MailComposeViewController.h"
#import "GameCenter.h"
#import "LocalWifiConnection.h"

@interface GameManager : NSObject <MFMailComposeViewControllerDelegate>
{
	
	
	GameProcessor *gameProcessor;
	
    UIDeviceOrientation currentOrientation;
	
	MailComposeViewController *mail ;
	MFMailComposeViewController *mfmail;
	
	GameCenter *gamecenter;
	
	LocalWifiConnection *localWifi;
		
	
}

@property (nonatomic,retain) GameProcessor *gameProcessor;
@property (nonatomic, retain)MailComposeViewController *mail;
@property (nonatomic, retain)GameCenter *gamecenter;
//@property (readwrite) BOOL isGamePaused;
@property (nonatomic, retain)MFMailComposeViewController *mfmail;

@property (nonatomic, retain)LocalWifiConnection *localWifi;

+(GameManager*) sharedGameManager;
-(void)refreshGameProcessor;
-(void)startGame;
-(void)mainMenu;
-(void) mainMenu;
-(void) howtoplayscene;
-(void ) gamePlayScene;
-(void ) optionScene;
-(void ) creditScene;
-(void ) helpScene;
-(void ) highScoreScene;
-(void)multiplayerGamePlayScene;
-(void)  multiplayerScene;


-(void) changePositionofAdd:(UIInterfaceOrientation)orientation;
-(void)rotateMailComposer:(UIDeviceOrientation)deviceOrientation;
-(void)orientationChanged:(id)sender;
-(void)saveGameSettings;
-(void) loadGameSettings;
-(void) inviteYourFriends:(id)sender;







@end
