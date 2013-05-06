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

@synthesize radioViewController;

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
		[self setTitle:NSLocalizedString(@"TABBAR_POPUP", @"")];
		[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	}

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	[self.navigationController setNavigationBarHidden:NO animated:YES];

	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];

	// Viewの設定
	[self.view setBounds:screenRect];
	[self.view setBackgroundColor:[UIColor whiteColor]];

	// テーブルデータを作成
	mainArray = [[NSMutableArray alloc] initWithCapacity:0];
	[mainArray addObject:NSLocalizedString(@"POPUP_SINGLE_SELECT_POPUP", @"")];

	// テーブルを設定
	CGRect viewSize = [self.view bounds];
	CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
	CGRect tableRect = CGRectMake(0, statusBarHeight, viewSize.size.width, viewSize.size.height);
	mainTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
	[mainTable setDelegate:self];
	[mainTable setDataSource:self];
	[mainTable setBackgroundColor:[UIColor whiteColor]];

	[self.view addSubview:mainTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

	// テーブルの選択を外す
	[self deselectRow];
}

- (void)viewDidAppear:(BOOL)animated {

	[super viewDidAppear:animated];

	[self.mainTable flashScrollIndicators];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showRadioPopUp
{
	// テストデータ作成
	NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:0];
	[testArray addObject:@"0"];
	[testArray addObject:@"1"];
	[testArray addObject:@"2"];
	[testArray addObject:@"3"];
	[testArray addObject:@"4"];
	[testArray addObject:@"5"];
	[testArray addObject:@"6"];
	[testArray addObject:@"7"];
	[testArray addObject:@"8"];
	[testArray addObject:@"9"];
	[testArray addObject:@"10"];

	// タイトルとキャンセルボタンテキスト
	NSString *titleText = NSLocalizedString(@"POPUP_SINGLE_SELECT_POPUP", @"");
	NSString *cancelText = NSLocalizedString(@"BUTTON_CANCEL", @"");

	// Viewの初期設定
	self.radioViewController = [[RadioViewController alloc] init];
	[self.radioViewController setRadioArray:testArray];
	[self.radioViewController setTitleText:titleText];
	[self.radioViewController setCancelText:cancelText];
	[self.radioViewController setSelectedIndex:-1];
	[self.radioViewController setDelegate:self];
	[self.tabBarController presentDialogViewController:radioViewController animated:YES];

	// テーブルの選択を外す
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
	// セットされたデータソース分の行を用意する
	return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Identifierをユニークに設定する
	NSString *tableId = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell	*tableCell = [mainTable dequeueReusableCellWithIdentifier:tableId];

    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableId];
    }

	// テキストを設定する
	tableCell.textLabel.text = [mainArray objectAtIndex:indexPath.row];

    return tableCell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 各行ごとに処理を分ける
	if (indexPath.row == 0) {
		[self showRadioPopUp];
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
	// 回転サポート
	return YES;
}

#pragma mark -- RadioViewDelegate

- (void)didSelectDialogIndexPath:(NSIndexPath *)indexPath
{
	[self.tabBarController dismissDialogViewController:radioViewController animated:YES];
}

- (void)didSelectCancelButton:(id)sender
{
	[self.tabBarController dismissDialogViewController:radioViewController animated:YES];
}

@end