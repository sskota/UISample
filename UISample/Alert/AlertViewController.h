//
//  PopUpViewController.h
//  UISample
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define TABLE_SECTION_DEFAULT 0
#define TABLE_SECTION_CUSTOM 1

#define KEY_DEFAULT @"default"
#define KEY_CUSTOM @"custom"

@class BaseViewController;

@interface AlertViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@end
