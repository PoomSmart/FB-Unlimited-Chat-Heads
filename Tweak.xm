#import <Foundation/Foundation.h>

static BOOL FBCHisEnabled = YES;
static BOOL FBLandscape = YES;

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

%hook UIViewController

+ (BOOL)_synthesizeSupportedInterfaceOrientationsFromShouldAutorotateToInterfaceOrientation
{
	return FBLandscape ? YES : %orig;
}

- (BOOL)shouldAutorotate
{
	return FBLandscape ? YES : %orig;
}

- (BOOL)window:(id)arg1 shouldAutorotateToInterfaceOrientation:(int)arg2
{
	return FBLandscape ? YES : %orig;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1
{
	return FBLandscape ? YES : %orig;
}

%end

%hook UIWindow

- (BOOL)_legacyShouldAutorotateToInterfaceOrientation:(int)arg1
{
	return FBLandscape ? YES : %orig;
}

- (BOOL)_shouldAutorotateToInterfaceOrientation:(int)arg1
{
	return FBLandscape ? YES : %orig;
}

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
  	[pool drain];
}