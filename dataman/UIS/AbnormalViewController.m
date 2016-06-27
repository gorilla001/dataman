#import "AbnormalViewController.h"
#import "ItemCell.h"
#import <MJRefresh.h>
#import "ItemDetailViewController.h"
#import "LoginViewController.h"

#define ITEMWIDTH (290/2.0)
#define ITEMHEIGHT 200
#define HEADERHEIGHT  210

@interface AbnormalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) NSMutableArray *appData;
@property (nonatomic, strong) NSMutableArray *statusData;
@property (nonatomic, strong) NSMutableArray *listData;

@end

@implementation AbnormalViewController


- (instancetype)init
{
    if (self = [super init]) {
        [self layoutNavigationBar];
        _listData = [NSMutableArray arrayWithCapacity:15];
        _appData = [NSMutableArray arrayWithCapacity:15];
        _statusData = [NSMutableArray arrayWithCapacity:15];
        
    }
    return self;
}

- (void)layoutNavigationBar
{
    self.title = @"异常";
    
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
        
        [_appData removeAllObjects];
        [_appData addObjectsFromArray:response[@"data"][@"App"]];
        [_appData sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES], nil]];
        
        [HTTPManager getStatus:^(id response) {
    
            
            NSMutableDictionary *status = response[@"data"];
            [_statusData removeAllObjects];
            [_statusData addObjectsFromArray:[status allValues]];
            
            [_statusData sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES], nil]];
  
            [_listData removeAllObjects];
            for (int i = 0; i < _statusData.count; i++){

                if([[_statusData objectAtIndex: i][@"status"] integerValue] == 10){
                    [_listData addObject:[_appData objectAtIndex:i]];
                }
                
            }
            
            [_listView reloadData];
            if ([_listData count] <20){
                self.listView.footer.hidden = YES;
            }

            
        } failure:^(NSError *err) {
            
            LoginViewController *controller = [[LoginViewController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            
            [self.listView.header endRefreshing];
        }];
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
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT-49) style:UITableViewStylePlain];
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