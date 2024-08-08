//
//  LocalWifiConnection.m
//  BattleshipiPhone
//
//  Created by Ali Zafar on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocalWifiConnection.h"
//#import "MultiplayerSelectionController.h"

@implementation LocalWifiConnection

-(void)startPicker
{
	//MultiplayerSelectionController *selectionController= [[MultiplayerSelectionController alloc] init];
	//[[(BattleshipiPhoneAppDelegate *)[UIApplication sharedApplication].delegate viewController].view  addSubview:selectionController.mytableView];;
	
	//[[(BattleshipiPhoneAppDelegate *)[UIApplication sharedApplication].delegate viewController] presentModalViewController:selectionController animated:YES];;

	//[[GameManager sharedGameManager] localNetworkSelectionScene];
	
	
	GKPeerPickerController*		picker;
	
	//self.gameState = kStatePicker;			// we're going to do Multiplayer!
	
	picker = [[GKPeerPickerController alloc] init]; // note: picker is released in various picker delegate methods when picker use is done.
	//[picker setConnectionTypesMask:GKPeerPickerConnectionTypeNearby];	
	//[picker setConnectionTypesMask:GKPeerPickerConnectionTypeOnline];	
	picker.delegate = self;
	[picker show]; 
	 
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker { 
	// Peer Picker automatically dismisses on user cancel. No need to programmatically dismiss.
    
	// autorelease the picker. 
	picker.delegate = nil;
    [picker autorelease]; 
	[[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager invalidateSession];

}

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type { 
	GKSession *session = [[GKSession alloc] initWithSessionID:CONST_WIFI_SESSION_ID displayName:nil sessionMode:GKSessionModePeer]; 
	return [session autorelease]; // peer picker retains a reference, so autorelease ours so we don't leak.
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session { 
	// Remember the current peer.
	//self.gamePeerId = peerID;  // copy
	
	// Make sure we have a reference to the game session and it is set up
	[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager.multiplayerGametype=CONST_MULTIPLAYER_GAME_TYPE_LOCALWIFI;
	[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager.gameSession= session; // retain
	[[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager setLocalWifiDataHandler];
	[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager.gameSession.delegate = [GameManager sharedGameManager].gameProcessor.multiPlayerGameManager; 
	
	// Done with the Peer Picker so dismiss it.
	[picker dismiss];
	 picker.delegate = nil;
	[picker autorelease];
	
	
	[[GameManager sharedGameManager].gameProcessor.multiPlayerGameManager startGame];
	
	[[GameManager sharedGameManager] multiplayerGamePlayScene];
	
}


@end
