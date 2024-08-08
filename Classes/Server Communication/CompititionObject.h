//
//  CompititionObject.h
//  iPuzzle
//
//  Created by Ali Zafar on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CompititionObject : NSObject {

	NSString *scoreid;
	NSString *name;
	int   shots;
	int time;
	NSString *gamemode;
	NSString *deviceid;
	
		
	
}
//- (id) initWithCompititionId:(NSString *)cid CompititionName:(NSString *)name Image:(UIImage *)img;
@property (nonatomic, retain)NSString *scoreid;
@property (nonatomic, retain)NSString *name;

@property (nonatomic, retain)NSString *gamemode;
@property (nonatomic, retain)NSString *deviceid;

@property (readwrite)int shots;
@property (readwrite)int time;



@end
