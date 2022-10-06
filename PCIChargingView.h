#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "PCINotificationView.h"

@interface _UIBatteryView : UIView
@property (assign,nonatomic) long long iconSize;
@property (assign,nonatomic) long long chargingState;
@property (assign,nonatomic) BOOL saverModeActive;
@property (assign,nonatomic) double chargePercent;
@property (nonatomic,copy) UIColor *fillColor;
@property (nonatomic,copy) UIColor *bodyColor;
@property (nonatomic,copy) UIColor *pinColor;
@property (nonatomic,copy) UIColor *boltColor;
@end
@interface _UIStatusBarBatteryItem
@property (nonatomic,retain) _UIBatteryView *batteryView;
-(id)initWithIdentifier:(id)arg1 statusBar:(id)arg2;
@end
@interface PCIChargingView : PCINotificationView
@property (nonatomic, strong) _UIBatteryView *batteryView;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message backgroundStyle:(unsigned long)backgroundStyle;
@end