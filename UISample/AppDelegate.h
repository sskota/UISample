//
//  AppDelegate.h
//  UISample
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class PopUpViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *popUpNavController;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) PopUpViewController *popUpViewController;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
