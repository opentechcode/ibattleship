//
//  Constant.h
//  iBattleships
//
//  Created by Sajjad Raza on 9/29/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#define CONST_MAINMENU_POSITION_X 920
#define CONST_MAINMENU_POSITION_Y 30

#define CONST_SCREEN_MIDDLE_POSITION_X 1024/2
#define CONST_SCREEN_MIDDLE_POSITION_Y 768/2

#define CONST_MAIN_TEXT_POSITION_X 280
#define CONST_MAIN_TEXT_POSITION_Y 350

#define CONST_MAP_STATE_SIMPLE 0
#define CONST_MAP_STATE_SHIP_UNDER_DESTRUCTION 1

#define CONST_CELL_OCCUPATION_STATE_EMPTY 0
#define CONST_CELL_OCCUPATION_STATE_SHIP 1

#define CONST_CELL_HIT_STATUS_EMPTY 0
#define CONST_CELL_HIT_STATUS_MISSED 1
#define CONST_CELL_HIT_STATUS_BLAST 2

/////////////// If name spellings are changed here then they must be changed in Ships.plist respectively ////////////////////////////////////////////////////
#define CONST_SHIP_TYPE_AIRCRAFT_CARRIER @"AirCraftCarrier"
#define CONST_AIRCRAFT_X_ADJUSTMENT_VERTICAL  24//13
#define CONST_AIRCRAFT_Y_ADJUSTMENT_VERTICAL   24//13
#define CONST_AIRCRAFT_X_ADJUSTMENT_HORIZONTAL  24//-20//25
#define CONST_AIRCRAFT_Y_ADJUSTMENT_HORIZONTAL  -24//20//-3

#define CONST_AIRCRAFT_X_INITIAL_ADJUSTMENT_HORIZONTAL  20
#define CONST_AIRCRAFT_Y_INITIAL_ADJUSTMENT_HORIZONTAL  -35
#define CONST_AIRCRAFT_X_INITIAL_ADJUSTMENT_VERTICAL  20
#define CONST_AIRCRAFT_Y_INITIAL_ADJUSTMENT_VERTICAL  20


#define CONST_SHIP_TYPE_DESTROYER @"Destroyer"
#define CONST_DESTROYER_Y_ADJUSTMENT_VERTICAL   -27//-1
#define CONST_DESTROYER_X_ADJUSTMENT_VERTICAL   0//20
#define CONST_DESTROYER_Y_ADJUSTMENT_HORIZONTAL  0
#define CONST_DESTROYER_X_ADJUSTMENT_HORIZONTAL  -20//-17

#define CONST_DESTROYER_X_INITIAL_ADJUSTMENT_HORIZONTAL  -10
#define CONST_DESTROYER_Y_INITIAL_ADJUSTMENT_HORIZONTAL  -5

#define CONST_DESTROYER_X_INITIAL_ADJUSTMENT_VERTICAL  +20
#define CONST_DESTROYER_Y_INITIAL_ADJUSTMENT_VERTICAL  -12


#define CONST_SHIP_TYPE_WARRIOR @"Carrier"
#define CONST_WARRIOR_X_ADJUSTMENT_VERTICAL   0
#define CONST_WARRIOR_Y_ADJUSTMENT_VERTICAL   -27
#define CONST_WARRIOR_X_ADJUSTMENT_HORIZONTAL  -20
#define CONST_WARRIOR_Y_ADJUSTMENT_HORIZONTAL   0

#define CONST_WARRIOR_X_INITIAL_ADJUSTMENT_HORIZONTAL  -10
#define CONST_WARRIOR_Y_INITIAL_ADJUSTMENT_HORIZONTAL  -5

#define CONST_WARRIOR_X_INITIAL_ADJUSTMENT_VERTICAL  +20
#define CONST_WARRIOR_Y_INITIAL_ADJUSTMENT_VERTICAL  -12


#define CONST_SHIP_TYPE_GUNSHIP_BOAT @"GunShipBoat"
#define CONST_GUNSHIP_BOAT_X_ADJUSTMENT_VERTICAL   0
#define CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_VERTICAL   0//10
#define CONST_GUNSHIP_BOAT_X_ADJUSTMENT_HORIZONTAL 0//2 
#define CONST_GUNSHIP_BOAT_Y_ADJUSTMENT_HORIZONTAL 0//9

#define CONST_GUNSHIP_BOAT_X_INITIAL_ADJUSTMENT_HORIZONTAL  0
#define CONST_GUNSHIP_BOAT_Y_INITIAL_ADJUSTMENT_HORIZONTAL  0
#define CONST_GUNSHIP_BOAT_X_INITIAL_ADJUSTMENT_VERTICAL  0
#define CONST_GUNSHIP_BOAT_Y_INITIAL_ADJUSTMENT_VERTICAL  0



