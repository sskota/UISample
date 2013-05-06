//
//  PopUpViewController.h
//  UISample
//

#import <UIKit/UIKit.h>
#import "RadioViewController.h"

@class RadioViewController;

@interface PopUpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RadioViewDelegate>

@property (retain, atomic) UITableView *mainTable;
@property (retain, atomic) NSMutableArray *mainArray;

@property (strong, nonatomic) RadioViewController *radioViewController;

@end
