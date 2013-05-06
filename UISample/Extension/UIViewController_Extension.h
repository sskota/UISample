//
//  UIViewController_Extension.h
//  UISample
//

#import <Foundation/Foundation.h>

@interface UIViewController (Extension)

- (void)presentDialogViewController:(UIViewController *)controller animated:(BOOL)animated;
- (void)dismissDialogViewController:(UIViewController *)controller animated:(BOOL)animated;

@end
