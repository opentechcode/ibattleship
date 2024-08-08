//
//  ServerCommunication.h
//  iPuzzle
//
//  Created by Ali Zafar on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CompititionObject;

@interface ServerCommunication : NSObject {

}

+(BOOL)submitScoreWithName:(NSString *)scorername Shots:(int)scorershots Time:(int)scorertime GameMode:(int)scorergameMode andDeviceId:(NSString *)scorer_device_id;

+(NSDictionary *)highScoreswithDeviceId:(NSString *)deviceId;
+(NSDictionary*)sendPostRequestToUrl:(NSString*) urlString withParameterString:(NSString*) parameterString ;

+(NSDictionary *)objectWithString:(NSString *)resultString;



@end
