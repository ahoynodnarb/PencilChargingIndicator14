@interface PCIView : UIView
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *message;
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)primaryText subtitle:(NSString *)subtitle message:(NSString *)message;
@end