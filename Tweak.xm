#import <Foundation/Foundation.h>

static BOOL FBCHisEnabled = YES;
static BOOL FBLandscape = YES;
//static BOOL chatHeadsInsideTrash;

%group FBCH

%hook FBChatHeadSurfaceView

- (int)maximumChatHeadCountIncludingInbox
{
	return FBCHisEnabled ? 999 : %orig;
}

%end

%hook FBChatHeadLayoutBeeper

- (int)maximumChatHeadCountIncludingInbox
{
	return FBCHisEnabled ? 999 : %orig;
}

%end

%hook FBChatHeadLayout

- (int)maximumChatHeadCountIncludingInbox
{
	return FBCHisEnabled ? 999 : %orig;
}

%end

%end


%group FBLandscape

%hook _UIDictionaryDownloadViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook _UIFallbackPresentationViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

- (BOOL)shouldAutorotate { return FBLandscape ? YES : %orig; }

%end

%hook _UIRemoteViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook _UIRemoteWebViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook _UIServiceWebViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook _UIViewServiceViewControllerOperator

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook _UIWebViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIActivityViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIFullScreenViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIImagePickerController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UINavigationController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPageController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPageViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrinterBrowserViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrintingProgressViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrintPanelTableViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrintPanelViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrintPaperViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrintRageViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end 

%hook UIPrintStatusJobsViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrintStatusTableViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIPrintStatusViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIReferenceLibraryViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UISplitViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UITabBarController

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIViewController

+ (BOOL)_synthesizeSupportedInterfaceOrientationsFromShouldAutorotateToInterfaceOrientation { return FBLandscape ? YES : %orig; }

- (BOOL)_doesOverrideLegacyShouldAutorotateMethod { return FBLandscape ? YES : %orig; }

- (BOOL)shouldAutorotate { return FBLandscape ? YES : %orig; }

- (BOOL)window:(id)arg1 shouldAutorotateToInterfaceOrientation:(int)arg2 { return FBLandscape ? YES : %orig; }

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%hook UIWindow

- (BOOL)_legacyShouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

- (BOOL)_shouldAutorotateToInterfaceOrientation:(int)arg1 { return FBLandscape ? YES : %orig; }

%end

%end


static void FBCHLoader()
{
	NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.PS.FBUnlimitedChatHeads.plist"];
	id FBCHEnabled = [dict objectForKey:@"FBCHEnabled"];
	FBCHisEnabled = FBCHEnabled ? [FBCHEnabled boolValue] : YES;
	id FBLCEnabled = [dict objectForKey:@"FBLCEnabled"];
	FBLandscape = FBLCEnabled ? [FBLCEnabled boolValue] : YES;
}

static void PostNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	FBCHLoader();
}

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PostNotification, CFSTR("com.PS.FBUnlimitedChatHeads.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	FBCHLoader();
	%init(FBCH);
	%init(FBLandscape);
  	[pool release];
}