//
//  HighScore.h
//  iBattleShips
//
//  Created by Ali Zafar on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScore : NSObject<NSCoding> {

	NSString *name;
	int shots;
	int time;
	int gameMode;
	NSString *deviceId;
	
}

@property(nonatomic,retain)NSString *name;
@property (readwrite)int shots;
@property (readwrite)int time;
@property (readwrite)int gameMode;
@property (nonatomic, retain)NSString *deviceId;

-(HighScore *)initwithName:(NSString *)scorername Shots:(int)scorershots Time:(int)scorertime GameMode:(int)scorergameMode andDeviceId:(NSString *)scorer_device_id;
-(HighScore *)initwithDictionary:(NSDictionary *)dict;



@end
