#import "Tweak.h"

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
    self.indicatorView = [[PCINotificationView alloc] initWithIcon:icon title:title message:message];
    self.indicatorView.backgroundColor = UIColor.whiteColor;
    self.indicatorView.layer.cornerRadius = 30;
    self.indicatorView.clipsToBounds = YES;
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [lookView addSubview:self.indicatorView];
    [NSLayoutConstraint activateConstraints:@[
        [self.indicatorView.topAnchor constraintEqualToAnchor:lookView.topAnchor],
        [self.indicatorView.centerXAnchor constraintEqualToAnchor:lookView.centerXAnchor],
        [self.indicatorView.heightAnchor constraintEqualToConstant:60],
    ]];
    [self.indicatorView presentContentAnimated:YES];
}
%end

%hook BNContentViewController
%new
- (void)presentChargingBanner {
    UIDevice *currentDevice = [UIDevice currentDevice];
    if(currentDevice.batteryState != UIDeviceBatteryStateCharging) return;
    BBBulletinRequest *bulletin = [[%c(BBBulletinRequest) alloc] init];
    bulletin.title = currentDevice.name;
    bulletin.message = [NSString stringWithFormat:@"%d%%", (int)(currentDevice.batteryLevel * 100.0f)];
    bulletin.clearable = YES;
    bulletin.showsMessagePreview = NO;
    bulletin.recordID = @"com.popsicletreehouse.notification";
    NCNotificationRequest *request = [%c(NCNotificationRequest) notificationRequestForBulletin:bulletin observer:[[%c(BBObserver) alloc] init] sectionInfo:nil feed:59 playLightsAndSirens:NO];
    NCNotificationShortLookViewController *viewController = [[%c(NCNotificationShortLookViewController) alloc] initWithNotificationRequest:request revealingAdditionalContentOnPresentation:NO];
    SBNotificationPresentableViewController *presentable = [[%c(SBNotificationPresentableViewController) alloc] initWithNotificationViewController:viewController];
    [self presentPresentable:presentable withOptions:1 userInfo:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self _dismissPresentable:presentable withReason:nil animated:YES userInfo:nil];
    });
    PCIChargingView *notificationView = [[PCIChargingView alloc] initWithTitle:bulletin.title message:bulletin.message];
    NCNotificationShortLookView *lookView = [viewController valueForKey:@"_lookView"];
    for(UIView *subview in lookView.subviews) {
        [subview removeFromSuperview];
    }
    notificationView.backgroundColor = UIColor.whiteColor;
    notificationView.layer.cornerRadius = 30;
    notificationView.clipsToBounds = YES;
    notificationView.translatesAutoresizingMaskIntoConstraints = NO;
    [lookView addSubview:notificationView];
    [NSLayoutConstraint activateConstraints:@[
        [notificationView.topAnchor constraintEqualToAnchor:lookView.topAnchor],
        [notificationView.centerXAnchor constraintEqualToAnchor:lookView.centerXAnchor],
        [notificationView.heightAnchor constraintEqualToConstant:60],
    ]];
    [notificationView presentContent];
}
-(id)initWithAuthority:(id)arg1 {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentChargingBanner) name:UIDeviceBatteryStateDidChangeNotification object:nil];
    return %orig;
}
%end