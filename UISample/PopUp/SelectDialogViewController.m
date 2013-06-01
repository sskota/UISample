//
//  RadioViewController.m
//  UISample
//

#import "SelectDialogViewController.h"

@interface SelectDialogViewController ()

@property (assign, nonatomic) BOOL isPhone;
@property (retain, atomic) UITableView *dialogTable;

@end

@implementation SelectDialogViewController

@synthesize dialogTable;
@synthesize dialogArray;
@synthesize titleText;
@synthesize cancelText;
@synthesize selectedIndex;
@synthesize isPhone;

#pragma mark -- Lifecycle

- (id)init
{
	self = [super init];
	if (self) {
		// Custom initialization
		self.isPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	CGRect popUpRect = [self.view bounds];

	// デバイスごとにサイズを設定
	if (self.isPhone) {
		CGFloat width = popUpRect.size.width * POPUP_DIALOG_WIDTH_PERCENT_IPHONE;
		CGFloat height = popUpRect.size.height * POPUP_DIALOG_HEIGHT_PERCENT_IPHONE;
		CGFloat originX = (popUpRect.size.width / 2) - (width / 2);
		CGFloat originY = (popUpRect.size.height / 2) - (height / 2);
		popUpRect = CGRectMake(originX, originY, width, height);
	}
	else {
		popUpRect = CGRectMake(0, 0, POPUP_DIALOG_WIDTH_IPAD, POPUP_DIALOG_HEIGHT_IPAD);
	}

	UIView *popUpView = [[UIView alloc] init];
	[popUpView setFrame:popUpRect];
	[popUpView setBackgroundColor:[UIColor whiteColor]];

	// iPhoneの場合は影をつける
	if (self.isPhone) {
		[popUpView.layer setCornerRadius:5];
		[popUpView.layer setShadowOpacity:0.5];
		[popUpView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
	}
	[popUpView setClipsToBounds:NO];

	CGFloat xOffset = 0;
	CGFloat yOffset = 0;

	// タイトルラベル背景を設定
	CGRect titleRect = CGRectMake(xOffset, yOffset, popUpRect.size.width, POPUP_HEADER_HEIGHT);
	UIView *titleView = [[UIView alloc] initWithFrame:titleRect];
	[titleView setBackgroundColor:[UIColor blackColor]];
	{
		CGFloat labelWidth = popUpRect.size.width * POPUP_CANCEL_BUTTON_WIDTH_PERCENT;
		xOffset = (popUpRect.size.width / 2) - (labelWidth / 2);

		CGRect labelRect = CGRectMake(xOffset, yOffset, labelWidth, POPUP_HEADER_HEIGHT);
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:labelRect];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setText:self.titleText];
		[titleLabel setTextColor:[UIColor whiteColor]];
		[titleLabel setTextAlignment:NSTextAlignmentCenter];
		[titleLabel setFont:[UIFont boldSystemFontOfSize:[UIFont buttonFontSize]]];
		
		[titleView addSubview:titleLabel];
	}
	
	[popUpView addSubview:titleView];

	xOffset = 0;
	yOffset = titleRect.size.height;
	CGFloat tableWidth = popUpRect.size.width;
	CGFloat tableHeight = (popUpRect.size.height - yOffset) - POPUP_FOOTER_HEIGHT;

	// テーブルを設定
	CGRect tableRect = CGRectMake(xOffset, yOffset, tableWidth, tableHeight);
	self.dialogTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
	[self.dialogTable setDelegate:self];
	[self.dialogTable setDataSource:self];
	[self.dialogTable setBackgroundColor:[UIColor whiteColor]];
	[self.dialogTable setBounces:NO];
	[popUpView addSubview:self.dialogTable];

	xOffset = 0;
	yOffset = yOffset + tableRect.size.height;
	CGFloat lineWidth = popUpRect.size.width;
	CGFloat lineHeight = POPUP_FOOTER_LINE_HEIGHT;

	// 区切り線を設定
	CGRect lineRect = CGRectMake(xOffset, yOffset, lineWidth, lineHeight);
	UIView *lineView = [[UIView alloc] initWithFrame:lineRect];
	[lineView setBackgroundColor:[UIColor grayColor]];
	[popUpView addSubview:lineView];

	CGFloat cancelWidth = popUpRect.size.width * POPUP_CANCEL_BUTTON_WIDTH_PERCENT;
	CGFloat cancelHeight = POPUP_CANCEL_BUTTON_HEIGHT;
	xOffset = (popUpRect.size.width / 2) - (cancelWidth / 2);
	yOffset = yOffset + (POPUP_FOOTER_HEIGHT / 2) - (POPUP_CANCEL_BUTTON_HEIGHT / 2);

	// キャンセルボタンを設定
	CGRect cancelRect = CGRectMake(xOffset, yOffset, cancelWidth, cancelHeight);
	UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[cancelButton setFrame:cancelRect];
	[cancelButton addTarget:self action:@selector(didSelectCancel:) forControlEvents:UIControlEventTouchDown];
	[cancelButton setTitle:self.cancelText forState:UIControlStateNormal];
	[popUpView addSubview:cancelButton];

	[self.view addSubview:popUpView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

	NSIndexPath *selection = [self.dialogTable indexPathForSelectedRow];
	if (selection) {
		[self.dialogTable deselectRowAtIndexPath:selection animated:YES];
	}

	[self.dialogTable reloadData];
}

- (void)viewDidAppear:(BOOL)animated {

	[super viewDidAppear:animated];

	[self.dialogTable flashScrollIndicators];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -- Action

- (void)didSelectDialogIndexPath:(NSIndexPath *)indexPath
{
	// 選択したインデックスを通知する
	[self.delegate didSelectDialogIndexPath:indexPath];
}

- (void)didSelectCancel:(id)sender
{
	// キャンセルを通知する
	[self.delegate didSelectCancelButton:nil];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dialogArray count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *tableId = [NSString stringWithFormat:@"cell%ld-%ld",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell	*cell = [self.dialogTable dequeueReusableCellWithIdentifier:tableId];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableId];
    }

	cell.textLabel.text = [self.dialogArray objectAtIndex:indexPath.row];

	// 選択済みインデックスにチェックを付ける
	if (self.selectedIndex == indexPath.row) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
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
	// 選択したセルにチェックを入れる
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;

	[self didSelectDialogIndexPath:indexPath];
}

#pragma mark -- UIViewControllerDelegate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end

@implementation UIViewController (SelectDialog)

- (BOOL)isExistSubView:(UIView *)view
{
	BOOL isExist = NO;
	for (UIView *subview in self.view.subviews) {
		if (view == subview) {
			isExist = YES;
			break;
		}
	}

	return isExist;
}

- (void)presentDialogViewController:(UIViewController *)controller animated:(BOOL)animated
{
	[controller.view setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];

	if ([self isExistSubView:controller.view]) {
		[self.view bringSubviewToFront:controller.view];
	} else {
		[self.view addSubview:controller.view];
	}

	CGRect viewFrame = self.view.frame;
	CGRect contFrame = controller.view.frame;

	contFrame.origin.y = viewFrame.size.height;
	controller.view.frame = contFrame;
	contFrame.origin.y = viewFrame.size.height - contFrame.size.height;

	UIColor *backColor = [UIColor colorWithWhite:0.0 alpha:0.3];

	if (animated) {
		[UIView animateWithDuration:0.5
						 animations:^{[controller.view setFrame:contFrame];}
						 completion:^(BOOL finished) {
							 [UIView animateWithDuration:0.2
											  animations:^{[controller.view setBackgroundColor:backColor];
							 }];
						 }];
	} else {
		[controller.view setFrame:contFrame];
	}
}

- (void)dismissDialogViewController:(UIViewController *)controller animated:(BOOL)animated
{
	if (![self isExistSubView:controller.view]) {
		return;
	}

	CGRect viewFrame = self.view.frame;
	CGRect contFrame = controller.view.frame;
	
	contFrame.origin.y = viewFrame.size.height;

	UIColor *backColor = [UIColor colorWithWhite:0.0 alpha:0.0];

	if (animated) {
		[UIView animateWithDuration:0.2
						 animations:^{[controller.view setBackgroundColor:backColor];}
						 completion:^(BOOL finished) {
							 [UIView animateWithDuration:0.5
											  animations:^{[controller.view setFrame:contFrame];}
											  completion:^(BOOL finished) {
												  [controller.view removeFromSuperview];
											  }];
						 }];
	} else {
		[controller.view removeFromSuperview];
	}
}

@end
