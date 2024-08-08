//
//  NetworkWrapper.h
//  PopularityContest
//

#import <UIKit/UIKit.h>
#import "Reachability.h"


@interface NetworkWrapper : NSObject {
	NetworkStatus internetConnectionStatus;
	NetworkStatus localWiFiConnectionStatus;
}
@property NetworkStatus internetConnectionStatus;
@property NetworkStatus localWiFiConnectionStatus;

+ (NetworkWrapper *)sharedNetworkInstance;
- (void)setupNotifierWithTarget:(id)target selector:(SEL)selector;
- (BOOL)isNetworkAvailable;

@end
