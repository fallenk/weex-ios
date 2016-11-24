//
//  AppDelegate.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/10.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "AppDelegate.h"

#import <WeexSDK/WeexSDK.h>

#import "ETKTabBarController.h"
#import "ETKWeexImageDownLoader.h"
#import "ETKWeexJumpModule.h"
#import "ETKWeexAlertView.h"
#import "ETKLoginModule.h"

@interface AppDelegate ()
<
UITabBarControllerDelegate,
UITabBarDelegate
>

@property (nonatomic, strong) UITabBarController *tabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [ETKTabBarController defaultTabBarController];
    
    [self.window makeKeyAndVisible];
    
    [self p_initWeexSDK];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - initWeexSDK

- (void)p_initWeexSDK {
    [WXAppConfiguration setAppGroup:@"FallenK"];
    [WXAppConfiguration setAppName:@"WeexiOS"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    [WXSDKEngine initSDKEnviroment];
    
    [WXLog setLogLevel:WXLogLevelDebug];
    //register
    ///注册handler
    [WXSDKEngine registerHandler:[ETKWeexImageDownLoader new] withProtocol:@protocol(WXImgLoaderProtocol)];
    
    ///注册Component，自定义标签，链接
    [WXSDKEngine registerComponent:@"kfcustom-button" withClass:[ETKWeexAlertView class]];
    
    ///URL跳转使用,使用module(两步操作：1.url获取，2.push跳转)
    [WXSDKEngine registerModule:@"ETKWeexJumpModule" withClass:[ETKWeexJumpModule class]];
    ///URL跳转使用,使用module(两步操作：1.url获取，2.push跳转)
    [WXSDKEngine registerModule:@"ETKLoginModule" withClass:[ETKLoginModule class]];
    
}


#pragma mark - Getter

- (UITabBarController *)tabBarVC {
    if (!_tabBarVC) {
        _tabBarVC = [[UITabBarController alloc] init];
        _tabBarVC.delegate = self;
        //设置tabbar的背景颜色，插入一个背景UIView
        UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT)];
        view.backgroundColor = [UIColor whiteColor];
        [_tabBarVC.tabBar insertSubview:view atIndex:0];
    
        //取出plist中数据≥
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ETKTabBarInfo" ofType:@"plist"];
        NSArray <NSDictionary *>* tabBarInfoArray = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray <UIViewController *>* vcArray = [NSMutableArray arrayWithCapacity:tabBarInfoArray.count];
        //循环数据
        [tabBarInfoArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class cla = NSClassFromString(obj[@"controller"]);
            UIViewController *vc = [cla new];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.tabBarItem.image = [[UIImage imageNamed:obj[@"icon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:obj[@"selectedIcon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.title = obj[@"title"];
            [vcArray addObject:nav];
        }];
        //[_tabBarVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
        //设置tabBar文字颜色
        _tabBarVC.tabBar.tintColor = ETK_COLOR_THEME_PINK;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        _tabBarVC.viewControllers = [vcArray copy];
    }
    return _tabBarVC;
}




@end
