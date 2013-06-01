//
//  RadioViewController.h
//  UISample
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define POPUP_HEADER_HEIGHT 45
#define POPUP_FOOTER_HEIGHT 50
#define POPUP_FOOTER_LINE_HEIGHT 0.5
#define POPUP_DIALOG_WIDTH_PERCENT_IPHONE 0.9
#define POPUP_DIALOG_HEIGHT_PERCENT_IPHONE 0.8
#define POPUP_DIALOG_WIDTH_IPAD 540
#define POPUP_DIALOG_HEIGHT_IPAD 620
#define POPUP_CANCEL_BUTTON_WIDTH_PERCENT 0.7
#define POPUP_CANCEL_BUTTON_HEIGHT 40

@protocol SelectDialogViewDelegate

@optional

//- (void)didFinishLaunching:(UIViewController *)controller;

@required

- (void)didSelectDialogIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectCancelButton:(id)sender;

@end

@interface SelectDialogViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, atomic) NSArray *dialogArray;
@property (retain, atomic) NSString *titleText;
@property (retain, atomic) NSString *cancelText;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) id<SelectDialogViewDelegate> delegate;

@end

@interface UIViewController (SelectDialog)

- (void)presentDialogViewController:(UIViewController *)controller animated:(BOOL)animated;
- (void)dismissDialogViewController:(UIViewController *)controller animated:(BOOL)animated;

@end