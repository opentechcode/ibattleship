//
//  NetworkWrapper.m
//  PopularityContest
//

#import "NetworkWrapper.h"

static NetworkWrapper *sharedNetworkInstance = nil;


@interface NetworkWrapper ()

-(void)setupNetworkWrapper;

@end

@implementation NetworkWrapper
@synthesize internetConnectionStatus;
@synthesize localWiFiConnectionStatus;


+ (NetworkWrapper *) sharedNetworkInstance {
    @synchronized (self) {
        if (sharedNetworkInstance == nil) {
            sharedNetworkInstance = [[self alloc] init];
        }
    }	
	return sharedNetworkInstance;
}


-(id)init{
	self=[super init];
	if (self!=nil) {
		internetConnectionStatus = NO;
		localWiFiConnectionStatus = NO;
		//[self setupNetworkWrapper];
	}
	return self;
}

-(void)setupNotifierWithTarget:(id)target selector:(SEL)selector{
	[[NSNotificationCenter defaultCenter] 
	 addObserver:target selector:selector name:@"kNetworkReachabilityChangedNotification" object:nil];
}

-(void)setupNetworkWrapper{
	[[Reachability sharedReachability] setHostName:SERVER_URL];
	self.internetConnectionStatus	= [[Reachability sharedReachability] internetConnectionStatus];
	self.localWiFiConnectionStatus	= [[Reachability sharedReachability] localWiFiConnectionStatus];	
}

-(BOOL)isNetworkAvailable{
	[self setupNetworkWrapper];
	if(self.internetConnectionStatus || self.localWiFiConnectionStatus){
		return YES;
	}
	else{
		return NO;
	}
}

@end
