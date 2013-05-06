//
//  RadioViewController.h
//  UISample
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol RadioViewDelegate

@required

-(void)didSelectDialogIndexPath:(NSIndexPath *)indexPath;
-(void)didSelectCancelButton:(id)sender;

@end

@interface RadioViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, atomic) UIView *popUpView;
@property (retain, atomic) UITableView *radioTable;
@property (retain, atomic) NSMutableArray *radioArray;
@property (retain, atomic) UILabel *titleLabel;
@property (retain, atomic) NSString *titleText;
@property (retain, atomic) UIButton *cancelButton;
@property (retain, atomic) NSString *cancelText;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (assign, nonatomic) id<RadioViewDelegate> delegate;

@end

@interface UIViewController (Extension)

- (void)presentDialogViewController:(UIViewController *)controller animated:(BOOL)animated;
- (void)dismissDialogViewController:(UIViewController *)controller animated:(BOOL)animated;

@end