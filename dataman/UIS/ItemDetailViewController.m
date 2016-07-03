
#import "ItemDetailViewController.h"
#import "LoginViewController.h"

#define HEADER_HEIGHT 64
#define BOTTOM_HEIGHT 50

@interface ItemDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSDictionary *item;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UITableView *listView;
//@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIImageView *headerView;

//@property (nonatomic, strong) UIView *footView;
//@property (nonatomic, strong) UILabel *contentLabel;


//
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
//@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) UIImageView *cImageView;

@property (nonatomic) UIEdgeInsets separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;


@end

@implementation ItemDetailViewController

//- (instancetype)initWithData:data
- (instancetype)init
{
    if (self = [super init]) {
         [self layoutNavigationBar];
    }
    return self;
}


- (void)layoutNavigationBar
{
    self.title = @"应用详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButton:)];
}

- (void)clickLeftBarButton:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WHITE_COLOR;
    
    if (_item) {
        [self configView];
    }else{
        [self getAppDetail];
    }
    
}

- (void)getAppDetail
{
    [self showLoading];
    
    [HTTPManager getApp:self.id cid: self.cid success:^(NSDictionary *response) {
        
        [self hideLoading];
        
        _item = response[@"data"];
        [HTTPManager getAppStatus:self.id cid: self.cid success:^(NSDictionary *response) {;
            _status = response[@"data"][@"status"];
        }failure:^(NSError *err) {
            _status = @"UNKNOWN";
        }];

        [self configView];
        
    } failure:^(NSError *err) {
        [self hideLoading];
        [self showFailureStatusWithTitle:@"服务器繁忙请稍候重试"];
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)configView
{
    
    [self.view addSubview:self.listView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.startButton];
    [self.bottomView addSubview:self.stopButton];
    [self.bottomView addSubview:self.deleteButton];
    
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
    
     return 10;
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


//计算一下第一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellIndentifier = @"DETAILCELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            
        }
    
        [tableView setSeparatorColor:[UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:1.0]];
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"ID";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"id"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 1:
            cell.textLabel.text = @"NAME";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"name"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 2:
            cell.textLabel.text = @"ALIAS";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"alias"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 3:
            cell.textLabel.text = @"CID";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"cid"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 4:
            cell.textLabel.text = @"CPU";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"cpus"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;

        case 5:
            cell.textLabel.text = @"MEM";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"mem"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 6:
            cell.textLabel.text = @"NETWORK";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"network"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 7:
            cell.textLabel.text = @"IMAGE";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"imageName"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 8:
            cell.textLabel.text = @"VERSION";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", _item[@"imageVersion"]];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 9:
            cell.textLabel.text = @"STATUS";
            cell.textLabel.font = FONT(16);
            cell.textLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_status];
            cell.detailTextLabel.textColor = RGB_COLOR(119, 119, 119);
            cell.detailTextLabel.font = FONT(16);
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;

        default:
            break;
    }
        return cell;
    
}


#pragma mark - Fetch data
- (void)getVegDetail
{
    [self showLoading];
    
}
- (UITableView *)listView
{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  SCREEN_WIDTH,
                                                                  SCREEN_HEIGHT-BOTTOM_HEIGHT-HEADER_HEIGHT)
                                                 style:UITableViewStylePlain];
        _listView.dataSource = self;
        _listView.delegate = self;
        _listView.backgroundColor = RGB_COLOR(242, 242, 242);
        _listView.tableFooterView = [UIView new];
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
    }
    return _listView;
}


- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.frame = CGRectMake(0, self.listView.bottom, SCREEN_WIDTH, BOTTOM_HEIGHT);
        _bottomView.backgroundColor = RED_COLOR;
    }
    return _bottomView;
}


- (UIButton *)startButton
{
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, BOTTOM_HEIGHT);
        _startButton.backgroundColor = RGB_COLOR(51, 153, 0);
        [_startButton setTitleColor: WHITE_COLOR forState:UIControlStateNormal];
        _startButton.titleLabel.font = FONT(14);
        _startButton.layer.cornerRadius = 0;
        _startButton.clipsToBounds = YES;
        [_startButton setTitle:@"启动" forState:UIControlStateNormal];
//        [_subBtn addTarget:self action:@selector(subTCGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}


- (UIButton *)stopButton
{
    if (!_stopButton) {
        _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopButton.frame = CGRectMake(self.startButton.right, 0, SCREEN_WIDTH/3, BOTTOM_HEIGHT);
        _stopButton.backgroundColor = RGB_COLOR(102, 204, 255);
        [_stopButton setTitleColor: WHITE_COLOR forState:UIControlStateNormal];
        _stopButton.titleLabel.font = FONT(14);
        _stopButton.clipsToBounds = YES;
        [_stopButton setTitle:@"停止" forState:UIControlStateNormal];
//        [_addBtn addTarget:self action:@selector(addTCGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopButton;
}


- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];

        _deleteButton.backgroundColor = RGB_COLOR(243, 95, 68);
        [_deleteButton setTitleColor: WHITE_COLOR forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = FONT(14);
        _deleteButton.layer.cornerRadius = 0;
        _deleteButton.clipsToBounds = YES;
//        [_carBtn addTarget:self action:@selector(addShopCar:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.frame = CGRectMake(self.stopButton.right, 0, SCREEN_WIDTH/3, BOTTOM_HEIGHT);
    }
    return _deleteButton;
}


@end
