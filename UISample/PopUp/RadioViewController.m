//
//  RadioViewController.m
//  UISample
//

#import "RadioViewController.h"

@interface RadioViewController ()

@end

@implementation RadioViewController

@synthesize popUpView;
@synthesize radioTable;
@synthesize radioArray;
@synthesize titleLabel;
@synthesize titleText;
@synthesize cancelText;
@synthesize cancelButton;
@synthesize selectedIndex;

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

	// 透明ビュー全体をスクリーンサイズに合わせて設定
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	[self.view setBounds:screenRect];

	// ポップアップ本体を描画
	popUpView = [[UIView alloc] init];
	[popUpView.layer setBorderColor:[[UIColor grayColor] CGColor]];
	[popUpView.layer setBorderWidth:1.0];
	[popUpView.layer setCornerRadius:5];
	//[popUpView.layer setShadowOpacity:0.5];
	//[popUpView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
	[popUpView setClipsToBounds:YES];

	CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
	CGRect popUpRect;

	// デバイスごとにサイズを変動させる
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		// for iPhone
		CGFloat width = screenRect.size.width * 0.9;
		CGFloat height = screenRect.size.height * 0.9;
		CGFloat originX = (screenRect.size.width / 2) - (width / 2);
		CGFloat originY = (screenRect.size.height / 2) - (height / 2) + statusBarHeight;
		popUpRect = CGRectMake(originX, originY, width, height);
	}
	else {
		// for iPad
		CGFloat width = screenRect.size.width * 0.7;
		CGFloat height = screenRect.size.height * 0.7;
		CGFloat originX = (screenRect.size.width / 2) - (width / 2);
		CGFloat originY = (screenRect.size.height / 2) - (height / 2) + statusBarHeight;
		popUpRect = CGRectMake(originX, originY, width, height);
	}

	[popUpView setFrame:popUpRect];
	[popUpView setBackgroundColor:[UIColor whiteColor]];
	
	CGRect viewSize = [popUpView bounds];

	// タイトルエリアを描画
	CGFloat titleYOffset = 0;
	CGRect titleRect = CGRectMake(0, titleYOffset, viewSize.size.width, 45);
	titleLabel = [[UILabel alloc] initWithFrame:titleRect];
	[titleLabel setBackgroundColor:[UIColor blackColor]];
	[titleLabel setText:self.titleText];
	[titleLabel setTextColor:[UIColor whiteColor]];
	[titleLabel setTextAlignment:NSTextAlignmentCenter];
	[titleLabel setFont:[UIFont boldSystemFontOfSize:[UIFont buttonFontSize]]];
	[popUpView addSubview:titleLabel];

	// テーブルエリアを描画
	CGFloat tableYOffset = titleRect.size.height;
	CGRect tableRect = CGRectMake(0, tableYOffset, viewSize.size.width, viewSize.size.height - 100);
	radioTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
	[radioTable setDelegate:self];
	[radioTable setDataSource:self];
	[radioTable setBackgroundColor:[UIColor whiteColor]];
	[radioTable setBounces:NO];
	[popUpView addSubview:radioTable];

	// セパレート線を描画
	CGFloat lineYOffset = titleRect.size.height + tableRect.size.height;
	CGRect lineRect = CGRectMake(0, lineYOffset, viewSize.size.width, 0.5);
	UIView *lineView = [[UIView alloc] initWithFrame:lineRect];
	[lineView setBackgroundColor:[UIColor grayColor]];
	[popUpView addSubview:lineView];

	// キャンセルボタンを描画
	CGFloat cancelWidth = viewSize.size.width * 0.7;
	CGFloat cancelYOffset = titleRect.size.height + tableRect.size.height + 9;
	CGFloat cancelXOffset = (viewSize.size.width / 2) - (cancelWidth / 2);
	CGRect cancelRect = CGRectMake(cancelXOffset, cancelYOffset, cancelWidth, 40);
	cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[cancelButton setFrame:cancelRect];
	[cancelButton addTarget:self action:@selector(didSelectCancel:) forControlEvents:UIControlEventTouchDown];
	[cancelButton setTitle:self.cancelText forState:UIControlStateNormal];
	[popUpView addSubview:cancelButton];

	[self.view addSubview:popUpView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectCancel:(id)sender
{
	// キャンセルを通知する
	[self.delegate didSelectCancelButton:nil];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// セットされたデータソース分の行を用意する
	return [radioArray count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Identifierをユニークに設定する
	NSString *tableId = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell	*cell = [radioTable dequeueReusableCellWithIdentifier:tableId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableId];
    }

	// テキストを設定する
	cell.textLabel.text = [radioArray objectAtIndex:indexPath.row];

	// 選択済みインデックスにチェックを付ける
	if (selectedIndex == indexPath.row) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}

    return cell;
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 各行の高さを設定する
	return 45;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 選択したセルにチェックを入れる(外す)
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}

	// 選択したインデックスを通知する
	[self.delegate didSelectDialogIndexPath:indexPath];
}

#pragma mark -- UIViewControllerDelegate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// 回転サポート
	return YES;
}

@end
