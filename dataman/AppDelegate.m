//
//  AppDelegate.m
//  Lynp
//
//  Created by nmg on 16/2/2.
//  Copyright (c) 2016 nmg. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#import "AbnormalViewController.h"
#import "NormalViewController.h"
#import "WarningViewController.h"

#import "Lockbox.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self registRemoteNotification];
    [self registLocalNotification];
    
    [self changeToMainPage];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //update
        //[self appUpdate];

    });

    [[DBManager instance] createDB];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump:) name:@"JUMP" object:nil];
    
    return YES;
}

- (void)jump:(NSNotification *)noti {
    [self.tabbarController setSelectedIndex:0];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

    return YES;
}



#pragma mark - config
- (void)registRemoteNotification
{
}

- (void)registLocalNotification
{
}

- (void)changeToMainPage
{
    if ([Lockbox unarchiveObjectForKey:@"token"]){
        UINavigationController *abnormal = [[UINavigationController alloc]initWithRootViewController:AbnormalViewController.new];
    
        UINavigationController *normal = [[UINavigationController alloc] initWithRootViewController:NormalViewController.new];
    
        UINavigationController *warning = [[UINavigationController alloc]initWithRootViewController:WarningViewController.new];
    
        NSArray *titles = @[@"异常", @"正常", @"告警"];
        NSArray *images = @[@"abnormal_unselected", @"normal_unselected", @"warning_unselected"];
        NSArray *selectimages = @[@"abnormal_selected",@"normal_selected",@"warning_selected"];
    
        _tabbarController = [[UITabBarController alloc] init];
    
        _tabbarController.viewControllers = @[abnormal,normal,warning];
        [_tabbarController ew_configTabBarItemWithTitles:titles font:FONT(12) titleColor:RGB_COLOR(164, 162, 154) selectedTitleColor:RGB_COLOR(17,194, 88) images:images selectedImages:selectimages barBackgroundImage:nil];
    
        self.window.rootViewController = _tabbarController;
    }else{
        UINavigationController *navLogin = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
        
        self.window.rootViewController = navLogin;
    }
}

@end
