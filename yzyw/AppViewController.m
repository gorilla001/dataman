
#import "AppViewController.h"
#import "LoginViewController.h"
#import "AppDetailViewController.h"
#import <MJRefresh.h>

#define CELL_HEIGHT   222/2.0
#define BOTTOM_HEIGHT 60
#define FREIGHT 10
#define PRICE_LIMIT 49

@interface AppViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic) UIEdgeInsets separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;

@end

@implementation AppViewController


- (instancetype)init
{
    if (self = [super init]) {
//        [self layoutNavigationBar];
        _listData = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

//- (void)layoutNavigationBar
//{
//    self.title = @"应用";
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.listView];
    
    [self.listView.header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if(section == 0) {
        return _listData.count;
    }else if(section == 1) {
        return 0;
    }else{
        return 2;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CELL_HEIGHT;
    }
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1 || section == 2 ) {
        return 5;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,5)];
    view.backgroundColor = RGB_COLOR(242, 242, 242);
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
           static NSString *CellIdentifier = @"BEIZHUCELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;

        cell.textLabel.font = FONT(14);
        cell.detailTextLabel.font = FONT(14);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    
        return cell;
    
}

- (void)pullToRefresh
{
    [HTTPManager getApps:^(NSMutableArray *response) {
        
        
        [self.listView.header endRefreshing];
        self.listView.footer.hidden = NO;
        
        
        [_listData removeAllObjects];
        [_listData addObjectsFromArray:response];
        
        DBLog(@"%@", _listData);
        
        [self.listView reloadData];
        
        if ([response count] <10){
            self.listView.footer.hidden = YES;
        }
    } failure:^(NSError *err) {
        [self.listView.header endRefreshing];
        DBLog(@"%@", err);
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
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = TABLE_COLOR;
        _listView.tableFooterView = [UIView new];
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
        
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