#define CONST_SHIP_TYPE_SUBMARINE @"SubMarine"
#define CONST_SUBMARINE_X_ADJUSTMENT_VERTICAL   0//5
#define CONST_SUBMARINE_Y_ADJUSTMENT_VERTICAL   0//5
#define CONST_SUBMARINE_X_ADJUSTMENT_HORIZONTAL 0//7
#define CONST_SUBMARINE_Y_ADJUSTMENT_HORIZONTAL 0//7

#define CONST_SUBMARINE_X_INITIAL_ADJUSTMENT_HORIZONTAL  0
#define CONST_SUBMARINE_Y_INITIAL_ADJUSTMENT_HORIZONTAL  0
#define CONST_SUBMARINE_X_INITIAL_ADJUSTMENT_VERTICAL  0
#define CONST_SUBMARINE_Y_INITIAL_ADJUSTMENT_VERTICAL  0



#define CONST_SHIP_ORIENTATION_VERTICAL_UP @"Vertical-Up"
#define CONST_SHIP_ORIENTATION_VERTICAL_Down @"Vertical-Down"
#define CONST_SHIP_ORIENTATION_HORIZONTAL_Right @"Horizontal-Right"
#define CONST_SHIP_ORIENTATION_HORIZONTAL_LEFT @"Horizontal-Left"

#define CONST_CELLS_DIRECTION_UPWARD @"Up"
#define CONST_CELLS_DIRECTION_DOWNWARDS @"Down"
#define CONST_CELLS_DIRECTION_PARALLEL @"Parallel"


#define CONST_CELLS_DIRECTION_RIGHTWARDS @"Right"
#define CONST_CELLS_DIRECTION_LEFTWARDS @"Left"


//////////Ship Constants/////////////////////////////////


///////////////////////////////////////////////////////

////////////// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////  Grid width and length/////////////

#define CONST_CELLS_WIDTH 10
#define CONST_CELLS_HEIGHT 10
#define CONST_CELLS_TOTAL_GRIDS 100

/////////////////////////////////AI Generator////////////////////////////////////////



#define CONST_BLAST_DIRECTION_RIGHT 1

#define CONST_BLAST_DIRECTION_LEFT 2

#define CONST_BLAST_DIRECTION_UP 3

#define CONST_BLAST_DIRECTION_DOWN 4


///////////////////////Ship Constants//////////////////////////////////////////////////////////////


#define CONST_SHIP_LIFE_ALIVE 0
#define CONST_SHIP_LIFE_DEAD 1

/////////////////Font constants/////////////////////

#define CONST_FONT_TITLE_SIZE 22
#define CONST_FONT_TEXT_SIZE 14
#define CONST_STRING_FONT_NAME @"Verdana-BoldItalic"

//////////////////////////////////////////////////////

#define STORY @"The enemy has deployed hidden aircraft carriers, frigates and submarines in the ocean on our side. The enemy planted ships are here to destroy our naval fleet. Our communication system has broken down and we have no information on the enemy fleet. It is now up to you to help your country by destroying the enemy fleet. You would need to spot enemy fleet by guessing the position and our artillery will fire the missile at the target location. Mission is to destroy enemy fleet before it destroys ours. Good Luck!!!"                         



//////////////////////////////////////////////

#define CONST_TURN_PLAYER 0
#define CONST_TURN_ENEMY 1
///////////////////////////////////////////////
#define ENEMY_IDENTIFIER 1
#define PLAYER_IDENTIFIER 2
#define MIN_VALUE 1000000

#define MINDISTANCE 1200

//////////////////////////////////////////////////

#define ADMOB_SIMULATOR_ID @"Simulator"
#define ADMOB_IPOD_ID      @"a0564cd63d6165ea63e709152e2c912a3f89193e"
#define ADMOB_IPAD_ID      @"f1ba07102e16bbb0654127e84bdb9b3d493e7c8d"

///////////////////////////////////////////
#define EMAIL_SUBJECT    @"A fantastic iPad game"
#define EMAIL_MESSAGE    @"Hello!! I enjoyed playing the WARSHIP game from Envision Studios and thought you might like to try it as well.  WARSHIP is an all time classic naval strategy game.  WARSHIP offers a great interface with an amazing gameplay.  Goodluck."  

#define CONST_HOW_TO_PLAY_MESSAGE @"Place your ships by dragging them vertically or horizontally on the grid."
#define CONST_HOW_TO_PLAY_MESSAGE_OK @" Once you are done, please select \"OK\"."


///////////////////Server Communication////////////////////////////////

#define SERVER_URL @"http://mail.yahoo.com"

#define CONST_URL_SERVER @"http://www.envisionstudios.biz/iBattleShip_Server/"
//#define CONST_URL_SERVER @"http://localhost:8888/iBattleShip_Server/"

