#import "PCINotificationView.h"

@implementation PCINotificationView
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)title message:(NSString *)message {
    if (self = [super init]) {
        self.icon = [UIImage imageWithCGImage:[icon CGImage] scale:2 orientation:(icon.imageOrientation)];
        self.title = title;
        self.message = message;
        self.contentView = [[UIView alloc] init];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.contentView];
        self.titleContainerView = [[UIView alloc] init];
        self.titleContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.titleContainerView];
        self.messageContainerView = [[UIView alloc] init];
        self.messageContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.messageContainerView];
        self.iconImageView = [[UIImageView alloc] initWithImage:self.icon];
        self.iconImageView.clipsToBounds = NO;
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.titleContainerView addSubview:self.iconImageView];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = self.title;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.titleContainerView addSubview:self.titleLabel];
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.text = self.message;
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.messageLabel.textColor = UIColor.blackColor;
        self.messageLabel.font = [UIFont systemFontOfSize:15];
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.messageContainerView addSubview:self.messageLabel];
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
        [self.titleLabel.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor constant:-80],
        [self.iconImageView.topAnchor constraintEqualToAnchor:self.titleContainerView.topAnchor constant:0],
        [self.iconImageView.leadingAnchor constraintEqualToAnchor:self.titleContainerView.leadingAnchor],
        [self.iconImageView.trailingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor constant:-5],
        [self.messageContainerView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:5],
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
- (void)presentContentAnimated:(BOOL)animated {
    if(animated) {
        self.titleContainerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 10);
        self.messageLabel.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 12);
        self.messageLabel.alpha = 0.0f;
        [UIView animateWithDuration:0.4f delay:0.8f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.messageLabel.alpha = 1.0f;
            self.messageLabel.transform = CGAffineTransformIdentity;
            self.titleContainerView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    [self.contentView layoutIfNeeded];
}
@end