//
//  GameWinLayer.m
//  iBattleShips
//
//  Created by Ali Zafar on 11/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameWinLayer.h"


@implementation GameWinLayer

@synthesize gameWinScreen,btnMenu,btnCancel,btnSubmit,delegate;


- (id) init
{
	self = [super init];
	if (self != nil) {
		self.gameWinScreen=[CCSprite spriteWithFile:@"white_screen_gameover_win.png"];
		[gameWinScreen setPosition:CGPointMake(1024/2, 768/2+70)];
		[self addChild:gameWinScreen];
			
		self.btnSubmit=[CCMenuItemImage itemFromNormalImage:@"btn_submit.png" selectedImage:@"btn_submit_press.png" target:self selector:@selector(sumbit:)];
		self.btnCancel=[CCMenuItemImage itemFromNormalImage:@"btn_cancel.png" selectedImage:@"btn_cancel_press.png" target:self selector:@selector(cancel:)];
		self.btnMenu=[CCMenu menuWithItems:btnSubmit,btnCancel,nil];
		[btnMenu setPosition:CGPointMake(0, 0)];
		[self addChild:btnMenu];
		//[self addChild:btnCancel];
		
		[btnSubmit setPosition:CGPointMake(1024/2-70, 768/2)];
		[btnCancel setPosition:CGPointMake(1024/2+70, 768/2)];
		[GameManager sharedGameManager].gameProcessor.txtname.delegate=self;
		btnSubmit.visible=NO;
		
	}
	return self;
}

-(void)sumbit:(id)sender
{
	[delegate submitScore];
}

-(void)cancel:(id)sender
{
	[delegate cancelScore];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
	//NSLog(@"%d",[string]);

   NSCharacterSet *smallletters=[NSCharacterSet characterSetWithRange:NSMakeRange('a', 26)];
	NSCharacterSet *capitalLetters=[NSCharacterSet characterSetWithRange:NSMakeRange('A', 26)];	
	
	NSCharacterSet *nonSmallLetters=[smallletters invertedSet];
	NSCharacterSet *nonCapitalLetters=[capitalLetters invertedSet];
	
	NSRange badCharacterRange1=[string rangeOfCharacterFromSet:nonSmallLetters];
	NSRange badCharacterRange2 =[string rangeOfCharacterFromSet:nonCapitalLetters];
	
	if ((badCharacterRange1.location != NSNotFound && badCharacterRange2.location !=NSNotFound) && (![string isEqualToString:@" "])) {
		return NO;
	}
	
	if ([textField.text length] > 15 )
	{
		return NO;
	}
	
	else if ([textField.text length] == 0 ) {
		
		btnSubmit.visible=YES;
		
	}
	else if(([textField.text length]==1 && [string isEqualToString:@""] )){
		 btnSubmit.visible=NO;
	}
	else {
		btnSubmit.visible=YES;
	}


	

	
	return YES;
}

- (void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[gameWinScreen release];
	[btnSubmit release];
	[btnCancel release];
	[btnMenu release];
	[super dealloc];
}


@end
