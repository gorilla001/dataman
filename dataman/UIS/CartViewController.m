
#import "CartViewController.h"
#import "LoginViewController.h"
#import "NewAppCell.h"

#define CELL_HEIGHT   60
#define BOTTOM_HEIGHT 60
#define FREIGHT 10
#define PRICE_LIMIT 49

@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) AddressInfo *address;

@property (nonatomic, strong)  NSString *markMessage;

//@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UITextField *nameLabel;
@property (nonatomic, strong) UITextField *textField;


@property (nonatomic) UIEdgeInsets separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;

@end

@implementation CartViewController


- (instancetype)init
{
    if (self = [super init]) {
        [self layoutNavigationBar];
        _listData = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)layoutNavigationBar
{
    self.title = @"购物车";
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.listView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    
    return _listData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return CELL_HEIGHT;
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"APPCELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [tableView setSeparatorColor:[UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:1.0]];
    
    
    return cell;
}


#pragma mark - Getter
- (UITableView *)listView
{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-110) style:UITableViewStylePlain];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = TABLE_COLOR;
        _listView.tableFooterView = [UIView new];
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
        
    }
    return _listView;
}
@end
