#import "PCIView.h"

@implementation PCIView
- (instancetype)initWithIcon:(UIImage *)icon title:(NSString *)title subtitle:(NSString *)subtitle message:(NSString *)message {
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
        self.subtitle = subtitle;
        self.message = message;
    }
    return self;
}
@end