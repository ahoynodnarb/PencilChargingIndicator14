#import "Tweak.h"

static void refreshPrefs() {
    NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.popsicletreehouse.pencilchargingindicator14prefs"];
    backgroundType = [bundleDefaults objectForKey:@"backgroundType"] ? [[bundleDefaults objectForKey:@"backgroundType"] intValue] : 0;
}
static void presentTestBanner() {
    refreshPrefs();
    [[NSNotificationCenter defaultCenter] postNotificationName:@"presentTestBanner" object:nil userInfo:@{}];
}

%hook NCNotificationShortLookViewController
%property (nonatomic, strong) PCINotificationView *indicatorView;
- (void)updateContent {
    %orig;
    NCNotificationShortLookView *lookView = [self valueForKey:@"_lookView"];
    if(self.indicatorView) return;
    if (![[lookView _viewControllerForAncestor] respondsToSelector:@selector(delegate)]) return;
    if (![[[lookView _viewControllerForAncestor] delegate] isKindOfClass:%c(SBNotificationBannerDestination)]) return;
    for(UIView *subview in lookView.subviews) {
        [subview removeFromSuperview];
    }
    BBBulletin *bulletin = self.notificationRequest.bulletin;
    UIImage *icon = lookView.icons[0];
    NSString *title = bulletin.title;
    NSString *message = bulletin.message;
    self.indicatorView = [[PCINotificationView alloc] initWithIcon:icon title:title message:message backgroundType:backgroundType];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [lookView addSubview:self.indicatorView];
    [NSLayoutConstraint activateConstraints:@[
        [self.indicatorView.topAnchor constraintEqualToAnchor:lookView.topAnchor],
        [self.indicatorView.centerXAnchor constraintEqualToAnchor:lookView.centerXAnchor],
        [self.indicatorView.heightAnchor constraintEqualToConstant:70],
    ]];
    [self.indicatorView presentContentAnimated:YES];
}
%end

%hook BNContentViewController
%new
- (void)presentChargingBanner:(NSNotification *)note {
    UIDevice *currentDevice = [UIDevice currentDevice];
    // bad
    if(currentDevice.batteryState != UIDeviceBatteryStateCharging && !note.userInfo) return;
    BBBulletinRequest *bulletin = [[%c(BBBulletinRequest) alloc] init];
    bulletin.title = currentDevice.name;
    bulletin.message = [NSString stringWithFormat:@"%d%%", (int)(currentDevice.batteryLevel * 100.0f)];
    bulletin.recordID = @"com.popsicletreehouse.notification";
    NCNotificationRequest *request = [%c(NCNotificationRequest) notificationRequestForBulletin:bulletin observer:[[%c(BBObserver) alloc] init] sectionInfo:nil feed:59 playLightsAndSirens:NO];
    NCNotificationShortLookViewController *viewController = [[%c(NCNotificationShortLookViewController) alloc] initWithNotificationRequest:request revealingAdditionalContentOnPresentation:NO];
    SBNotificationPresentableViewController *presentable = [[%c(SBNotificationPresentableViewController) alloc] initWithNotificationViewController:viewController];
    [self presentPresentable:presentable withOptions:1 userInfo:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self _dismissPresentable:presentable withReason:nil animated:YES userInfo:nil];
    });
    NCNotificationShortLookView *lookView = [viewController valueForKey:@"_lookView"];
    presentable.view.userInteractionEnabled = NO;
    for(UIView *subview in lookView.subviews) {
        [subview removeFromSuperview];
    }
    PCIChargingView *notificationView = [[PCIChargingView alloc] initWithTitle:bulletin.title message:bulletin.message backgroundType:backgroundType];
    notificationView.translatesAutoresizingMaskIntoConstraints = NO;
    [lookView addSubview:notificationView];
    [NSLayoutConstraint activateConstraints:@[
        [notificationView.topAnchor constraintEqualToAnchor:lookView.topAnchor],
        [notificationView.centerXAnchor constraintEqualToAnchor:lookView.centerXAnchor],
        [notificationView.heightAnchor constraintEqualToConstant:60],
    ]];
    [notificationView presentContentAnimated:YES];
}
- (id)initWithAuthority:(id)arg1 {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentChargingBanner:) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentChargingBanner:) name:@"presentTestBanner" object:nil];
    return %orig;
}
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) refreshPrefs, CFSTR("com.popsicletreehouse.pencilchargingindicator14.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) presentTestBanner, CFSTR("com.popsicletreehouse.presenttestbanner"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	refreshPrefs();
}