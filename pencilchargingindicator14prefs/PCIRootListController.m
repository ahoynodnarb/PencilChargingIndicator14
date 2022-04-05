#import <Foundation/Foundation.h>
#import "PCIRootListController.h"

@implementation PCIRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
