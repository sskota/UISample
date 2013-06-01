//
//  MainViewController.m
//  UISample
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
		[self setTitle:NSLocalizedString(@"TABBAR_HOME", @"")];
		[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	CGRect viewSize = [self.view bounds];
	
	CGFloat width = TITLE_LABEL_WIDTH;
	CGFloat height = TITLE_LABEL_HEIGHT;
	CGFloat originX = (viewSize.size.width / 2) - (width / 2);
	CGFloat originY = (viewSize.size.height / 2) - (height / 2);
	
	UITextView *centerLabel = [[UITextView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
	[centerLabel setBackgroundColor:[UIColor clearColor]];
	[centerLabel setText:NSLocalizedString(@"MAIN_TEXT", @"")];
	[centerLabel setTextColor:[UIColor whiteColor]];
	[centerLabel setTextAlignment:NSTextAlignmentCenter];
	[centerLabel setFont:[UIFont boldSystemFontOfSize:[UIFont buttonFontSize]]];

	[self.view addSubview:centerLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -- UIViewControllerDelegate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