#define CONST_URL_ENTER_COMPETITION @"images/enterInCompitition"

#define CONST_URL_GET_HIGHSCORE  @"highscores/get_scores/"

#define CONST_URL_SAVE_HIGH_SCORE  @"highscores/add_score/"



///////////////////////////////////////////////////////////////////////
#define CONST_ALERT_TYPE_HIGHSCORE 0
#define CONST_ALERT_TYPE__QUIT  1

//////////////////////////// Constants for Alerts Messages//////////////

#define CONST_ALERT_NETWORK_UNAVAILABLE_TITLE @"Network Unavailable"
#define CONST_ALERT_NETWORK_UNAVAILABLE_MESSAGE @"Could not connect to internet"
#define CONST_ALERT_NETWORK_UNAVAILABLE_MESSAGE_RETRY @"Could not connect to the internet. Do you want to retry?"


#define CONST_ALERT_CONNECTING_TITLE @"Connecting......"
#define CONST_ALERT_CONNECTING_MESSAGE @"Please wait while we connect to the server"

#define CONST_ALERT_SERVER_NOT_FOUND_TITLE @"Server Not Found!"
#define CONST_ALERT_SERVER_NOT_FOUND_MESSAGE @"Could not connect to the server"
#define CONST_ALERT_SERVER_NOT_FOUND_MESSAGE_RETRY @"Could not connect to the server. Do you want to retry?"


#define CONST_ALERT_GLOABAL_SCORE_TITLE @"Game Center"
#define CONST_ALERT_GLOABAL_SCORE_TEXT  @"Do you want to submit your score to Game Center?"


#define CONST_STARTINGX_ENEMY 43
#define CONST_STARTINGY_ENEMY 610

#define CONST_STARTINGX_PLAYER_GP 546
#define CONST_STARTINGY_PLAYER_GP 610

#define CONST_STARTINGX_PLAYER 288
#define CONST_STARTINGY_PLAYER 608


#define ADDEDX   425
#define ADDEDY   0 


#define CONST_GAME_TYPE_SINGLE_PLAYER 0
#define CONST_GAME_TYPE_MULTI_PLAYER 1



//////////Message Types//////////
#pragma mark Message Types

#define CONST_MESSAGE_TYPE_HAND_SHAKE   0
#define CONST_MESSAGE_TYPE_DEPLOYED      1
#define CONST_MESSAGE_TYPE_ATTACK       2
#define CONST_MESSAGE_TYPE_WIN          3

#define CONST_MESSAGE_TYPE @"message_type"


/////////////Keys/////////////////
#pragma mark Keys

#define CONST_KEY_SHIP_TYPE @"ship_type"

#define CONST_KEY_CELL_NUMBER @"cellnumber"

#define CONST_KEY_SHIP_ORIENTATION @"current_orientation"

#define CONST_KEY_DEPLOYMENT_TIME @"time"

////////// Multiplayer Game States//////////////////////

#pragma mark Game states

#define CONST_GAME_STATE_NOT_STARTED -1
#define CONST_GAME_STATE_INITIALIZE 0
#define CONST_GAME_STATE_REMOTE_DEPLOYED 1
#define CONST_GAME_STATE_PLAYER_DEPLOYED 2
#define CONST_GAME_STATE_BOTH_DEPLOYED 3
#define CONST_GAME_STATE_PLAYER_TURN 4
#define CONST_GAME_STATE_REMOTE_COMPUTER_TURN 5


#pragma mark  Multiplayer Game Messages

#define CONST_MULIPLAYER_MESSAGE_OTHER_PLAYER_LEFT_TITLE @"Other Player Left"

#define CONST_MULIPLAYER_MESSAGE_OTHER_PLAYER_LEFT_TEXT @"Other Player has left the game"


#define CONST_MULIPLAYER_MESSAGE_WATING_FOR_DEPLOYMENT_TITLE @"Wait"

#define CONST_MULIPLAYER_MESSAGE_WATING_FOR_DEPLOYMENT_TEXT @"Please wait while other player deploys the ships"


#define CONST_MULIPLAYER_MESSAGE_WATING_FOR_TURN_TITLE @"Other Player Left"

#define CONST_MULIPLAYER_MESSAGE_WATING_FOR_TURN_TEXT @"Please wait while other player takes the turn"

#define CONST_MULIPLAYER_MESSAGE_WATING_FOR_OTHER_TO_READY @"Please wait while other player is ready"


//////////Local Wifi Constants/////////////////////////
#define CONST_WIFI_SESSION_ID @"warship"

#define CONST_MULTIPLAYER_GAME_TYPE_LOCALWIFI 0

#define CONST_MULTIPLAYER_GAME_TYPE_GAMECENTER 1






 