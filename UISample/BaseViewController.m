//
//  BaseViewController.m
//  UISample
//

#import "BaseViewController.h"

@implementation BaseViewController

@synthesize isPhone;

#pragma mark -- Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		self.isPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
		
		[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	// ヘッダーの高さ
	return TABLE_HEADER_HIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	// フッターの高さ
	return TABLE_FOOTER_HIGHT;
}

#pragma mark -- UIViewControllerDelegate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
