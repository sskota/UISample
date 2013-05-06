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
    // Do any additional setup after loading the view from its nib.

	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];

	// Viewの設定
	[self.view setBounds:screenRect];
	[self.view setBackgroundColor:[UIColor whiteColor]];

	// メイン文字の設定
	CGRect viewSize = [self.view bounds];
	CGFloat sizeX = 150;
	CGFloat sizeY = 100;
	CGFloat originX = (viewSize.size.width / 2) - (sizeX / 2);
	CGFloat originY = (viewSize.size.height / 2) - (sizeY / 2);
	NSString *centerText = NSLocalizedString(@"MAIN_TEXT", @"");
	UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, sizeX, sizeY)];
	[centerLabel setTextAlignment:NSTextAlignmentCenter];
	[centerLabel setText:centerText];

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
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UIViewControllerDelegate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
