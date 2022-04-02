#import "PCIView.h"

@interface UIView ()
- (id)_viewControllerForAncestor;
@end

@interface NCNotificationShortLookView : UIView
@property (nonatomic, strong) PCIView *indicatorView;
@property (nonatomic, copy) NSString *primaryText;
@property (nonatomic, copy) NSString *primarySubtitleText;
@property (nonatomic, copy) NSString *secondaryText;
@property (nonatomic, copy) NSArray *icons;
@end