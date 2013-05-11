//
//  PopUpViewController.h
//  UISample
//

#import <UIKit/UIKit.h>
#import "SelectDialogViewController.h"

@class SelectDialogViewController;

@interface PopUpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SelectDialogViewDelegate>

@property (retain, atomic) UITableView *mainTable;
@property (retain, atomic) NSMutableArray *mainArray;
@property (strong, nonatomic) SelectDialogViewController *selectDialogViewController;
@property (assign, nonatomic) BOOL isPhone;

@end
