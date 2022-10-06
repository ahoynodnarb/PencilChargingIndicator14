#import "PCINotificationView.h"

@implementation PCINotificationView
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)title message:(NSString *)message backgroundStyle:(unsigned long)backgroundStyle {
    if (self = [super init]) {
        self.layer.cornerRadius = 35;
        self.clipsToBounds = YES;
        self.backgroundStyle = backgroundStyle;
        self.contentView = [[UIView alloc] init];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.contentView];
        self.titleContainerView = [[UIView alloc] init];
        self.titleContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.titleContainerView];
        self.messageContainerView = [[UIView alloc] init];
        self.messageContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.messageContainerView];
        self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[icon CGImage] scale:2 orientation:(icon.imageOrientation)]];
        self.iconImageView.clipsToBounds = NO;
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.titleContainerView addSubview:self.iconImageView];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = title;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.titleContainerView addSubview:self.titleLabel];
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.text = message;
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.messageLabel.font = [UIFont systemFontOfSize:16];
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.messageContainerView addSubview:self.messageLabel];
        if(backgroundStyle == PCIBackgroundStyleLight) {
            self.titleLabel.textColor = [UIColor blackColor];
            self.messageLabel.textColor = [UIColor blackColor];
            self.backgroundColor = [UIColor whiteColor];
        }
        else if(backgroundStyle == PCIBackgroundStyleDark) {
            self.titleLabel.textColor = [UIColor whiteColor];
            self.messageLabel.textColor = [UIColor whiteColor];
            self.backgroundColor = [UIColor blackColor];
        }
        else if(backgroundStyle == PCIBackgroundStyleLightBlurred) {
            self.titleLabel.textColor = [UIColor blackColor];
            self.messageLabel.textColor = [UIColor blackColor];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterialLight]];
            blurEffectView.translatesAutoresizingMaskIntoConstraints = NO;
            [self insertSubview:blurEffectView atIndex:0];
            [NSLayoutConstraint activateConstraints:@[
                [blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                [blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                [blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor],
                [blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            ]];
        }
        else {
            self.titleLabel.textColor = [UIColor whiteColor];
            self.messageLabel.textColor = [UIColor whiteColor];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterialDark]];
            blurEffectView.translatesAutoresizingMaskIntoConstraints = NO;
            [self insertSubview:blurEffectView atIndex:0];
            [NSLayoutConstraint activateConstraints:@[
                [blurEffectView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                [blurEffectView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                [blurEffectView.topAnchor constraintEqualToAnchor:self.topAnchor],
                [blurEffectView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            ]];
        }
    }
    return self;
}
- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.widthAnchor constraintGreaterThanOrEqualToConstant:250],
        [self.widthAnchor constraintLessThanOrEqualToAnchor:self.superview.widthAnchor constant:-20],
        [self.titleContainerView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.titleContainerView.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor],
        [self.titleContainerView.bottomAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.titleContainerView.topAnchor],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.titleContainerView.trailingAnchor],
        [self.titleLabel.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor constant:-80],
        [self.iconImageView.topAnchor constraintEqualToAnchor:self.titleContainerView.topAnchor constant:0],
        [self.iconImageView.leadingAnchor constraintEqualToAnchor:self.titleContainerView.leadingAnchor],
        [self.iconImageView.trailingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor constant:-5],
        [self.messageContainerView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.messageContainerView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.messageContainerView.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor constant:-40],
        [self.messageLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:5],
        [self.messageLabel.leadingAnchor constraintEqualToAnchor:self.messageContainerView.leadingAnchor],
        [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.messageContainerView.trailingAnchor],
        [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor],
    ]];
}
- (void)updateConstraints {
    [super updateConstraints];
    [self setupConstraints];
}
- (void)presentContent:(BOOL)animated {
    if(animated) {
        self.titleContainerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 12);
        self.messageContainerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 12);
        self.messageContainerView.alpha = 0.0f;
        [UIView animateWithDuration:0.4f delay:0.8f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.messageContainerView.alpha = 1.0f;
            self.messageContainerView.transform = CGAffineTransformIdentity;
            self.titleContainerView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    [self.contentView layoutIfNeeded];
}
@end