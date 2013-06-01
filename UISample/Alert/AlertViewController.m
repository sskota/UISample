//
//  PopUpViewController.m
//  UISample
//

#import "AlertViewController.h"

@interface AlertViewController ()

@property (retain, atomic) UITableView *mainTable;
@property (retain, atomic) NSMutableDictionary *mainDictionaty;
@property (retain, atomic) NSMutableArray *defaultArray;
@property (retain, atomic) NSMutableArray *customArray;

@end

@implementation AlertViewController

@synthesize mainTable;
@synthesize mainDictionaty;
@synthesize defaultArray;
@synthesize customArray;

#pragma mark -- Lifecycle

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
		[self setTitle:NSLocalizedString(@"TABBAR_ALERT", @"")];
	}

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// デフォルトデータソースを作成
	self.defaultArray = [[NSMutableArray alloc] initWithCapacity:0];
	[self.defaultArray addObject:NSLocalizedString(@"ALERT_NORMAL", @"")];
	[self.defaultArray addObject:NSLocalizedString(@"ALERT_PLAIN_TEXT", @"")];
	[self.defaultArray addObject:NSLocalizedString(@"ALERT_PASSWORD", @"")];
	[self.defaultArray addObject:NSLocalizedString(@"ALERT_ID_PASSWORD", @"")];

	// カスタムデータソースを作成
	self.customArray = [[NSMutableArray alloc] initWithCapacity:0];
	[self.customArray addObject:NSLocalizedString(@"ALERT_CUSTOM_SCROLL_TEXT", @"")];

	self.mainDictionaty = [[NSMutableDictionary alloc] initWithCapacity:0];
	[self.mainDictionaty setObject:self.defaultArray forKey:KEY_DEFAULT];
	[self.mainDictionaty setObject:self.customArray forKey:KEY_CUSTOM];

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

- (void)showAlertWithStyle:(UIAlertViewStyle)style title:(NSString *)title message:(NSString *)message tag:(NSInteger)tag 
		 cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:self
										  cancelButtonTitle:cancelButtonTitle
										  otherButtonTitles:okButtonTitle, nil];

	[alert setTag:tag];
	[alert setAlertViewStyle:style];
	[alert show];
}

- (void)deselectRow
{
	NSIndexPath *selection = [mainTable indexPathForSelectedRow];
	if (selection){
		[mainTable deselectRowAtIndexPath:selection animated:YES];
	}

	[mainTable reloadData];
}

#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// アラートの内容を受け取る

	[self deselectRow];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == TABLE_SECTION_DEFAULT) {
		return [self.defaultArray count];
	}
	else if (section == TABLE_SECTION_CUSTOM) {
		return [self.customArray count];
	}
	else {
		return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *tableId = [NSString stringWithFormat:@"cell%ld-%ld",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell	*tableCell = [mainTable dequeueReusableCellWithIdentifier:tableId];

    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableId];
    }

	if (indexPath.section == TABLE_SECTION_DEFAULT) {

		NSArray *array = [self.mainDictionaty objectForKey:KEY_DEFAULT];
		tableCell.textLabel.text = [array objectAtIndex:indexPath.row];
		
	}
	else if (indexPath.section == TABLE_SECTION_CUSTOM) {

		NSArray *array = [self.mainDictionaty objectForKey:KEY_CUSTOM];
		tableCell.textLabel.text = [array objectAtIndex:indexPath.row];
		
	}
	else {
		tableCell.textLabel.text = nil;
	}

    return tableCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == TABLE_SECTION_DEFAULT) {
		return NSLocalizedString(@"ALERT_GROUP_DEFAULT", @"");
	}
	else if (section == TABLE_SECTION_CUSTOM){
		return NSLocalizedString(@"ALERT_GROUP_CUSTOM", @"");
	}
	
	return nil;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 各セクション・行ごとに処理を分ける
	if (indexPath.section == TABLE_SECTION_DEFAULT && indexPath.row == 0) {
		
		[self showAlertWithStyle:UIAlertViewStyleDefault title:NSLocalizedString(@"ALERT_NORMAL", @"") message:@"Message" tag:0 
			   cancelButtonTitle:nil okButtonTitle:NSLocalizedString(@"BUTTON_OK", @"")];
	}
	else if (indexPath.section == TABLE_SECTION_DEFAULT && indexPath.row == 1) {
		
		[self showAlertWithStyle:UIAlertViewStylePlainTextInput title:NSLocalizedString(@"ALERT_PLAIN_TEXT", @"") message:@"Message" tag:1
			   cancelButtonTitle:NSLocalizedString(@"BUTTON_CANCEL", @"") okButtonTitle:NSLocalizedString(@"BUTTON_OK", @"")];
	}
	else if (indexPath.section == TABLE_SECTION_DEFAULT && indexPath.row == 2) {
		
		[self showAlertWithStyle:UIAlertViewStyleSecureTextInput title:NSLocalizedString(@"ALERT_PASSWORD", @"") message:@"Message" tag:2
			   cancelButtonTitle:NSLocalizedString(@"BUTTON_CANCEL", @"") okButtonTitle:NSLocalizedString(@"BUTTON_OK", @"")];
	}
	else if (indexPath.section == TABLE_SECTION_DEFAULT && indexPath.row == 3) {
		
		[self showAlertWithStyle:UIAlertViewStyleLoginAndPasswordInput title:NSLocalizedString(@"ALERT_ID_PASSWORD", @"") message:@"Message" tag:3
			   cancelButtonTitle:NSLocalizedString(@"BUTTON_CANCEL", @"") okButtonTitle:NSLocalizedString(@"BUTTON_OK", @"")];
	}
}

@end