//
//  PopUpViewController.h
//  UISample
//

#import <UIKit/UIKit.h>
#import "SelectDialogViewController.h"
#import "BaseViewController.h"

#define TABLE_SECTION_DEFAULT 0
#define TABLE_SECTION_CUSTOM 1

@class SelectDialogViewController;
@class BaseViewController;

@interface PopUpViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, SelectDialogViewDelegate>

@end
