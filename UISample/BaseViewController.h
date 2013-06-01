//
//  BaseViewController.h
//  UISample
//

#import <UIKit/UIKit.h>

#define TABLE_HEADER_HIGHT 30
#define TABLE_FOOTER_HIGHT 0

@interface BaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) BOOL isPhone;

@end
