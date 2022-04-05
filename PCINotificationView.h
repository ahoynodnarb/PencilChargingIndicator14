@interface PCINotificationView : UIView
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *titleContainerView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)title message:(NSString *)message;
- (void)presentContentAnimated:(BOOL)animated;
@end