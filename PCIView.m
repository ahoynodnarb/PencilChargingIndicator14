#import "PCIView.h"

@implementation PCIView
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)title subtitle:(NSString *)subtitle message:(NSString *)message {
    if (self = [super init]) {
        icon = [UIImage imageWithCGImage:[icon CGImage] scale:1.8 orientation:(icon.imageOrientation)];
        self.contentView = [[UIView alloc] init];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.contentView];
        self.iconImageView = [[UIImageView alloc] initWithImage:icon];
        self.iconImageView.clipsToBounds = NO;
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.iconImageView];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = title;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.titleLabel];
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.text = message;
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.messageLabel.textColor = UIColor.blackColor;
        self.messageLabel.font = [UIFont systemFontOfSize:18];
        self.messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.messageLabel];
        [NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
            [self.iconImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:2],
            [self.iconImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.iconImageView.trailingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor constant:-5],
            [self.messageLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
            [self.messageLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
            [self.messageLabel.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor],
            [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [self.contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
            [self.contentView.topAnchor constraintEqualToAnchor:self.iconImageView.topAnchor],
            [self.contentView.bottomAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor],
        ]];
        [self.contentView layoutIfNeeded];
    }
    return self;
}
@end