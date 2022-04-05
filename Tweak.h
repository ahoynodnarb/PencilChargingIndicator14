#import "PCINotificationView.h"
#import "PCIChargingView.h"

@interface UIView ()
- (id)_viewControllerForAncestor;
@end
@interface BBObserver : NSObject
@end
@interface BBBulletin
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *sectionID;
@property (nonatomic,copy) id acknowledgeAction;
@end
@interface BBBulletinRequest : BBBulletin
@property (nonatomic, copy) NSString *recordID;
@property (nonatomic, assign) BOOL clearable;
@property (nonatomic, assign) BOOL showsMessagePreview;
@end
@interface NCNotificationRequest : NSObject
@property (nonatomic,copy,readonly) BBBulletin *bulletin;
+ (id)notificationRequestForBulletin:(id)arg1 observer:(id)arg2 sectionInfo:(id)arg3 feed:(unsigned long long)arg4 playLightsAndSirens:(BOOL)arg5;
@end
@interface NCNotificationShortLookViewController : UIViewController
@property (nonatomic, strong) PCINotificationView *indicatorView;
@property (nonatomic, strong) NCNotificationRequest *notificationRequest;
- (id)initWithNotificationRequest:(id)arg1 revealingAdditionalContentOnPresentation:(BOOL)arg2;
- (void)updateContent;
@end
@interface NCNotificationShortLookView : UIView
@property (nonatomic, strong) NSArray *icons;
@end
@interface SBNotificationPresentableViewController : UIViewController
- (id)initWithNotificationViewController:(id)arg1;
@end
@interface BNContentViewController : UIViewController
- (void)presentPresentable:(id)arg1 withOptions:(unsigned long long)arg2 userInfo:(id)arg3;
- (void)_dismissPresentable:(id)arg1 withReason:(id)arg2 animated:(BOOL)arg3 userInfo:(id)arg4;
// - (void)presentChargingBanner;
- (void)presentChargingBanner:(NSNotification *)note;
@end

int backgroundType;