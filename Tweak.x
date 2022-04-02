#import "Tweak.h"

%hook NCNotificationShortLookView
%property (nonatomic, strong) UIView *indicatorView;
- (void)didMoveToWindow {
    %orig;
    for(UIView *subview in self.subviews) {
        if(subview == self.indicatorView) continue;
        [subview removeFromSuperview];
    }
    if(!self.indicatorView) {
        self.indicatorView = [[PCIView alloc] initWithIcon:self.icons[0] title:self.primaryText subtitle:self.primarySubtitleText message:self.secondaryText];
        self.indicatorView.backgroundColor = UIColor.whiteColor;
        self.indicatorView.clipsToBounds = YES;
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        self.indicatorView.layer.cornerRadius = 45;
        [self addSubview:self.indicatorView];
        [NSLayoutConstraint activateConstraints:@[
            [self.indicatorView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [self.indicatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:55],
            [self.indicatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-55],
            [self.indicatorView.heightAnchor constraintEqualToConstant:100],
        ]];
    }
}
%end