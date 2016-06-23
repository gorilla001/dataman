
#import "LoginViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

#import "HomeViewController.h"
#import "NewViewController.h"
#import "WarnViewController.h"

#import "Lockbox.h"

@interface LoginViewController ()
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *textBack;
@property (nonatomic, strong) UITextField *username;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *timerBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UITabBarController *tabbarController;
@end

@implementation LoginViewController

- (instancetype)init
{
    if (self = [super init]) {
      
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self configView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

- (void)configView
{
    self.view.backgroundColor = WHITE_COLOR;
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.logoView];
    [self.scrollView addSubview: self.textBack];
    [self.textBack addSubview:self.username];
    [self.textBack addSubview:self.timerBtn];
    [self.textBack addSubview:self.line];
    [self.textBack addSubview:self.password];
    [self.scrollView addSubview:self.submitBtn];
    [self.scrollView addSubview:self.changeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeToMainPage
{
    UINavigationController *home = [[UINavigationController alloc]initWithRootViewController:HomeViewController.new];
    
    UINavigationController *new = [[UINavigationController alloc] initWithRootViewController:NewViewController.new];
    
    
    
    UINavigationController *warn = [[UINavigationController alloc]initWithRootViewController:WarnViewController.new];
    
    NSArray *titles = @[@"服务", @"购物车", @"我的"];
    NSArray *images = @[@"home_unselected", @"cart_unselected", @"mine_unselected"];
    NSArray *selectimages = @[@"home_selected",@"cart_selected",@"mine_selected"];
    
    _tabbarController = [[UITabBarController alloc] init];
    
    _tabbarController.viewControllers = @[home,new,warn];
    [_tabbarController ew_configTabBarItemWithTitles:titles font:FONT(12) titleColor:RGB_COLOR(164, 162, 154) selectedTitleColor:RGB_COLOR(17,194, 88) images:images selectedImages:selectimages barBackgroundImage:nil];
    
    [self.navigationController pushViewController:_tabbarController animated:YES];
    
//    self.window.rootViewController = _tabbarController;
}


- (void)submit:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    if ([_username hasText] && [_password hasText]){
        
        [self showLoading];
        [HTTPManager login: [_username text]
                    passwd: [_password text]
                   success:^(id response) {
                       DBLog(@"%@", response);
                       [self hideLoading];
                       if ([response[@"code"] integerValue]){
                           [self showErrorStatusWithTitle:@"用户名或密码错误"];
                           
                       }
                       else{
                           [Lockbox archiveObject:[NSString stringWithFormat:@"%@", response[@"data"][@"token"]]
                                           forKey:@"token"];
                           [self changeToMainPage];
                       }
                       
                   } failure:^(NSError *err) {
                       [self hideLoading];
                       [self showFailureStatusWithTitle:@"服务器繁忙，请稍后重试"];
                   }];
        
    }else{
        if (! [_username hasText] || ! [_password hasText]){
          
            [self showErrorStatusWithTitle:@"用户名或密码不能为空"];
        }
}
    
    
   
    
    
    
    
   

//    [self showLoading];
    
    
}


- (void)clickLeftBarButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter
- (TPKeyboardAvoidingScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = CLEAR_COLOR;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = CLEAR_COLOR;
    }
    return _scrollView;
}

- (UIImageView *)backView
{
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        _backView.userInteractionEnabled = YES;
        _backView.image = [UIImage ew_imageWithContentOfFile:@"login_back@2x.png"];
    }
    return _backView;
}


- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2.0, 44, 150, 150)];
        _logoView.image = [UIImage imageNamed:@""];
    }
    return _logoView;
}

- (UIView *)textBack
{
    if (!_textBack) {
        _textBack = [[UIView alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT/2 - 50, SCREEN_WIDTH-30, 224/2.0)];
        _textBack.backgroundColor = WHITE_COLOR;
        _textBack.layer.borderColor = RGB_COLOR(206, 206, 206).CGColor;
        _textBack.layer.borderWidth = 1;
    }
    return _textBack;
}

- (UITextField *)username
{
    if (!_username) {
        _username = [[UITextField alloc] initWithFrame:CGRectMake(18, 0, 180, 56)];
        _username.font = FONT(15);
        _username.placeholder = @"输入用户名";
    }
    return _username;
}

- (UITextField *)password
{
    if (!_password) {
        _password = [[UITextField alloc] initWithFrame:CGRectMake(18, 56, self.textBack.width-36, 56)];
        _password.font = FONT(15);
        _password.placeholder = @"输入密码";
    }
    return _password;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(18, 56, self.textBack.width-36, 1)];
        _line.backgroundColor = RGB_COLOR(199, 199, 199);
    }
    return _line;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(15, self.textBack.bottom+15, SCREEN_WIDTH-30, 55);
        _submitBtn.backgroundColor = WHITE_COLOR;
        [_submitBtn setTitleColor:RGB_COLOR(48, 48, 48) forState:UIControlStateNormal];
        [_submitBtn setTitle:@"登录" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = BFONT(15);
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.borderColor = RGB_COLOR(206, 206, 206).CGColor;
        _submitBtn.layer.borderWidth = 1;
    }
    return _submitBtn;
}

@end
