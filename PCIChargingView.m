#import "PCIChargingView.h"

@implementation PCIChargingView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if(self = [super initWithIcon:nil title:title message:message]) {
        self.messageLabel.textColor = UIColor.grayColor;
        _UIStatusBarBatteryItem *batteryItem = [[objc_getClass("_UIStatusBarBatteryItem") alloc] initWithIdentifier:[objc_getClass("_UIStatusBarBatteryItem") iconDisplayIdentifier] statusBar:nil];
        self.batteryView = batteryItem.batteryView;
        self.batteryView.iconSize = 5;
        self.batteryView.chargingState = 1;
        self.batteryView.chargePercent = [UIDevice currentDevice].batteryLevel;
        self.batteryView.saverModeActive = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
        self.batteryView.fillColor = UIColor.whiteColor;
        self.batteryView.boltColor = UIColor.blackColor;
        self.batteryView.bodyColor = UIColor.grayColor;
        self.batteryView.pinColor = UIColor.grayColor;
        self.batteryView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.messageContainerView addSubview:self.batteryView];
    }
    return self;
}
- (void)setupConstraints {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [NSLayoutConstraint activateConstraints:@[
        [self.widthAnchor constraintLessThanOrEqualToConstant:screenWidth-20],
        [self.widthAnchor constraintGreaterThanOrEqualToConstant:250],
        [self.titleContainerView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.titleContainerView.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor],
        [self.titleContainerView.bottomAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.titleContainerView.topAnchor],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.titleContainerView.trailingAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.titleContainerView.leadingAnchor],
        [self.titleLabel.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor constant:-80],
        [self.messageContainerView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:5],
        [self.messageContainerView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.messageContainerView.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor constant:-40],
        [self.messageLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.messageLabel.leadingAnchor constraintEqualToAnchor:self.messageContainerView.leadingAnchor],
        [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.batteryView.leadingAnchor constant:-10],
        [self.batteryView.centerYAnchor constraintEqualToAnchor:self.messageLabel.centerYAnchor],
        [self.batteryView.leadingAnchor constraintEqualToAnchor:self.messageLabel.trailingAnchor],
        [self.batteryView.trailingAnchor constraintEqualToAnchor:self.messageContainerView.trailingAnchor],
        [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor],
    ]];
}
- (void)presentContent {
    [super presentContentAnimated:NO];
}
@end