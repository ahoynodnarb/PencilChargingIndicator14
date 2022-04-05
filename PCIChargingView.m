#import "PCIChargingView.h"

@implementation PCIChargingView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message backgroundType:(int)backgroundType {
    if(self = [super initWithIcon:nil title:title message:message backgroundType:backgroundType]) {
        self.layer.cornerRadius = 30;
        self.messageLabel.font = [UIFont boldSystemFontOfSize:15];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _UIStatusBarBatteryItem *batteryItem = [[objc_getClass("_UIStatusBarBatteryItem") alloc] initWithIdentifier:[objc_getClass("_UIStatusBarBatteryItem") iconDisplayIdentifier] statusBar:nil];
        self.batteryView = batteryItem.batteryView;
        self.batteryView.iconSize = 5;
        self.batteryView.chargingState = 1;
        self.batteryView.chargePercent = [UIDevice currentDevice].batteryLevel;
        self.batteryView.saverModeActive = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
        self.batteryView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.messageContainerView addSubview:self.batteryView];
        if(backgroundType == 0 || backgroundType == 2) {
            self.messageLabel.textColor = UIColor.darkGrayColor;
            self.batteryView.bodyColor = UIColor.darkGrayColor;
            self.batteryView.boltColor = UIColor.blackColor;
            self.batteryView.pinColor = UIColor.darkGrayColor;
        }
        else {
            self.messageLabel.textColor = UIColor.whiteColor;
            self.batteryView.boltColor = UIColor.whiteColor;
            self.batteryView.bodyColor = UIColor.whiteColor;
            self.batteryView.pinColor = UIColor.whiteColor;
        }
    }
    return self;
}
- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.widthAnchor constraintEqualToConstant:200],
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
- (void)presentContentAnimated:(BOOL)animated {
    if(animated) {
        self.titleContainerView.transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(1.2,1.2), 0, 8);
        self.messageContainerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 12);
        self.messageContainerView.alpha = 0.0f;
        [UIView animateWithDuration:0.3f delay:0.8f options:UIViewAnimationOptionCurveLinear animations:^{
            self.messageContainerView.alpha = 1.0f;
            self.messageContainerView.transform = CGAffineTransformIdentity;
            self.titleContainerView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    [self.contentView layoutIfNeeded];
}
@end