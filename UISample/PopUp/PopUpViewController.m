//
//  PopUpViewController.m
//  UISample
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@property (retain, atomic) UITableView *mainTable;
@property (retain, atomic) NSMutableArray *mainArray;
@property (strong, nonatomic) SelectDialogViewController *selectDialogViewController;

@end

@implementation PopUpViewController

@synthesize mainTable;
@synthesize mainArray;
@synthesize selectDialogViewController;

#pragma mark -- Lifecycle

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
		[self setTitle:NSLocalizedString(@"TABBAR_POPUP", @"")];
	}

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// テーブルデータを作成
	self.mainArray = [[NSMutableArray alloc] initWithCapacity:0];
	[self.mainArray addObject:NSLocalizedString(@"POPUP_SINGLE_SELECT_POPUP", @"")];

	// テーブルを設定
	CGRect viewSize = [self.view bounds];
	CGRect tableRect = CGRectMake(0, 0, viewSize.size.width, viewSize.size.height);
	self.mainTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
	[self.mainTable setDelegate:self];
	[self.mainTable setDataSource:self];

	[self.view addSubview:self.mainTable];
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

	if (self.isPhone) {

		self.selectDialogViewController = controller;
		[self.tabBarController presentDialogViewController:self.selectDialogViewController animated:YES];
	}
	else {
		controller.modalPresentationStyle = UIModalPresentationFormSheet;
		//controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		[self presentViewController:controller animated:YES completion:nil];
	}
}

- (void)deselectRow
{
	NSIndexPath *selection = [self.mainTable indexPathForSelectedRow];
	if(selection){
		[self.mainTable deselectRowAtIndexPath:selection animated:YES];
	}

	[self.mainTable reloadData];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *tableId = [NSString stringWithFormat:@"cell%ld-%ld",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell	*tableCell = [self.mainTable dequeueReusableCellWithIdentifier:tableId];

    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableId];
    }

	tableCell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];

    return tableCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return NSLocalizedString(@"ALERT_GROUP_CUSTOM", @"");
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 各行ごとに処理を分ける
	if (indexPath.row == 0) {
		[self showSingleSelectDialog];
	}
}

#pragma mark -- SelectDialogViewDelegate

- (void)didSelectDialogIndexPath:(NSIndexPath *)indexPath
{
	if (self.isPhone) {
		[self.tabBarController dismissDialogViewController:selectDialogViewController animated:YES];
	}
	else {
		[self dismissViewControllerAnimated:YES completion:nil];
	}

	[self deselectRow];
}

- (void)didSelectCancelButton:(id)sender
{
	if (self.isPhone) {
		[self.tabBarController dismissDialogViewController:selectDialogViewController animated:YES];
	}
	else {
		[self dismissViewControllerAnimated:YES completion:nil];
	}

	[self deselectRow];
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