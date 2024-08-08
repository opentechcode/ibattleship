//
//  Utility.h
//  iBattleships
//
//  Created by Sajjad Raza on 9/29/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utility : NSObject {
	
}

+(int) getRandomNumberWithMinValue:(int)min maxValue:(int)max andSeed:(BOOL)seed;
+(void)simpleShuffle:(NSMutableArray *)array;
+(float) getDistanceCentrePointandTouch :(CGPoint)objPoint  TouchLocation:(CGPoint)point;
+(int)upperCell:(int)cellNumber;
+(int)downwardCell:(int)cellNumber;
+(int)rightCell:(int)cellNumber;
+(int)leftCell:(int)cellNumber;
+(float)calculateAngleBetweenPoints:(CGPoint)firstTouch SecondTouch:(CGPoint) secondTouch;
+(NSString *)secondsToTimeConversion:(int)seconds;
+(UIAlertView *)alertViewWithActivityIndicatorWithTitle:(NSString*)title andMessage:(NSString*)msg;
+(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)msg;
+(UIAlertView *)alertViewWithTitle:(NSString*)title andMessage:(NSString*)msg;
@end
