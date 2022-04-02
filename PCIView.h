@interface PCIView : UIView
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)primaryText subtitle:(NSString *)subtitle message:(NSString *)message;
@end