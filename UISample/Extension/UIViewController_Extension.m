//
//  UIViewController_Extension.m
//  UISample
//

#import "UIViewController_Extension.h"

@implementation UIViewController (Extension)

- (BOOL)isExistSubView:(UIView *)view
{
	BOOL isExist = NO;
	for (UIView *subview in self.view.subviews) {
		if (view == subview) {
			isExist = YES;
			break;
		}
	}

	return isExist;
}

- (void)presentDialogViewController:(UIViewController *)controller animated:(BOOL)animated
{
	if ([self isExistSubView:controller.view]) {
		[self.view bringSubviewToFront:controller.view];
	} else {
		[self.view addSubview:controller.view];
	}

	CGRect viewFrame = self.view.frame;
	CGRect controllerFrame = controller.view.frame;

	controllerFrame.origin.y = viewFrame.size.height;
	controller.view.frame = controllerFrame;
	controllerFrame.origin.y = viewFrame.size.height - controllerFrame.size.height;
	
	if (animated) {
		[UIView animateWithDuration:0.5 animations:^{controller.view.frame = controllerFrame;}];
	} else {
		controller.view.frame = controllerFrame;
	}
}

- (void)dismissDialogViewController:(UIViewController *)controller animated:(BOOL)animated
{
	if (![self isExistSubView:controller.view]) {
		return;
	}

	if (animated) {
		CGRect viewFrame = self.view.frame;
		CGRect controllerFrame = controller.view.frame;
		controllerFrame.origin.y = viewFrame.size.height;

		[UIView animateWithDuration:0.5 animations:^{controller.view.frame = controllerFrame;} completion:^(BOOL finished) {[controller.view removeFromSuperview];}];
	} else {
		[controller.view removeFromSuperview];
	}
}

@end
