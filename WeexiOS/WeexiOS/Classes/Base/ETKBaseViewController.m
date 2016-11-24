//
//  ETKBaseViewController.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/11.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "ETKBaseViewController.h"

@interface ETKBaseViewController ()

@end

@implementation ETKBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (!([self isMemberOfClass:NSClassFromString(@"HomeViewController")]
              || [self isMemberOfClass:NSClassFromString(@"ETKSkinCareBoardController")]
              || [self isMemberOfClass:NSClassFromString(@"ETKSkinCareMessageController")]
              || [self isMemberOfClass:NSClassFromString(@"ETKProfileController")])) {
            //在跳转时自动隐藏tabBar
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局从导航栏下面开始布局
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 导航栏设置
    //设置背景
    self.navigationController.navigationBar.barTintColor = ETK_COLOR_THEME_PURPLE;
    //设置标题文字
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (self != [self.navigationController.viewControllers objectAtIndex:0]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_commonBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    }

}

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
