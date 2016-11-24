//
//  ETKWeexAlertView.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/15.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "ETKWeexAlertView.h"

@interface ETKWeexAlertView ()

@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic, strong) UIButton *innerButton;


@end

@implementation ETKWeexAlertView

///继承父类，Initializes a new component using the specified  properties
- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance {
    self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance];
    if (self) {
        _alertTitle = [WXConvert NSString:attributes[@"title"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.innerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.innerButton.frame = self.view.bounds;
    self.innerButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.innerButton];
    [self.innerButton setTitle:self.alertTitle forState:UIControlStateNormal];
    [self.innerButton addTarget:self action:@selector(p_onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)p_onButtonClick:(UIButton *)sender {
    NSLog(@"p_onButtonClick");
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Weex回传的字符串" message:self.alertTitle delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end
