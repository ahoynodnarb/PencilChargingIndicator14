#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PCIBackgroundStyle) {
    PCIBackgroundStyleLight,
    PCIBackgroundStyleDark,
    PCIBackgroundStyleLightBlurred,
    PCIBackgroundStyleDarkBlurred,
};
@interface PCINotificationView : UIView
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *titleContainerView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, assign) unsigned long backgroundStyle;
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)title message:(NSString *)message backgroundStyle:(unsigned long)backgroundStyle;
- (void)presentContent:(BOOL)animated;
@end