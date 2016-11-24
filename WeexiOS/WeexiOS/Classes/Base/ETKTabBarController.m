//
//  ETKTabBarController.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/11.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "ETKTabBarController.h"
#import "ETKLoginViewController.h"

static ETKTabBarController *tabBarController;

@interface ETKTabBarController ()
<
UITabBarControllerDelegate
>

@end

@implementation ETKTabBarController

+ (instancetype)defaultTabBarController {
    if (!tabBarController) {
        tabBarController = [[ETKTabBarController alloc] init];
        //[_tabBarVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
        //设置tabBar文字颜色
        tabBarController.tabBar.tintColor = ETK_COLOR_THEME_PINK;
        tabBarController.delegate         = tabBarController;
        //设置TabBar的背景颜色，插入一个背景的view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT)];
        view.backgroundColor = [UIColor whiteColor];
        [tabBarController.tabBar insertSubview:view atIndex:0];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ETKTabBarInfo" ofType:@"plist"];
        NSArray <NSDictionary *>* tabBarVCArray = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray <UIViewController *>* tabBarInfosArray = [NSMutableArray arrayWithCapacity:tabBarVCArray.count];
        [tabBarVCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class cla = NSClassFromString(obj[@"controller"]);
            UIViewController *vc = [cla new];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.tabBarItem.image         = [[UIImage imageNamed:obj[@"icon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:obj[@"selectedIcon"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.title         = obj[@"title"];
            [tabBarInfosArray addObject:nav];
        }];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        tabBarController.viewControllers = [tabBarInfosArray copy];
    }
    return tabBarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
}


#pragma mark - TabBarControllerDelegate

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    
//}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController {
    NSString *className = NSStringFromClass([viewController.topViewController class]);
    if ([className isEqualToString:@"ETKSkinCareMessageController"]) {
//        if (![NSUserDefaults buk_valueWithKey:@"userToken"]) {
//            // have a trick
//            if (self.lastSelectdIndex == 3) {
//                self.lastSelectdIndex = 0;
//            }
//            
//            ETKLoginController *loginVC = [[ETKLoginController alloc] init];
//            loginVC.cancelLoginBlock = ^{
//                tabBarController.selectedIndex = self.lastSelectdIndex;
//            };
//            [viewController.topViewController presentViewController:loginVC animated:YES completion:nil];
//            return;
//        }
        ETKLoginViewController *loginVC = [[ETKLoginViewController alloc] init];
        [viewController.topViewController presentViewController:loginVC animated:YES completion:nil];
        return;
    
    }
    // 记录本次选择的 tab
    //self.lastSelectdIndex = tabBarController.selectedIndex;

    
}

@end
