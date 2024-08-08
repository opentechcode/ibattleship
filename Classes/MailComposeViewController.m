//
//  SendEmail.m
//  QuraniAyaat
//
//  Created by Ashar Samdani on 11/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MailComposeViewController.h"

@interface MailComposeViewController ()

	-(void)displayComposerSheetWith:(NSString*)subject message:(NSString*)message imageFileName:(NSString*)imageName andImage:(UIImage*)image;
	-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
	-(void)launchMailAppOnDeviceWith:(NSString*)subject message:(NSString*)message;


@end


@implementation MailComposeViewController

@synthesize errorMessage;

-(void)sendEmail:(NSString*)subject message:(NSString*)message imageFileName:(NSString*)imageName andImage:(UIImage*)image{
	
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheetWith:subject message:message imageFileName:imageName andImage:image];
		}
		else
		{
			[self launchMailAppOnDeviceWith:subject message:message];
			//[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDeviceWith:subject message:message];
	}
}




#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheetWith:(NSString*)subject message:(NSString*)message imageFileName:(NSString*)imageName andImage:(UIImage*)image{ 
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	[picker setSubject:subject];

/*	
	//Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"]; 
	NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil]; 
	NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"]; 
	
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];	
	[picker setBccRecipients:bccRecipients];
*/
	
	
	// Attach an image to the email
	if(image!=nil){

		NSString *mimeType=@"image/png";
		NSData *data = UIImagePNGRepresentation(image);
		if(data==nil){
			data = UIImageJPEGRepresentation(image, 1.0);
			mimeType=@"image/jpg";
		}
		[picker addAttachmentData:data mimeType:mimeType fileName:imageName];
	}
	
	[picker setMessageBody:message isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
	[picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	//message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			self.errorMessage = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			self.errorMessage = @"Result: saved";
			
			break;
		case MFMailComposeResultSent:
			self.errorMessage = @"Result: sent";
			NSLog(@"%@",self.errorMessage);
			break;
		case MFMailComposeResultFailed:
			self.errorMessage = @"Result: failed";
			NSLog(@"%@",error);
			break;
		default:
			self.errorMessage = @"Result: not sent";
			break;
	}
	NSLog(@"%@",self.errorMessage);
	[self dismissModalViewControllerAnimated:YES];
	//[self.navigationController popViewControllerAnimated:YES];

}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDeviceWith:(NSString*)subject message:(NSString*)message{
	
	NSString *urlString = [NSString stringWithFormat:@"mailto:?subject=%@&body=%@", subject, message];
	
	//NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	//NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@", urlString];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

@end
