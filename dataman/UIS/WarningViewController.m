#import "WarningViewController.h"
#import "ItemCell.h"
#import <MJRefresh.h>
#import "ItemDetailViewController.h"
#import "LoginViewController.h"

#define ITEMWIDTH (290/2.0)
#define ITEMHEIGHT 200
#define HEADERHEIGHT  210

@interface WarningViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation WarningViewController


- (instancetype)init
{
    if (self = [super init]) {
        [self layoutNavigationBar];
        _listData = [NSMutableArray arrayWithCapacity:5];
        
    }
    return self;
}

- (void)layoutNavigationBar
{
    self.title = @"告警";
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.listView];
    [self.listView.header beginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CollectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return _listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ITEMCELL";
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [tableView setSeparatorColor:[UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:1.0]];
    
    [cell configItemCell:_listData[indexPath.row]];
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;
    
}

#pragma mark - Getter
- (void)pullToRefresh
{
    [HTTPManager getApps:^(id response) {
        
        [self.listView.header endRefreshing];
        self.listView.footer.hidden = NO;
        
        
        [_listData removeAllObjects];
        [_listData addObjectsFromArray:response[@"data"][@"App"]];
        
        [self.listView reloadData];
        
        DBLog(@"%@", _listData);
        
        if ([response count] <20){
            self.listView.footer.hidden = YES;
        }
    } failure:^(NSError *err) {
        
        LoginViewController *controller = [[LoginViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
        [self.listView.header endRefreshing];
    }];
}

- (void)upToRefresh
{
    [self.listView.header endRefreshing];
}



#pragma mark - Getter
- (UITableView *)listView
{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT-60) style:UITableViewStylePlain];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.tableFooterView = [UIView new];
        _listView.bounces = YES;
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
        _listView.backgroundColor = RGB_COLOR(242, 242, 242);
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
        header.lastUpdatedTimeLabel.hidden = YES;
        _listView.header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upToRefresh)];
        _listView.footer = footer;
        _listView.footer.hidden = YES;
    }
    return _listView;
}
@end