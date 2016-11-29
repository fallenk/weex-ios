//
//  ETKSkinCareBoardDetailControllerViewController.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/15.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "ETKSkinCareBoardDetailControllerViewController.h"

@interface ETKSkinCareBoardDetailControllerViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;

@end

@implementation ETKSkinCareBoardDetailControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"暴走详情";
    self.instance.viewController = self;
    self.instance.frame = CGRectMake(30, 20, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.instance renderWithURL:self.URL options:@{@"bundleUrl":self.URL.absoluteString} data:nil];
    
    __weak typeof(self) weakSelf = self;
    self.instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    self.instance.onFailed = ^(NSError *error) {
        NSLog(@"error:%@", error);
    };
    
    self.instance.renderFinish = ^(UIView *view) {
        NSLog(@"//处理页面渲染完成的逻辑。");
    };
}

- (void)dealloc {
    [_instance destroyInstance];
}

#pragma mark - Getter
- (WXSDKInstance *)instance {
    if (!_instance) {
        _instance = [WXSDKInstance new];
    }
    return _instance;
}


@end
