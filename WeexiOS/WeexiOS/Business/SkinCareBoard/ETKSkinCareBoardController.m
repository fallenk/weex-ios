//
//  ETKSkinCareBoardController.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/11.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "ETKSkinCareBoardController.h"

@interface ETKSkinCareBoardController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;

@end

@implementation ETKSkinCareBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self p_setUI];
    
}

- (void)p_setUI {
    self.title = @"颜值排行榜";
    
    
    [self p_initWeexView];
}

- (void)p_initWeexView {
    self.instance.viewController = self;
    self.instance.frame = CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT);
    NSString *fileName = @"skinCareBoard.we";
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.31.60:8081/%@",fileName]];
    [self.instance renderWithURL:URL options:@{@"bundleUrl" : URL.absoluteString} data:nil];
    
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
        NSLog(@"处理页面渲染完成的逻辑");
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
