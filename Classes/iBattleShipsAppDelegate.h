//
//  iBattleShipsAppDelegate.h
//  iBattleShips
//
//  Created by Sajjad Raza on 10 / 6 / 10.
//  Copyright Vizio-Mobile Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface iBattleShipsAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	
	RootViewController *viewController;
	
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain)RootViewController *viewController;


+ (NSString *) pathForApplicationFile: (NSString *) name;
@end
