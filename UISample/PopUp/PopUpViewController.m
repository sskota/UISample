//
//  PopUpViewController.m
//  UISample
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

@synthesize mainTable;
@synthesize mainArray;
@synthesize selectDialogViewController;
@synthesize isPhone;

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
		isPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;

		[self setTitle:NSLocalizedString(@"TABBAR_POPUP", @"")];
		[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	}

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.navigationController setNavigationBarHidden:NO animated:NO];

	// テーブルデータを作成
	mainArray = [[NSMutableArray alloc] initWithCapacity:0];
	[mainArray addObject:NSLocalizedString(@"POPUP_SINGLE_SELECT_POPUP", @"")];

	// テーブルを設定
	CGRect viewSize = [self.view bounds];
	CGRect tableRect = CGRectMake(0, 0, viewSize.size.width, viewSize.size.height);
	mainTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
	[mainTable setDelegate:self];
	[mainTable setDataSource:self];
	[mainTable setBackgroundColor:[UIColor whiteColor]];

	[self.view addSubview:mainTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

	[self deselectRow];
}

- (void)viewDidAppear:(BOOL)animated {

	[super viewDidAppear:animated];

	[self.mainTable flashScrollIndicators];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)showSingleSelectDialog
{
	// テストデータ作成
	NSArray *dialogArray = [self getTestDialogData];

	// タイトルとキャンセルボタンテキスト
	NSString *titleText = NSLocalizedString(@"POPUP_SINGLE_SELECT_POPUP", @"");
	NSString *cancelText = NSLocalizedString(@"BUTTON_CANCEL", @"");

	SelectDialogViewController *controller = [[SelectDialogViewController alloc] init];
	[controller setDialogArray:dialogArray];
	[controller setTitleText:titleText];
	[controller setCancelText:cancelText];
	[controller setSelectedIndex:-1];
	[controller setDelegate:self];

	self.selectDialogViewController = controller;

	if (isPhone) {
		[self.tabBarController presentDialogViewController:self.selectDialogViewController animated:YES];
	}
	else {
		self.selectDialogViewController.modalPresentationStyle = UIModalPresentationFormSheet;
		//self.selectDialogViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self presentViewController:self.selectDialogViewController animated:YES completion:nil];
	}

	[self deselectRow];
}

- (void)deselectRow
{
	NSIndexPath *selection = [mainTable indexPathForSelectedRow];
	if(selection){
		[mainTable deselectRowAtIndexPath:selection animated:YES];
	}

	[mainTable reloadData];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *tableId = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell	*tableCell = [mainTable dequeueReusableCellWithIdentifier:tableId];

    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableId];
    }

	tableCell.textLabel.text = [mainArray objectAtIndex:indexPath.row];

    return tableCell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 各行ごとに処理を分ける
	if (indexPath.row == 0) {
		[self showSingleSelectDialog];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	// ヘッダーは使わないので高さ0
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	// フッターは使わないので高さ0
	return 0;
}

#pragma mark -- UIViewControllerDelegate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -- SelectDialogViewDelegate

- (void)didSelectDialogIndexPath:(NSIndexPath *)indexPath
{
	if (isPhone) {
		[self.tabBarController dismissDialogViewController:selectDialogViewController animated:YES];
	}
	else {
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}

- (void)didSelectCancelButton:(id)sender
{
	if (isPhone) {
		[self.tabBarController dismissDialogViewController:selectDialogViewController animated:YES];
	}
	else {
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}

#pragma mark -- TestData

- (NSArray *)getTestDialogData
{
	// テストデータ作成
	NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:0];
	[testArray addObject:@"Select 0"];
	[testArray addObject:@"Select 1"];
	[testArray addObject:@"Select 2"];
	[testArray addObject:@"Select 3"];
	[testArray addObject:@"Select 4"];
	[testArray addObject:@"Select 5"];
	[testArray addObject:@"Select 6"];
	[testArray addObject:@"Select 7"];
	[testArray addObject:@"Select 8"];
	[testArray addObject:@"Select 9"];
	[testArray addObject:@"Select 10"];

	return testArray;
}

@end